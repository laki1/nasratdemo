/// <references types="houdini-svelte">

/** @type {import('houdini').ConfigFile} */
const config = {
    "watchSchema": {
        "url": "http://127.0.0.1:5000/graphql"
    },
    "plugins": {
        "houdini-svelte": {}
    },
    "defaultCachePolicy": "NetworkOnly",
    //"defaultPaginateMode": "SinglePage",
    "defaultListPosition": "first"
}

export default config
