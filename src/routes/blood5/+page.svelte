<script>    
    /* @type { import('./$houdini').PageData } */
    export let data;
    
    $: ({ BloodList5 } = data)

	$: console.warn("pageInfo", $BloodList5.pageInfo);
	$: console.warn("data", data);
	$: console.warn("BloodList5", $BloodList5);
	$: console.warn("hasNext", $BloodList5.hasNextPage);
</script>


{#if !$BloodList5.fetching}
	<h1>Blood 5 - GQL infinity</h1>

	{#if $BloodList5.pageInfo.hasPreviousPage}
		<button on:click={async () => await BloodList5.loadPreviousPage()}>
    		load prev
		</button>
	{/if}

	<table>
		<tr>
			<th>render</th>
			<th>číslo řádku</th>
			<th>ID</th>
			<th>Označení</th>
		</tr>
		{#each $BloodList5.data.allVBloods.edges as egde, no}
		<tr>			
			<td>{Date.now()}</td>
			<td>{no+1}</td>
			<td>{egde.node.id}</td>
			<td>{egde.node.name}</td>
		</tr>
		{/each}
	</table>

	{#if $BloodList5.pageInfo.hasNextPage}
		<button on:click={async () => await BloodList5.loadNextPage()}>
    		load next
		</button>
	{/if}
{:else}
	<h2>Loading...</h2>
{/if}

<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<hr />
<h2>DEBUG INFO</h2>
<pre>{JSON.stringify($BloodList5, undefined, 4)}</pre>

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

