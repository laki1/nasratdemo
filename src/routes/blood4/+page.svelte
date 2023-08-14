<script>    
	import { graphql } from '$houdini';
	import { onMount } from 'svelte';

	//query BloodList @cache(partial: true) {
	let loaded = false;
	const BloodList = graphql(`
    	query BloodList4 {
			allVBloods(first: 3) @paginate(mode: Infinite) {
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


	async function getNext() {
		console.warn("getNext before");
		await BloodList.loadNextPage();
		console.warn("getNext after");
	}

</script>

{#if !$BloodList.fetching && loaded}
	<h1>Blood 4 - GQL infinity on client</h1>

	<table>
		<tr>
			<th>render</th>
			<th>číslo řádku</th>
			<th>ID</th>
			<th>Označení</th>
		</tr>
		{#each $BloodList.data.allVBloods.edges as egde, no}
		<tr>
			<td>{Date.now()}</td>
			<td>{no+1}</td>
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
