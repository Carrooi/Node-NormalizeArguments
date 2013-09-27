types =
	string: '[object String]'
	number: '[object Number]'
	boolean: '[object Boolean]'
	array: '[object Array]'
	object: '[object Object]'
	fn: '[object Function]'


string = (d) -> return {type: 'string', d: d}
number = (d) -> return {type: 'number', d: d}
boolean = (d) -> return {type: 'boolean', d: d}
array = (d) -> return {type: 'array', d: d}
object = (d) -> return {type: 'object', d: d}
any = (d) ->return {type: 'any', d: d}
fn = (d) -> return {type: 'fn', d: d}


emptyArgument = {}
type = Object.prototype.toString
isFunction = (v) -> return type.call(v) == '[object Function]'


count = (num) ->
	switch num
		when 1 then return 'st'
		when 2 then return 'nd'
		when 3 then return 'rd'
		else return 'th'


expandArguments = (params = [], expected = []) ->
	for e, i in expected
		e = e() if isFunction(e)
		if e.type != 'any' && types[e.type] != type.call(params[i])
			params.splice(i, 0, emptyArgument)

	return params


normalizeArguments = (params) ->
	result = []
	for i, param of params
		result.push param

	return result


args = (params = [], expected = []) ->
	params = normalizeArguments(params) if type.call(params) != '[object Array]'
	params = expandArguments(params, expected)

	for param, i in params
		expect = null
		if typeof expected[i] != 'undefined'
			expect = if isFunction(expected[i]) then expected[i]().type else expected[i].type

		if param == emptyArgument
			if isFunction(expected[i])
				num = i + 1
				throw new Error num + count(num) + ' argument must be ' + expected[i]().type

			params[i] = expected[i].d

	return params


args.string = string
args.number = number
args.boolean = boolean
args.array = array
args.object = object
args.any = any
args.fn = fn


module.exports = args