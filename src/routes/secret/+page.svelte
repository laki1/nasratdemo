<script>
  import { page } from '$app/stores'
  export let data;
</script>

<h1>Secret page</h1>

<p>Lze zobrazit jen pokud je uzivatel prihlaseny</p>

<form action="/login?/logout" method="POST">  
  <input class="btn" type="submit" value="Odhlásit se" />
</form>

<br /><br />

{#if data.data}
  <h2>Logs</h2>
  <ul>
  {#each data.data as filename}
    <li><a href={filename} target="_blank">{filename}</a></li> 
  {/each}
  </ul>
{/if}

<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<hr />
<h2>DEBUG INFO</h2>
<pre>{JSON.stringify(data, undefined, 4)}</pre>
