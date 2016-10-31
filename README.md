# Colophon: How I Maintain my Website
After years of struggling with pre-packaged frameworks (e.g., Flask, web.py)
and static-site generators (e.g., Jekyll), I gave up!

My conclusion is that they don't scale down and don't suite my needs. I need a
custom workflow to generate and build my pages. All these existing frameworks
are great in what they do, but they are just **this close** to what I needed,
yet not quite **exactly** what I needed.

So, my approach from now on is to take the best bits from each functionality I
need, and package them together my way.

## Functionalities and Best Tools
I need only basic functionalities:

* convert from X to Y (e.g., from Markdown to HTML, from BibTeX or LaTeX to HTML),
* procure and package static files.

There exist some solid tools for these essential functionalities:

* [pandoc](http://pandoc.org/) for general-purpose multi-format conversion,
* [pandoc-citeproc](https://github.com/jgm/pandoc-citeproc) for Markdown to BibTeX with citation support,
* [browserify](http://browserify.org/) to add a JS library with ease,
* [node-sass](https://github.com/sass/node-sass) for SASS to CSS (with minification support),
* [uglifyjs](https://github.com/mishoo/UglifyJS) for JS minification,
* [npm](https://www.npmjs.com/) to keep dependecies and static files in order.

## The Overall Workflow
The overall workflow is orchestrated by a simple shell script (`build.sh`),
which essentially implements the following:

```
_input/*/*.md --pandoc--> _output/*/*.html
_src/js/*.js --browserify | uglifyjs--> _output/s/js/app.js
_src/css/*.scss --node-sass--> _output/s/css/app.css
_static/* --cp -R--> _output/s/*
```

Dead simple, and the tools are not inter-dependent. One day I can decide to
drop node-sass and replace it with something else.

## Behind the Curtain
There's a little bit behind the scene, which is handled by `npm` and a
`package.json` file to take care of procuring static files (e.g., CSS
frameworks, web fonts, JS libraries).

## How I use it?
Whenever I need to change something, I work in the `_input` folder, and type
`./build.sh` when I'm done. This builds the output into `_output`, which I
symlinked to the working copy of a [separate Git
repository](https://github.com/phretor/maggi.cc) that I use to serve the final
files.
