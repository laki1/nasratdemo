import { loginUser, logoutUser } from "$lib/server/auth"
import { redirect } from '@sveltejs/kit';

/* @type { import('./$houdini').PageServerLoad } */
export const load = async (event) => {
	return { data: {} }
}

/** @type {import('./$types').Actions} */
export const actions = {
    login: async (event) => {
		const formdata = await event.request.formData();
        const loginname = formdata.get('loginname');

		await loginUser(event, loginname);
		throw redirect(302, '/login');
    },
    logout: async (event) => {
        await logoutUser(event);
        throw redirect(302, '/login');
    }    
};
