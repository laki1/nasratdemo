import { HoudiniClient } from '$houdini';

export default new HoudiniClient({
    url: 'http://192.168.10.40:5500/graphql'

    // uncomment this to configure the network call (for things like authentication)
    // for more information, please visit here: https://www.houdinigraphql.com/guides/authentication
    // fetchParams({ session }) { 
    //     return { 
    //         headers: {
    //             Authentication: `Bearer ${session.token}`,
    //         }
    //     }
    // }
})
