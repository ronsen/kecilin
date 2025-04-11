<script>
	import { page, Link, inertia } from "@inertiajs/svelte";
	import { Code } from "lucide-svelte";
	import Alert from "../Components/Alert.svelte";
	import Theme from "../Components/Theme.svelte";

	let { children } = $props();
</script>

<main class="mx-auto max-w-2xl my-6 px-6 md:my-12">
	<nav
		class="flex justify-between items-center border-b dark:border-zinc-700 pb-2 mb-8"
	>
		<h1 class="font-bold">
			<Link href="/">{$page.props.appName}</Link>
		</h1>

		<Theme />
	</nav>

	{#if $page.props.flash.message}
		<Alert>{@html $page.props.flash.message}</Alert>
	{/if}

	{@render children()}

	<div class="mt-6 border-t dark:border-zinc-700 text-xs py-2">
		<div class="flex justify-between items-center gap-3">
			<a href="https://dub.sh/ronsen" target="_blank"
				>Dibuat oleh Ronsen</a
			>
			<a href="https://github.com/ronsen/kecilin" target="_blank"
				><Code size={14} /></a
			>
		</div>
	</div>
</main>
