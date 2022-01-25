__author__ = "Martin Rippin"
__copyright__ = "Copyright 2022, Martin Rippin"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule bedtools_intersect:
    input:
        left="{module}/{caller}/{file}.vcf",
        right=lambda wildcards: config.get(wildcards.caller, {}).get("bed_files", {}).get(wildcards.bed, ""),
    output:
        vcf=temp("{module}/{caller}/{file}.{bed}.vcf"),
    params:
        extra=config.get("bedtools_intersect", {}).get("extra", ""),
    log:
        "{module}/{caller}/{file}.{bed}.vcf.log",
    benchmark:
        repeat(
            "{module}/{caller}/{file}.{bed}.vcf.benchmark.tsv",
            config.get("bedtools_intersect", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("bedtools_intersect", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("bedtools_intersect", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("bedtools_intersect", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("bedtools_intersect", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("bedtools_intersect", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("bedtools_intersect", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("bedtools_intersect", {}).get("container", config["default_container"])
    conda:
        "../envs/bedtools_intersect.yaml"
    message:
        "{rule}: Filter {wildcards.module}/{wildcards.caller}/{wildcards.file} with {wildcards.bed} bed-file"
    wrapper:
        "0.85.0/bio/bedtools/intersect"
