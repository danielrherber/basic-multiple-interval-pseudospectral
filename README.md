## README (basic-multiple-interval-pseudospectral)

[![GitHub release](https://img.shields.io/github/release/danielrherber/basic-multiple-interval-pseudospectral.svg)](https://github.com/danielrherber/basic-multiple-interval-pseudospectral/releases/latest)
[![](https://img.shields.io/badge/language-matlab-EF963C.svg)](https://www.mathworks.com/products/matlab.html)
[![](https://img.shields.io/github/issues-raw/danielrherber/basic-multiple-interval-pseudospectral.svg)](https://github.com/danielrherber/basic-multiple-interval-pseudospectral/issues)
[![GitHub contributors](https://img.shields.io/github/contributors/danielrherber/basic-multiple-interval-pseudospectral.svg)](https://github.com/danielrherber/basic-multiple-interval-pseudospectral/graphs/contributors)

[![license](https://img.shields.io/github/license/danielrherber/basic-multiple-interval-pseudospectral.svg)](https://github.com/danielrherber/basic-multiple-interval-pseudospectral/blob/master/License)

This project implements multiple-interval pseudospectral methods to solve optimal control problems.

![readme_image.svg](http://www.danielherber.com/img/projects/basic-multiple-interval-pseudospectral/readme_image.svg)

---
### Install
- Download the [project files](https://github.com/danielrherber/basic-multiple-interval-pseudospectral/archive/master.zip)
- Run [INSTALL_Basic_Pseudospectral.m](https://github.com/danielrherber/basic-multiple-interval-pseudospectral/blob/master/INSTALL_Basic_Pseudospectral.m) in the MATLAB Command Window *(automatically adds project files to your MATLAB path, downloads the required files, and opens an example)*
```matlab
INSTALL_Basic_Pseudospectral
```
- See [BD_main.m](https://github.com/danielrherber/basic-multiple-interval-pseudospectral/blob/master/examples/bryson-denham/BD_main.m) to run the Bryson-Denham example
```matlab
open BD_main
```
- See the technical report [[PDF]](http://systemdesign.illinois.edu/publications/Her15a.pdf) for the theory and case study results

### Citation
The code is complementary material for the following publication:
- DR Herber. **Basic Implementation of Multiple-Interval Pseudospectral Methods to Solve Optimal Control Problems.** Technical report, Engineering System Design Lab, UIUC-ESDL-2015-01, Urbana, IL, USA, Jun 2015. [[PDF]](http://systemdesign.illinois.edu/publications/Her15a.pdf)

### Description
The two numerical schemes are used: the Legendre pseudospectral method with LGL nodes and the Chebyshev pseudospectral method with CGL nodes. The results from the case studies using the Bryson-Denham problem demonstrate the effect of user's choice in mesh parameters and little difference between the two numerical pseudospectral schemes. The solution procedure is independent of Bryson-Denham problem the test so other optimal control problems can be solved with the accompanying code.

The main purpose of this submission is to provide a reference for the basic implementation of multiple-interval pseudospectral methods. Paired with the technical report of the same name, I hope to help bring this advanced method for solving optimal control problems to a broader audience (especially in the classroom).

### External Includes
See [INSTALL_Basic_Pseudospectral.m](https://github.com/danielrherber/basic-multiple-interval-pseudospectral/blob/master/INSTALL_Basic_Pseudospectral.m) for more information
- MATLAB File Exchange Submission IDs (**23629**, **40397**)
- Code from Lloyd N. Trefethen. **Spectral Methods in MATLAB**, SIAM, 2000. [[URL]](https://people.maths.ox.ac.uk/trefethen/spectral.html)
- Code from J. Shen, T. Tang, and L. Wang. **Spectral Methods: Algorithms, Analysis and Applications**, Springer, 2011. [[URL]](http://www.ntu.edu.sg/home/lilian/book.htm)

---
### General Information

#### Contributors
- [Daniel R. Herber](https://github.com/danielrherber)

#### Project Links
- [https://github.com/danielrherber/basic-multiple-interval-pseudospectral](https://github.com/danielrherber/basic-multiple-interval-pseudospectral)
- [http://www.mathworks.com/matlabcentral/fileexchange/51104](http://www.mathworks.com/matlabcentral/fileexchange/51104)