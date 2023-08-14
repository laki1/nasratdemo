import { GetAllKellsStore } from '$houdini'

/* @type { import('./$houdini').PageServerLoad } */
export const load = async (event) => {
    const myQuery = new GetAllKellsStore()
    const { data } = await myQuery.fetch({ event })

    return { data: (data) ? data?.allVKells?.nodes : [] }
}
