# Radiance-Reflectance Combined Optimization and Structure-Guided L0-Norm for Single Image Dehazing
J. Shin, M. Kim, J. Paik, and S. Lee, "Radiance-Reflectance Combined Optimization and Structure-Guided L0-Norm for Single Image Dehazing," **_IEEE Transactions on Multimedia_**, 2020 [[PDF]](https://ieeexplore.ieee.org/document/8734728)


## Running
### Dehazing
<img src="/code/Dehazing/save/hongkong_original.png" width="200" height="200">    <img src="/code/Dehazing/save/hongkong_t_hat_optimize_heatmab.png" width="200" height="200">     <img src="/code/Dehazing/save/hongkong_recovering_optimize.png" width="200" height="200">

`./code/Dehazing/Dehazing_2017_7_ShinJoongChol.m`
### SL0 Filter
<img src="/code/EdgePreservingSmoothing/save/baboon_original.png" width="200" height="200"> <img src="/code/EdgePreservingSmoothing/save/baboon_S_GL0.png" width="200" height="200"> <img src="/code/EdgePreservingSmoothing/save/pnrimage2_original.png" width="200" height="200"> <img src="/code/EdgePreservingSmoothing/save/pnrimage2_S_GL0.png" width="200" height="200">

`./code/EdgePerservingSmoothing/testEPS.m`

## Citation
Please cite the paper if you find the code useful.

<pre>@ARTICLE{8734728,
author={J. {Shin} and M. {Kim} and J. {Paik} and S. {Lee}},
journal={IEEE Transactions on Multimedia},
title={Radiance–Reflectance Combined Optimization and Structure-Guided $\ell _0$-Norm for Single Image Dehazing},
year={2020},
volume={22},
number={1},
pages={30-44},
month={Jan},}<code>
