[![NPM version](https://img.shields.io/npm/v/normalize-arguments.svg?style=flat-square)](http://badge.fury.io/js/normalize-arguments)
[![Dependency Status](https://img.shields.io/gemnasium/Carrooi/Node-NormalizeArguments.svg?style=flat-square)](https://gemnasium.com/Carrooi/Node-NormalizeArguments)
[![Build Status](https://img.shields.io/travis/Carrooi/Node-NormalizeArguments.svg?style=flat-square)](https://travis-ci.org/Carrooi/Node-NormalizeArguments)

[![Donate](https://img.shields.io/badge/donate-PayPal-brightgreen.svg?style=flat-square)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=LWVXQAPZ33USW)

# normalize-arguments

Normalize arguments almost like for overloaded methods (not really).

If you want to use overloaded methods, please look at some other package (like [over](https://npmjs.org/package/over)
or [overloadjs](https://npmjs.org/package/overloadjs)).

This package just normalize order of arguments in method, so you do not need to pass all arguments into method call
(eg. like in jQuery).

Based on data type of arguments.

You can use this package also in browser for example with [simq](https://github.com/sakren/node-simq) or use standalone
build.

## Help

Unfortunately I don't have any more time to maintain this repository :-( 

Don't you want to save me and this project by taking over it?

![sad cat](https://raw.githubusercontent.com/sakren/sakren.github.io/master/images/sad-kitten.jpg)

## Installation

```
$ npm install normalize-arguments
```

Standalone build for browser:
* [Source version](https://raw.github.com/sakren/node-normalize-arguments/master/normalizeArguments.js)
* [Minified version](https://raw.github.com/sakren/node-normalize-arguments/master/normalizeArguments.min.js)

## Usage

```
var args = require('normalize-arguments');

// or standalone build in browser:
var args = normalizeArguments;

var fn = function(list, count, data, base) {
	arguments = args(arguments, [args.object, args.number(null), args.object({}), args.string(null)]);
	list = arguments[0];		// someList
	count = arguments[1];		// null
	data = arguments[2];		// {}
	base = arguments[3];		// 'and base argument'
};

fn(someList, 'and base argument');
```

You can see, that defined variables in function head are quite useless, but it is good to keep them there (qg. for better
readability or IDE autocompletion).

## Data types registered in args object

* `string`
* `number`
* `boolean`
* `array`
* `object`
* `any`
* `fn`
* `oneOf`: special type, see below

If you will just set some of these options then it means, that argument on position of selected option is needed and if
you will not pass it in method call, exception will be thrown.

## Default values

Setting is exactly the same like setting required arguments, but you just have to call this option. Argument which you will
pass into option call, will be used as default value for argument (look above).

## oneOf option

You can use `oneOf` option to specify, in which type must be argument and when you don't want to use `any` option.

```
args(arguments, [args.oneOf([args.array, args.object]), args.string, args.number]);

// or with default value

args(arguments, [args.oneOf([args.array, args.object], []), args.string, args.number]);
```

Now first argument must be array or literal object and in second example default value will be empty array.

## Tests

```
$ npm test
```

## Changelog

* 1.2.1
	+ Move under Carrooi organization
	+ Abandon package

* 1.2.0
	+ Added tests for browser
	+ Added standalone build for browser
	+ Added badges and travis build
	+ Optimized arguments parsing

* 1.1.2
	+ Some optimizations

* 1.1.1
	+ Passed null in method (default behavior without this package)

* 1.1.0
	+ Added oneOf option

* 1.0.1
	+ Typo in readme

* 1.0.0
	+ First version
