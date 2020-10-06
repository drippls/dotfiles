#!/bin/bash

function flaskprj() {
	virtualenv env;
	source env/bin/activate;
	pip3 install Flask;
	pip3 freeze > requirements.txt;
	mkdir src;
	cd src;
	touch server.py;
	mkdir templates static testfiles;
	cd static;
	mkdir CSS JS;
	cd CSS;
	touch wrapper.css home.css;
	cd ../JS;
	touch main.js;
	cd ../../templates;
	touch wrapper.html home.html;
	cd ..;
	tree;
}
