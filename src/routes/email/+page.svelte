<script>
	export let data;
  export let form;

  let jsondata, email, send, nodeId, szn;

  $: d = function () {
    jsondata = (data?.data?.data) || "{}";
    email = data?.data?.email || "";
    send = data?.data?.send || false;
    nodeId = data?.data?.nodeId || null;
    szn = data?.data?.szn || "chyba konfigurace";
    return data.data;
  }(data);
</script>

<h1>Emailing</h1>

<form action="?/save" method="POST">
  <input name="nodeId" type="hidden" value={nodeId} />

  <fieldset>
    <legend>Email adresa kam poslat test mail</legend>
    <input name="email" type="text" value={email} />
  </fieldset>

  <fieldset>
    <legend>Odesílat email v periodickem volani</legend>
    <input name="send" type="checkbox" checked={send} />
  </fieldset>

  <fieldset>
    <legend>Dopňková JSON data</legend>
    <textarea name="data" value={jsondata} rows=10 />
  </fieldset>

  <br />
  <input class="btn" type="submit" value="Ulož změny" />
</form>

<br /><br />
<p>Email bude odeslan skrze Seznam Email ucet {szn}.</p>
<br />
<form action="?/send" method="POST">  
  <input class="btn" type="submit" value="Odešli email" />
</form>



<pre>{JSON.stringify(form, undefined, 4)}</pre>

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
input, textarea {
  width: 100%;
}
input.readonly {
  background-color: silver;
}
</style>
