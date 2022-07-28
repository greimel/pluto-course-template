# pluto-course-template

Template for a course website based on https://computationalthinking.mit.edu/Spring21/

#### see the [website this template generates](https://greimel.github.io/pluto-course-template)

This is a fork of https://github.com/mitmath/18S191/pull/120 (by @fonsp). Changes:

* repository reduced to a minimal example
* make it work with prepath (e.g. the `pluto-course-template` in `https://greimel.github.io/pluto-course-template`)
* combine with pure markdown pages (`using Franklin`)
* deploys to GitHub Pages (via GitHub Actions) and GitLab Pages (via GitLab CI)

## Instructions

Here is how to adjust the website to your needs.

### 1. Generate the repository

https://user-images.githubusercontent.com/6280307/153845695-bd8291c9-69e6-4f31-90e6-2e2914c26ab8.mov

### 2. Customize the website

The prepath should match the short-name of your repository (`my-new-course` in this example)

https://user-images.githubusercontent.com/6280307/153845320-2b0e68ba-8ca6-4810-b9f1-8a55d897fac9.mov

### 2. (alternative version) Customize from within Pluto

1. Clone the repo
2. Open Julia and Pluto
3. Open `newwebsite/generate.jl` from Pluto
4. Do the customizations (especially prepath!)

### 3. Enable GitHub Pages

https://user-images.githubusercontent.com/6280307/153846538-1b79db97-cdb4-43fa-92d1-f3504363bb00.mov

### 4. Wait for GitHub Actions to finish and check the result

https://user-images.githubusercontent.com/6280307/153845247-48d66bed-ac4d-4b35-8f1a-e8738f190201.mov
