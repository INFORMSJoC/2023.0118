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
  author =        {Liang, Guo and Luo, Jun and Zhang, Kun},
  publisher =     {INFORMS Journal on Computing},
  title =         {Github repository: A {FAST} method for nested estimation.},
  year =          {2024},
  doi =           {10.1287/ijoc.2023.0118.cd},
  note =          {Available for download at https://github.com/INFORMSJoC/2023.0118},
}  
```

## Description

The goal of this software is to demonstrate the effect of the jackkniFe-bAsed neSted simulaTion (FAST) method proposed in "A FAST Method for Nested Estimation" by Guo Liang, Jun Luo and Kun Zhang. 



Nested estimation involves estimating an expectation of a function of a conditional expectation, and has many important applications in operations research and machine learning. However, the mean squared error (MSE) of the standard nested simulation (SNS) is only of order $\Gamma^{-2/3}$, where $\Gamma$ is the total simulation budget. Our proposed FAST method improves the convergence speed to $\Gamma^{-4/5}$. 



Each folder contains a README.md file for more specific information.

## Codes

The programming language is Matlab. The folder [src](https://github.com/LiangGuoRUC/2023.0118/tree/main/src) provides all the codes for the numerical experiments in the original paper. Specifically, under this file path,

- Folder [3Barrier_Jack_Boot](https://github.com/LiangGuoRUC/2023.0118/tree/main/src/3Barrier_Jack_Boot) includes the SNS , FAST and 2-FAST methods for Example 1 of the paper.

- Folder [3Barrier_Regression](https://github.com/LiangGuoRUC/2023.0118/tree/main/src/3Barrier_Regression) includes the least-squares method (LSM) for Example 1 of the paper.

- Folder [3Barrier_adaptive_nonuniform](https://github.com/LiangGuoRUC/2023.0118/tree/main/src/3Barrier_adaptive_nonuniform) includes the nested sequential simulation (NSS) for Example 1 of the paper.

- Folder [Expected_Information_Gain](https://github.com/LiangGuoRUC/2023.0118/tree/main/src/Expected_Information_Gain) includes the FAST method for Example 2 of the paper.

- Folder [TrueValue_3Barrier_Option](https://github.com/LiangGuoRUC/2023.0118/tree/main/src/TureValue_3Barrier_Option) provides the true value for Example 1 of the paper.

- Folder [Figure_Generate](https://github.com/LiangGuoRUC/2023.0118/tree/main/src/Figure_Generate) helps us generate the figures in the paper.


## Results

The main results of the original paper are presented in the folder [result](https://github.com/LiangGuoRUC/2023.0118/tree/main/result).

## Replicating

To replicate the results in the paper, proceed as follows: 

1. For different methods, run the RunXXX.m to obtain the raw data (XXX and methods correspond. For example, RunResultJackNestedBUaO.m corresponds to the FAST method in Example 1). Parameters can be adjusted to suit your purpose, such as the number of replications `rep`, the number of stocks `d`, etc. In addition, the user can empirically adjust the `threshold` to avoid extreme cases (the estimated inner sample size is too small), e.g., the threshold can be set to 5 or 10.
2. (Optional) Run save_MSE_Prob.m (Prob can be substituted) to organize the raw data and get the file `.csv`.
3. (Optional) Run the file `MSE_Rate.m` in the folder [Figure_Generate](https://github.com/LiangGuoRUC/2023.0118/tree/main/src/Figure_Generate) to replicate the figures.

Once having the raw data, many different software and operating methods are available to create the final figures and tables. Steps 2 and 3 above are just a reference.

## Contact

If you have any questions about the paper, please contact Guo Liang at liangguo000221@ruc.edu.cn.
