__author__ = "Jonas Almlöf and Magdalena"
__copyright__ = "Copyright 2024, Uppsala Universitet"
__email__ = "jonas.almlof@scilifelab.uu.se"
__license__ = "GPL-3"


rule samtools_index:
    input:
        bam="{file}.bam",
    output:
        bai=temp("{file}.bam.bai"),
    params:
        extra=config.get("extra", {}).get("extra", ""),
    log:
        "{file}.bam.bai.log",
    benchmark:
        repeat(
            "{file}.bam.bai.benchmark.tsv",
            config.get("samtools_index", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("samtools_index", {}).get("threads", config["default_resources"]["threads"])
    resources:
        mem_mb=config.get("samtools_index", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("samtools_index", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("samtools_index", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("samtools_index", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("samtools_index", {}).get("time", config["default_resources"]["time"]),
    container:
        config.get("samtools_index", {}).get("container", config["default_container"])
    message:
        "{rule}: index {input.bam}"
    wrapper:
        "v1.3.1/bio/samtools/index"


rule samtools_fastq_single:
    input:
        query="alignment/minimap2/{sample}_{type}_{processing_unit}_{barcode}.bam",
    output:
        fastq="long_read/hifiasm/{sample}_{type}_{processing_unit}_{barcode}.s2fq.fastq.gz",
    log:
        "long_read/hifiasm/{sample}_{type}_{processing_unit}_{barcode}.interleaved.log",
    message:
        "Extracting fastq reads from BAM file, single end. For PE use alignment/samtools_fastq."
    # Samtools takes additional threads through its option -@
    threads: config.get("make_fastq", {}).get("threads", config["default_resources"]["threads"])  # This value - 1 will be sent to -@
    resources:
        partition=config.get("make_fastq", {}).get("partition", config["default_resources"]["partition"]),
        time=config.get("make_fastq", {}).get("time", config["default_resources"]["time"]),
        threads=config.get("make_fastq", {}).get("threads", config["default_resources"]["threads"]),
        mem_per_cpu=config.get("make_fastq", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
    container:
        config.get("samtools_index", {}).get("container", config["default_container"])
    params:
        extra="",
    shell:
        """
        (samtools fastq {params.extra}  {input} > {output}) &> {log}
        """
