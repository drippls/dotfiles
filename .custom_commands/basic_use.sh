#!/bin/bash

function profile() {
	open "https://github.com/JudeLakkis";
}

function display() {
	tree -I env node_modules;
}

# Init a new github repo
function repo() {
	git init;
	git add README.md;
	git commit -m "README.md";
	git branch -M master;
	# Takes passed variable as repo link name
	git remote add origin "https://github.com/JudeLakkis/${1}.git";
	git push -u origin main;
}
