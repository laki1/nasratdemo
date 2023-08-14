<script>    
	import { graphql } from '$houdini';
	import { onMount } from 'svelte';

	//query BloodList @cache(partial: true) {
	let loaded = false;
	const BloodList = graphql(`
    	query BloodList3 {
			allVBloods(first: 5) @paginate(mode: SinglePage) {
				edges {
					node {
						id
						name
					}
					cursor
				}    
			}
		}
    `);
	

	onMount(async () => {
    	await BloodList.fetch();
		loaded = true;
  	});

	$: console.warn("pageInfo", $BloodList.pageInfo);
	$: console.warn("data", $BloodList);
	$: console.warn("hasNext", $BloodList?.data?.allVBloods?.pageInfo?.hasPreviousPage);


	async function getNext() {
		console.warn("getNext before");
		await BloodList.loadNextPage();
		console.warn("getNext after");
	}

</script>

{#if !$BloodList.fetching && loaded}
	<h1>Blood 3 - GQL paginate on client</h1>

	{#if $BloodList.pageInfo.hasPreviousPage}
		<button on:click={async () => await BloodList.loadPreviousPage()}>
    		load prev
		</button>
	{/if}

	<table>
		<tr>
			<th>render</th>
			<th>ID</th>
			<th>Označení</th>
		</tr>
		{#each $BloodList.data.allVBloods.edges as egde}
		<tr>
			<td>{Date.now()}</td>
			<td>{egde.node.id}</td>
			<td>{egde.node.name}</td>
		</tr>
		{/each}	
	</table>

	{#if $BloodList.pageInfo.hasNextPage}
		<button on:click={getNext}>
    		load next
		</button>
	{/if}
{:else}
	<h2>Loading...</h2>
{/if}

<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<hr />
<h2>DEBUG INFO</h2>
<pre>{JSON.stringify($BloodList, undefined, 4)}</pre>

<style>
	table {
	  border: 1px solid #ccc;
	  border-collapse: collapse;
	  margin: 0;
	  padding: 0;
	  width: 100%;
	  table-layout: fixed;
	}
	
	table caption {
	  font-size: 1.5em;
	  margin: .5em 0 .75em;
	}
	
	table tr {
	  background-color: #f8f8f8;
	  border: 1px solid #ddd;
	  padding: .35em;
	}
	
	table th,
	table td {
	  padding: .625em;
	  text-align: center;
	}
	
	table th {
	  font-size: .85em;
	  letter-spacing: .1em;
	  text-transform: uppercase;
	}
</style>
