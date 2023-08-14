import logger from '~/logger';
import { dev } from "$app/environment";

const TOKEN = "usertoken";

export const authenticateUser = async (event) => {
	const { cookies } = event;
	const userToken = cookies.get("auth");

	if (userToken && userToken.startsWith(TOKEN)) {
		const user = {
			name: userToken.substring(TOKEN.length) || "nasrat"
		}
		return user;
	}

	return null;
};

export const loginUser = async (event, loginname) => {
	let token = TOKEN + (loginname || "");

	logger.info('Prihlasil se uzivatel ' + loginname);

	event.cookies.set("auth", token, {
		path: "/",
		httpOnly: true,
		maxAge: 60 * 60 * 24 * 7,
		secure: dev ? false : true,
		sameSite: "strict"
	})
};

export const logoutUser = async (event) => {
	logger.info('Odhlaseni uzivatele');

	event.cookies.delete("auth");
};
