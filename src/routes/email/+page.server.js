import { redirect } from '@sveltejs/kit';
import { GetFirstEmailingStore, ChangeEmailingStore } from '$houdini';
import { render } from 'svelte-email';
import Hello from '$lib/emails/Hello.svelte';
import nodemailer from 'nodemailer';
import { SEZNAM_EMAIL_LOGIN, SEZNAM_EMAIL_PASSWORD } from '$env/static/private'
import logger from '~/logger';

/* @type { import('./$houdini').PageServerLoad } */
export const load = async (event) => {
    let data = await loadData(event);
    const url = event.request.url;
    data.magic = url.includes("magic=123");
    data.url = url;
    data.szn = SEZNAM_EMAIL_LOGIN;

    if (data.magic) {
        logger.info('Pokus o automaticke odeslani emailu');
        if (data.send === true) {
            logger.info('Odeslani automatickeho emailu je povoleno, posilam...');
            sendEmail( data.email, data.data );        
        }
    }

    return { data: data }
}

/** @type {import('./$types').Actions} */
export const actions = {
    magic: async (event) => {
        return { data: {magic: true} }
    },
    send: async (event) => {    
        let data = await loadData(event);

        sendEmail( data.email, data.data );
        throw redirect(303, '/email');
        return { data: "email sent" };        
    },
    save: async (event) => {

        const formdata = await event.request.formData();
        const email = formdata.get('email');
        const send = (formdata.get('send') === "on") ? true : false;
        const d = formdata.get('data');
        const nodeId = formdata.get('nodeId');

        const myMutate = new ChangeEmailingStore();
        
        const { data } = await myMutate.mutate({
            "nodeId": nodeId,
            "send": send,
            "email": email,
            "data": d
        }, { event  });
		
        return { data: (data) ? data : "error" }
    }
};


function sendEmail( to, jsondata ) {

    const transporter = nodemailer.createTransport({
        host: 'smtp.seznam.cz',
        port: 465,
        secure: true,
        auth: {
            user: SEZNAM_EMAIL_LOGIN,
            pass: SEZNAM_EMAIL_PASSWORD
        }
    });
    
    const emailHtml = render({
        template: Hello,
        props: {
            jsondata: jsondata
        }
    });

    const options = {
        from: SEZNAM_EMAIL_LOGIN,
        to: to,
        subject: 'NASRATDEMO testmail',
        html: emailHtml
    };

    transporter.sendMail(options);
};

const loadData = async (event) => {
    const myQuery = new GetFirstEmailingStore()
    let { data } = await myQuery.fetch({ event })

    data = (data) ? data?.allEmailings?.nodes[0] : {}
    return data;
}
