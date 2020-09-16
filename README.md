# README

The purpose is to be able to identify what kommander-ui docker image version is tied to what kommander-addon deployement.

* YAML - [kommander-matrix.yaml](/kommander-matrix.yaml)
* JSON - [kommander-matrix.json](/kommander-matrix.json)

*Usecase:*

If I see the kommander-ui image 6.22.0 in the cluster it means it was deployed between (Kommander ClusterAddon 1.2.0 iteration 5 to iteration 9 / 1.2.0-5 and 1.2.0-9) releases.

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
