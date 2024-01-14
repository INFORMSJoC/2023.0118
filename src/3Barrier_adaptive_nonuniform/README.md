BarrierUpOutCallBS.m BarrierUpOutCallBSRev.m and VanillaCallBS.m are about the exact value (such as $V_0$ and the true value).

Reset.m is about the figure.

NestedEsti.m is used to generate the samples (about the outer-level samples and inner-level samples.

AdaptiveNonuniform.m calculate the estimates of nested sequential method (Broadie et al. (2011)) for the Up-and-Out Barrier Option.

RunAdaptiveNonuniform.m repeat the estimates for many times to calculate the empirical MSE.

Users can adjust different d (denote the number of the stocks) in the RunAdaptiveNonuniform.m, the corresponding true value is obtained from the fold 'TureValue_3Barrier_Option'.