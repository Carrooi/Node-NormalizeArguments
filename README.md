# normalize-arguments

Normalize arguments almost like for overloaded methods (not really).

If you want to use overloaded methods, please look at some other package (like [over](https://npmjs.org/package/over)
or [overloadjs](https://npmjs.org/package/overloadjs)).

This package just normalize order of arguments in method, so you do not need to pass all arguments into method call
(eg. like in jQuery).

Based on data type of arguments.

## Installation

```
$ npm install normalize-arguments
```

## Usage

```
var args = require('normalize-arguments');

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

* 1.1.0
	+ Added oneOf option

* 1.0.1
	+ Typo in readme

* 1.0.0
	+ First version