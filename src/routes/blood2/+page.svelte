<script>    
    /* @type { import('./$houdini').PageData } */
    export let data;
    
    $: ({ BloodList2 } = data)

	$: console.warn("pageInfo", $BloodList2.pageInfo);
	$: console.warn("data", data);
	$: console.warn("BloodList2", $BloodList2);
	$: console.warn("hasNext", $BloodList2.hasNextPage);


	async function getNext() {
		console.warn("getNext before");
		let x = await BloodList2.loadNextPage();		
		console.warn("getNext after", $BloodList2.data);
	}

</script>


{#if !$BloodList2.fetching}
	<h1>Blood 2 - GQL paginate</h1>

	{#if $BloodList2.pageInfo.hasPreviousPage}
		<button on:click={async () => await BloodList2.loadPreviousPage()}>
    		load prev
		</button>
	{/if}

	<table>
		<tr>
			<th>render</th>
			<th>ID</th>
			<th>Označení</th>
		</tr>
		{#each $BloodList2.data.allVBloods.edges as egde}
		<tr>			
			<td>{Date.now()}</td>
			<td>{egde.node.id}</td>
			<td>{egde.node.name}</td>
		</tr>
		{/each}
	</table>

	{#if $BloodList2.pageInfo.hasNextPage}
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
<pre>{JSON.stringify($BloodList2, undefined, 4)}</pre>

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
