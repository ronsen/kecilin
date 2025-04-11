<script module>
	export { default as layout } from "./Layouts/App.svelte";
</script>

<script>
	import { page } from "@inertiajs/svelte";
	import { useForm } from "@inertiajs/svelte";

	const form = useForm({
		file: null,
		scale: 100,
		quality: 76,
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
	<div class="mb-4">
		<img id="preview" src="./blank.png" alt="Preview" class="w-full mb-4" />

		<input
			type="file"
			oninput={(e) => ($form.file = e.target.files[0])}
			onchange={(e) => show(e)}
			class="w-full"
		/>
		<p class="text-xs mt-1">Max size: 20 MB</p>

		{#if $form.progress}
			<div class="mt-1">
				<progress value={$form.progress.percentage} max="100">
					{$form.progress.percentage}%
				</progress>
			</div>
		{/if}
	</div>
	<div class="grid grid-cols-3 items-start gap-4">
		<div class="flex flex-col">
			<input
				type="number"
				bind:value={$form.scale}
				min="0"
				max="100"
				class="form-input rounded-lg dark:text-white text-black bg-white dark:bg-black"
			/>
			<p class="text-xs mt-1">Scale (%)</p>
		</div>
		<div class="flex flex-col">
			<input
				type="number"
				bind:value={$form.quality}
				min="0"
				max="100"
				class="form-input rounded-lg dark:text-white text-black bg-white dark:bg-black"
			/>
			<p class="text-xs mt-1">Quality (%)</p>
		</div>
		<button
			type="submit"
			class="bg-blue-500 hover:bg-blue-600 text-white w-full px-3 py-2 rounded-full"
			>Kecilin</button
		>
	</div>
</form>
