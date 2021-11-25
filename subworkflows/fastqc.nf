/*
*  Fastqc module.
*/

// Parameter definitions
params.CONTAINER = "quay.io/biocontainers/fastqc:0.11.9--0"
params.OUTPUT = "fastqc_output"

process fastqc {
    
    // where to store the results and in which way
    publishDir(params.OUTPUT, mode: 'copy') 

    // indicates to use as container the value indicated in the parameter
    container params.CONTAINER

    // show in the log which input file is analysed
    tag "${reads}" 
    
    input:
    path(reads)

    output:
    path("*_fastqc*")

    script:
    """
        fastqc ${reads}
    """
}
