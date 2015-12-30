Title:      Matlab code for "Deblurring Face Images with Exemplars"  
Author:     Jinshan Pan (sdluran@gmail.com), Zhe Hu (zhu@ucmerced.edu), Zhixun Su (zxsu@dlut.edu.cn), Ming-Hsuan Yang (mhyang@ucmerced.edu).  
Version:    1.0 
Copyright:  2014, Jinshan Pan, Zhe Hu, Zhixun Su, and Ming-Hsuan Yang


Matlab code for "Deblurring Face Images with Exemplars"
==========================================================

This package contains an implementation of the image deblurring algorithm described in the paper: 
Jinshan Pan, Zhe Hu, Zhixun Su, and Ming-Hsuan Yang, "Deblurring Face Images with Exemplars", ECCV 2014.

Please cite our paper if using the code to generate data (e.g., images, tables of processing times, etc.) 
in an academic publication.

For algorithmic details, please refer to our paper.

----------------
How to use
----------------
The code is tested in MATLAB 2011b(32bit) under the MS Windows 7 64bit version with an Intel Xeon CPU@2.53GHz and 12GB RAM.

1. unpack the package
2. include code/subdirectory in your Matlab path
3. Run "run_all_data.m" to try the examples included in this package.

4. "find_structures_code": find the best exemplars
5. "fina_deconvolution_code": the final non-blind deconvolution method.
6. "make_mask_code": the implementation of extracting salient edges from exemplars. 

----------------
Acknowledgement 
----------------
We thankthe authors of following paper for making their code available.
[1] Levin, A., Weiss, Y., Durand, F., Freeman, W.T.: Efficient marginal likelihood optimization in blind deconvolution. In: CVPR 2011
[2] He, K., Sun, J., Tang, X.: Guided image filtering. In: ECCV 2010
[3] Cho, S., Wang, J., Lee, S., Handling Outliers in Non-blind Image Deconvolution. In: ICCV 2011
[4] Xu, L., Lu, C., Xu, Y., Jia, J.: Image smoothing via L0 gradient minimization. ACM Trans. Graph. 30(6), 174 (2011)
----------------
IMPORTANT NOTE 
----------------
Note that the algorithm sometimes may converge to an incorrect result. When you obtain such an incorrect result, please re-try to deblur with a slightly changed parameters (e.g., using large blur kernel sizes or gamma correction (2.2)). Should you have any questions regarding this code and the corresponding results, please contact Jinshan Pan (sdluran@gmail.com), Zhe Hu (zhu@ucmerced.edu), Zhixun Su (zxsu@dlut.edu.cn) or Ming-Hsuan Yang (mhyang@ucmerced.edu).
