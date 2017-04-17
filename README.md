# Computer Vision assignments & projects
* This repository contains 5 homeworks and 1 final project (upcoming) of Computer Vision, 16720 in Carnegie Mellon University.
* **Key note:** These are my own homeworks for course 16720-Computer Vision in Carnegie Mellon University in spring 2017 semester. I'm glad if my work could help anyone who interested in Computer Vision or other subjects related. However for student currently enrolled in this course using any of these code directly may be considered against the academic integrity.

## Installation
* For all Implementation: MATLAB_R2016a .
* For CNN in Optical Character Recognition: MATLAB_R2017a.
* Both available at: [Mathwork](https://www.mathworks.com/programs/trials/trial_request.html?ref=ggl&s_eid=ppc_29850095842&q=matlab)

## Usage

### Matlab Practice
* This assignment is a simple practice before starting of class.
* 16720-hw0.pdf contains the questions and requirements for functions in code.
* Code folder contains functions required for this homework. To run the code, simply open functions and tests via MATLAB. Comments in each function explained the function of itself.
* Results folder contains the output images of functions.

### Spatial Pyramid Matching for Scene Classification
* This assignment implement a scene classification system based on bag of words approach. The classification model is nearest neighbor. Spatial pyramid matching were implemented for multi-resolution.
* Main idea: Extract features in images via a set of filters, then applied k-means to those features to generate a "dictionary" for afterward usage. Each "word" in dictionary refers to a specific texture of images. For classification, assign the closest visual word to the image and thus yield the wordmap, in which the standard close is measured by Euclidean distance. Spatial pyramid matching was used to alleviate the consequence that bag of words discards the spatial structure.
* hw1.pdf contains the questions and requirements for functions in code.
* Writeup.pdf contains written-down answers for questions and some explanation for my implementation.
* Code folder contains functions required for this classification system. To run this system, simply open functions and tests via MATLAB. Comments in each function explained the function of itself.
* **Note:** In data folder, images used for classification were not included. Images used to generate dictionary and testing are from [SUN database](http://groups.csail.mit.edu/vision/SUN/).

### Feature Descriptors- Homographies - RANSAC
* This assignment implement brief descriptor and the matching with it, as well as derivation of Homography and generating panorama.
* Main idea: The key point is detected by local extremma in both scale and space. The MATLAB function imregionalmax and imregionalmin could accomplish these purpose. However I implemented the function with similar function. From those key points we could know exactly where should we find the feature we want. By Brief descriptor we could match one image to another with same key point. Brief descriptor is not rotation invariant, for a more robust descriptor we couls use SIFT descriptor. For image stitching, RANSAC was implemented to find the most imliers of image by which we could generate a panorama.
* hw2.pdf contains the questions and requirements for functions in code.
* Writeup.pdf contains written-down answers for questions and some explanation for my implementation.
* Code folder contains functions required for this assignment. To run them, simply open functions and tests via MATLAB. Comments in each function explained the function of itself.
* Results folder contains output images and .mat files required in hw2.pdf.

### Lucas-Kanade Tracking - Background Subtraction
* This assignment implement inverse compositional Lucas-Kanade (LK) tracker based on Lukas-Kanade Algorithm, correction of template drift were added to improve its performance.
* Main idea: The intuition behind inverse compositional Lucas-Kanade algorithm is to minimize the pixel squared difference within a template in two different time stamp. However this is based on the assumption that the difference between two time stamp is small. With the target moving fast, there might be a template drift which will be accumulated and finally caused the failure of tracking. Implementation has done to correct this in this assignment by keep this assumption held. The differnece was compared between n-1 time stamp and n time stamp without correction and with correction we compare the difference between n-1 time stamp and n time stamp with the difference between n-1 time stamp and the start point, such that guarantee the "small difference" assumption. By changing the objective function with image bases we could track temlpate with drastic appearance variance. These are tracking with pure translation. With using equations of affine model flow and affine transformation matrix, we could subtract affine motion in moving scenes. With morphology processing we could visualize the change of motion.
* hw3.pdf contains the questions and requirements for functions in code.
* Writeup.pdf contains written-down answers for questions and some explanation for my implementation.
* Code folder contains functions required for this assignment. To run this tracking algorithm, simply open functions and tests via MATLAB. Comments in each function explained the function of itself. 
* **Note:** Functions related to the correction of template drift were included in code folder. Intuition behind these is: [The template update problem](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.2.6015&rep=rep1&type=pdf).
* Results folder contains .mat files generated in related functions.

### 3D Reconstruction
* This assignment implement 3D reconstruction system based on Temple database. Derivation of theory related to epipolar geometry were included as well.
* Main idea: Since the DoF of fundamental matrix is 7, we could use either 8point or 7point algorithm to easimate the fundamental matrix. With trangulation we could project 2D point to 3D coordinate. For correspondence we could search through epipolar line instead of the whole image, which leads to a lot computation. We choose the point as correspondence which yield the smallest distance in a patch with known size. 
* hw4.pdf contains the questions and requirements for functions in code.
* Writeup.pdf contains written-down answers for questions and some explanation for my implementation.
* Code folder contains functions required for this reconstruction system. To run them, simply open functions and tests via MATLAB. Comments in each function explained the function of itself.

### Optical Character Recognition using Neural Networks
* This assignment implement a simple general ANN model for which settings can be tuned manually.
* Main idea: In neural network we use convolutional layer to extract the feature of input images, which usually followed by max pooling layer to diminish the computation, as well as prevent our model from over fitting the training data. Same with dropout, which randomly set a part of hidden units "quiet" so we could fit the training data less but the validation data more, which in turn yield a more general model. Functions like sigmoid or ReLU were used to guarantee the non-linearity of the network such that the hidden layer and hidden units in network could actually "learn" from the training data. For output layer softmax function was used to map the output of former layer to a possibility in range 0 to 1, which will be used for classification.
* hw5.pdf contains the questions and requirements for functions in code.
* Writeup.pdf contains written-down answers for questions and some explanation for my implementation.
* Code folder contains functions required for this ANN network. To run this network, simply open functions and tests via MATLAB. Comments in each function explained the function of itself.
* Images folder contains 6 images for testing the extraction function. You could created your own test image as well.
* ec folder contains functions related to extra credit part. A README file was associated with it for further explanation.
* **Note:** For CNN in extra credit part, MATLAB deep learning tool box was used. Make sure it's installed before running CNN file.
* Data folder contains the training, validation and test data for this network. Lines of loading these data were included in code.
* **Note:** Function data_construct should be ran before CNN to reconstruct the data for CNN's usage. 
 

### Final Project
* Upcoming

## Contributing
When contributing to this repository, please first discuss the change you wish to make via issue, email, or any other method with the owners of this repository before making a change.

* Fork it!
* Create your feature branch: ```git checkout -b my-new-feature```
* Commit your changes: ```git commit -am 'Add some feature' ```
* Push to the branch: ``` git push origin my-new-feature ```
* Submit a pull request :D

# Liscense
This project is licensed under the MIT License - see the [MIT](https://opensource.org/licenses/MIT) file for details
