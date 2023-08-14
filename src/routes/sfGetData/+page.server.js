import { sfGetDataStore } from '$houdini'

let cislo = null;

/* @type { import('./$houdini').PageServerLoad } */
export const load = async (event) => {
    const myMutate = new sfGetDataStore()
    const { data } = await myMutate.mutate({ "cislo": cislo }, { event });

    return { data: (data) ? data : "error" }
}

/** @type {import('./$types').Actions} */
export const actions = {
    default: async ({ cookies, request }) => {        
        const data = await request.formData();
        cislo = data.get('cislo');
        
        return { "cislo": cislo };
    }
};