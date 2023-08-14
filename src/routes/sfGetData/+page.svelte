<script>
	export let data;
  export let form;
  let cislo = null, odpoved;

	$: d = data.data;

  $: console.warn(d, form);
  
  odpoved = data?.data?.sfGetData?.value || "---error---";
  cislo = form?.data?.cislo;

</script>

<h1>SfGetData GQL on server</h1>


<fieldset>
  <legend>Vrácená odpověď z databáze</legend>
  <input class="readonly" name="odpoved" type="text" readonly="readonly" value={odpoved} />
</fieldset>

<br /><br />

<form method="POST">
  <fieldset>
    <legend>Zadej číslo</legend>
    <input name="cislo" type="text" bind:value={cislo} />
  </fieldset>
  <br />
  <input class="btn" type="submit" value="Prožeň číslo databází" />
</form>

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
input {
  width: 100%;
}
input.readonly {
  background-color: silver;
}
</style>