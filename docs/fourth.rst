.. _fourth-page:

*******************
The Nextflow subworkflows and modules
*******************

We can have a look at the different modules and sub-workflows files in the **subworkflows** folder.

FastQC
==========

.. literalinclude:: ../subworkflows/fastqc.nf
   :language: groovy


multiQC
==========

.. literalinclude:: ../subworkflows/multiqc.nf
   :language: groovy
   
Bowtie
==========

The **subworkflows/bowtie.nf** file contains the modules **Align** and **Index** and the sub-workflow **BOWTIE** 

.. literalinclude:: ../subworkflows/bowtie.nf
   :language: groovy
