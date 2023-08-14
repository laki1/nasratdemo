<script>
  export let data;
</script>

<h1>Login test</h1>

{#if !data.user}
  <form action="?/login" method="POST">
    <input name="loginname" type="hidden" value="Petr" />
    <input name="password" type="hidden" value="petr" />
    <input class="btn" type="submit" value="Přihlásit se jako Petr" />
  </form>

  <br /><br />

  <form action="?/login" method="POST">
    <input name="loginname" type="hidden" value="Pavel" />
    <input name="password" type="hidden" value="pavel" />
    <input class="btn" type="submit" value="Přihlásit se jako Pavel" />
  </form>

{:else}
  
  <form action="?/logout" method="POST">  
    <input class="btn" type="submit" value="Odhlásit se" />
  </form>

{/if}

<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<hr />
<h2>DEBUG INFO</h2>
<pre>{JSON.stringify(data, undefined, 4)}</pre>
