__author__ = "Jonas Almlöf"
__copyright__ = "Copyright 2021, Jonas Almlöf"
__email__ = "jonas.almlof@scilifelab.uu.se"
__license__ = "GPL-3"


rule samtools_index:
    input:
        "{file}.bam",
    output:
        "{file}.bam.bai",
    log:
        "{file}.bam.bai.log",
    benchmark:
        repeat(
            "{file}.bam.bai.benchmark.tsv",
            config.get("samtools_index", {}).get("benchmark_repeats", 1),
        )
    container:
        config.get("samtools_index", {}).get("container", "default_container")
    message:
        "{rule}: Index {wildcards.file} bam file"
    shell:
        "samtools index "
        "-b {input} "
        "{output} &> {log}"
