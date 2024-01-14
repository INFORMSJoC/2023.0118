BarrierUpOutCallBS.m BarrierUpOutCallBSRev.m and VanillaCallBS.m are about the exact value (such as $V_0$ and the true value)

Reset.m is about the figure

NestedEsti.m is used to generate the samples (about the outer-level samples and inner-level samples

ResultNestedBUaO.m, ResultJackNestedBUaO.m and Result2JackNestedBUaO.m calculate the estimates of Bootstrap estimator (Zhang et al. (2022)), FAST and 2-FAST estimator for the Up-and-Out Barrier Option

RunResultNestedBUaO.m, RunResultJackNestedBUaO.m and RunResult2JackNestedBUaO.m repeat the estimates to calculate the empirical MSE

Users can adjust different d (denote the number of the stocks) in the RunResultNestedBUaO.m (RunResultJackNestedBUaO.m and RunResult2JackNestedBUaO.m), the corresponding true value is obtained from the fold 'TureValue_3Barrier_Option'