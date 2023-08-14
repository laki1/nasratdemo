import { redirect } from '@sveltejs/kit';

export const load = async (event) => {	
	let user = await event.locals.user;
	
	if (!user) {
		throw redirect(302, '/login')
	}
	return {
		user: event.locals.user,
		secret: true
	}
}