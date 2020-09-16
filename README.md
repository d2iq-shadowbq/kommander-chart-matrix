# README

## Install

* You need Ruby and NVM 

``` shell
$> git clone 
$> cd kommander-chart-matrix
$[kommander-chart-matrix]> git pull --recurse-submodules
$[kommander-chart-matrix]> git submodule update --recursive
$[kommander-chart-matrix]> bundle install 
$[kommander-chart-matrix]> cd json-view 
$[kommander-chart-matrix/json-view]> npm install
```

## Generate

 `$[kommander-chart-matrix]> ruby build-matrix.rb`

## WebView

``` shell
$> cd json-view/ && npm start
Static server(express.js) - http://localhost:3000
```

## To update 

``` shell
$[kommander-chart-matrix]>git submodule update --recursive
$[kommander-chart-matrix]> ruby build-matrix.rb
```
