<script>
	export let data;

	$: kells = data.data;
</script>

<h1>Kell GQL on server</h1>

<table>
	<tr>
		<th style="width: 10%;">ID</th>
		<th>Kell</th>
		<th>popis</th>
	</tr>
{#each kells as kell}
	<tr>
		<td>{kell.id}</td>
		<td>{kell.abbrev}</td>
		<td>{kell.note}</td>
	</tr>
{/each}
</table>


<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<hr />
<h2>DEBUG INFO</h2>
<pre>{JSON.stringify(data, undefined, 4)}</pre>

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