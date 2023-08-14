import { sveltekit } from '@sveltejs/kit/vite'
import houdini from 'houdini/vite'
import { defineConfig } from 'vite'

export default defineConfig({
	plugins: [houdini(), sveltekit()],	
	server: {
		host: "192.168.10.40",
		port: 5173,
		fs: {
		  	strict: true,
			allow: ['..']
		}
	}
});
