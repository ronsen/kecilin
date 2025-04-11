<script module>
	export { default as layout } from "./Layouts/App.svelte";
</script>

<script>
	import { page } from "@inertiajs/svelte";
	import { useForm } from "@inertiajs/svelte";

	const form = useForm({
		file: null,
	});

	function show(e) {
		const image = URL.createObjectURL(e.target.files[0]);
		const preview = document.querySelector("#preview");
		preview.setAttribute("src", image);
	}

	function submit(e) {
		e.preventDefault();
		$form.post("/upload");
	}
</script>

<svelte:head>
	<title>{$page.props.appName}</title>
</svelte:head>

<form onsubmit={submit} accept="image/jpeg">
	<div class="mb-3">
		<img id="preview" src="./blank.png" alt="Preview" class="w-full mb-3" />

		<input
			type="file"
			oninput={(e) => ($form.file = e.target.files[0])}
			onchange={(e) => show(e)}
			class="w-full"
		/>

		{#if $form.progress}
			<div class="mt-1">
				<progress value={$form.progress.percentage} max="100">
					{$form.progress.percentage}%
				</progress>
			</div>
		{/if}
	</div>
	<button
		type="submit"
		class="bg-blue-500 hover:bg-blue-600 text-white w-full p-3 rounded-full"
		>Kecilin</button
	>
</form>
