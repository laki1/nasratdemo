<script>
	import { Heading, Img, Button, Hr, Html, Text } from 'svelte-email';

	export let jsondata = '{}';

    const _jsondata = JSON.parse(jsondata);
    
    const preformatted = {
		fontFamily: "monospace",
		fontSize: '18px',
        whiteSpace: "pre",
		color: '#44444'
	};
</script>

<Html lang="en">
	<Heading as="h1">Nasratdemo test email</Heading>
    <Text>
		Testovaci email
	</Text>
	
    <Hr />

    <Text style={preformatted}>{JSON.stringify(_jsondata, undefined, 4)}</Text>
    
    <Hr />

	<Button href="https://ttpdev.steiner.cz" style={{ color: '#61dafb' }}>
        Ověřit účet
    </Button>
    
    <Hr />

    <Img
	    src="https://motovidlo.s3.eu-west-3.amazonaws.com/data/temp/themes/products/1/5/9/1/8/polstar-nasrat_sw2wtbv4en-r-600-600-255-255-255.webp?v=1661204045"
	    alt="Nasrat image"
	    width="600"
	    height="561"
    />
</Html>