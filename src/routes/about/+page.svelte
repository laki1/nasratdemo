<script>
	export let data;
</script>

<svelte:head>
	<title>About</title>
	<meta name="description" content="About this app" />
</svelte:head>

<div class="text-column">
	<h1>Nasratdemo app</h1>

	<p>
		Test pouzitych technologii pro upiri trziste.
	</p>

	<p>
		{#if data.user}
			Přihlášený uživatel
		{:else}
			Nepřihlášený uživatel
		{/if}
	</p>
</div>
