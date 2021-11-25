.. _third-page:

*******************
The Nextflow language
*******************

The main file
==============

We can use GitPod for looking at the code, go to workplace and load the **main.nf** file.

.. literalinclude:: ../main.nf
   :language: groovy



The params.config file
=======================

This file contains the definition of the pipeline parameters with some default values. They can be overridden by using **two hyphens** (as ``--reads`` or ``--reference`` etc).

.. literalinclude:: ../params.config
   :language: groovy

   

