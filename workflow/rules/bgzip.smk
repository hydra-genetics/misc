
rule bgzip:
    input:
        "{file}",
    output:
        temp("{file}.gz"),
    log:
        "{file}.gz.log",
    benchmark:
        repeat("{file}.gz.benchmark.tsv", config.get("bgzip", {}).get("benchmark_repeats", 1))
    threads: config.get("bgzip", config["default_resources"]).get("threads", config["default_resources"]["threads"])
    container:
        config.get("bgzip", {}).get("container", config["default_container"])
    conda:
        "../envs/bgzip.yaml"
    message:
        "{rule}: Bgzip {wildcards.file}"
    shell:
        "(bgzip -c {input} > {output}) &> {log}"
