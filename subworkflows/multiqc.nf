/*
*  multiqc module
*/

// Parameter definitions
params.CONTAINER = "quay.io/biocontainers/multiqc:1.9--pyh9f0ad1d_0"
params.OUTPUT = "multiqc_output"

process multiqc {

    // where to store the results and in which way
    publishDir(params.OUTPUT, mode: 'copy')

    // indicates to use as a container the value indicated in the parameter
    container params.CONTAINER

    input:
    path (inputfiles)

    output:
    path "multiqc_report.html"

    script:
    """
         multiqc .
    """
}
