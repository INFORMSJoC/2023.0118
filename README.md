### ![INFORMS Journal on Computing Logo](https://INFORMSJoC.github.io/logos/INFORMS_Journal_on_Computing_Header.jpg)

# A FAST Method for Nested Estimation

This archive is distributed in association with the [INFORMS Journal on
Computing](https://pubsonline.informs.org/journal/ijoc) under the [MIT License](LICENSE).

The software and data in this repository are a snapshot of the software and data that were used in the research reported on in the paper [A FAST Method for Nested Estimation](https://doi.org/10.1287/ijoc.2023.0118) by Guo Liang, Jun Luo and Kun Zhang.

## Cite

To cite the contents of this repository, please cite both the paper and this repo, using their respective DOIs.

http://doi.org/10.1287/ijoc.2023.0118

http://doi.org/10.1287/ijoc.2023.0118.cd

Below is the BibTex for citing this snapshot of the repository.

```
@article{Liang2024FAST,
  author =        {Guo Liang, Jun Luo, and Kun Zhang},
  publisher =     {INFORMS Journal on Computing},
  title =         {A FAST Method for Nested Estimation},
  year =          {2024},
  doi =           {10.1287/ijoc.2023.0118.cd},
  note =          {Available for download at https://github.com/INFORMSJoC/2023.0118},
}  
```

## Description

The goal of this software is to demonstrate the effect of the jackkniFe-bAsed neSted simulaTion (FAST) method proposed in "A FAST Method for Nested Estimation" by Guo Liang, Jun Luo and Kun Zhang. 



Nested estimation involves estimating an expectation of a function of a conditional expectation, and has many important applications in operations research and machine learning. However, the mean squared error (MSE) of the standard nested simulation (SNS) is only of order $\Gamma^{-2/3}$, where $\Gamma$ is the total simulation budget. Our proposed FAST method improves the convergence speed to $\Gamma^{-4/5}$.

## Codes

The programming language is Matlab. The folder `src` provides all the codes for the numerical experiments in the original paper. Specifically, under this file path,

- Folder `3Barrier_Jack_Boot` includes the methods `SNS` , `FAST` and `2-FAST` for Example 1 of the paper.

- Folder `3Barrier_Regression` includes the least-squares method (LSM) for Example 1 of the paper.

- Folder `3Barrier_adaptive_nonuniform` includes the nested sequential simulation (NSS) for Example 1 of the paper.

- Folder `Expected_Information_Gain` includes the `FAST` method for Example 2 of the paper.

- Folder `TrueValue_3Barrier_Option` provides the true value for Example 1 of the paper.

- Folder `Figure_Generate` helps us generate the figures in the paper.

  Each folder contains a README.md file for more specific information.

## Results

The main results of the original paper are presented in the folder `result`.

## Replicating

To replicate the results in the paper, proceed as follows: 

1. For different methods, run the RunXXX.m to obtain the results (XXX and methods correspond. For example, RunResultJackNestedBUaO.m corresponds to the FAST method in Example 1).
2. (Optional) Run save_MSE_Prob.m (Prob can be substituted) to organize the raw data and get the file `.csv`.
3. (Optional) Run the file `MSE_Rate.m` in the folder `Figure_Generate` to replicate the figures.

Once having the raw data, many different software and operating methods are available to create the final figures and tables. Steps 2 and 3 above are just a reference.

## Contact

If you have any questions about the paper, please contact Guo Liang at liangguo000221@ruc.edu.cn.
