<script>    
    /* @type { import('./$houdini').PageData } */
    export let data;
    
    $: ({ Blood } = data)

	$: console.warn(Blood.paginated, Blood.loadNextPage);

</script>

{#if !$Blood.fetching}
	<h1>Blood groups GQL (Total count: {$Blood.data.allVBloods.totalCount})</h1>
	
	<table>
		<tr>
			<th>číslo řádku</th>
			<th style="width: 10%;">ID</th>
			<th>Označení</th>
		</tr>
		{#each $Blood.data.allVBloods.nodes as node, no}
		<tr>
			<td>{no+1}</td>
			<td>{node.id}</td>
			<td>{node.name}</td>
		</tr>
	{/each}
	</table>
{:else}
	<h2>Loading...</h2>
{/if}

<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<hr />
<h2>DEBUG INFO</h2>
<pre>{JSON.stringify($Blood, undefined, 4)}</pre>

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
