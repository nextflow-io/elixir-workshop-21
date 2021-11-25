.. _fourth-page:

*******************
The Nextflow config file
*******************

The information about the resources needed, the scheduler used and the container options can be stored within the **nextflow.config** file.
In this file we just include a number of single configuration files, each one for a different profile for different executors. 

.. literalinclude:: nextflow.config
   :language: groovy

Here you the single config files that are included by the main one and used depending on the different Nextflow parameter ``-profile`` 

Standard (default)
=======================

.. literalinclude:: ../conf/standard.config
   :language: groovy   

SGE
========
You can activate using this command line:

.. code-block:: console

  nextflow run lucacozzuto/elixir_NF -r main -profile hpc_sge -with-docker

.. literalinclude:: ../conf/sge.config
   :language: groovy

SLURM
========
You can activate using this command line:

.. code-block:: console

  nextflow run lucacozzuto/elixir_NF -r main -profile hpc_slurm -with-docker

.. literalinclude:: ../conf/slurm.config
   :language: groovy
   

AWS BATCH
=============
You can activate using this command line:

.. code-block:: console

  nextflow run lucacozzuto/elixir_NF -r main -profile cloud -with-docker

.. literalinclude:: ../conf/awsbatch.config
   :language: groovy
