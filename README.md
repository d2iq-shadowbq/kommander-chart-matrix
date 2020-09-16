# README

## Install

* You need Ruby and NVM 

``` shell
$> git clone 
$> cd kommander-chart-matrix
$[kommander-chart-matrix]> git pull --recurse-submodules
$[kommander-chart-matrix]> git submodule update --recursive
$[kommander-chart-matrix]> bundle install 
```

## Generate

 `ruby build-matrix.rb`

## WebView

``` 
$> cd json-view/ && npm start

$> json-view@1.0.0 start /Users/smacgregor/bailiwick/matrix/json-view
$> node server.js

Static server app listening at localhost:3000
```

## To update 

git submodule update --recursive
