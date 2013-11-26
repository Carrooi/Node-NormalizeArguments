types =
	string: '[object String]'
	number: '[object Number]'
	'boolean': '[object Boolean]'
	array: '[object Array]'
	object: '[object Object]'
	fn: '[object Function]'


exportFunc =
	string: (d) -> return {type: 'string', d: d}
	number: (d) -> return {type: 'number', d: d}
	'boolean': (d) -> return {type: 'boolean', d: d}
	array: (d) -> return {type: 'array', d: d}
	object: (d) -> return {type: 'object', d: d}
	any: (d) ->return {type: 'any', d: d}
	fn: (d) -> return {type: 'fn', d: d}
	oneOf: (list, d = null) ->
		readable = []
		for type, i in list
			t = type().type
			list[i] = types[t]
			readable.push(t)
		return {type: 'oneOf', d: d, dCalled: arguments.length == 2, types: list, readable: readable}


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
		actual = type.call(params[i])

		if params[i] != null && e.type != 'any' && ((e.type == 'oneOf' && e.types.indexOf(actual) == -1) || (e.type != 'oneOf' && types[e.type] != actual))
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
		e = expected[i]
		if typeof e != 'undefined'
			expect = if isFunction(e) then e().type else e.type

		if param == emptyArgument
			fn = isFunction(e)
			if fn || (!fn && e.type == 'oneOf' && e.dCalled == false)
				if fn
					must = e().type
				else
					if e.readable.length == 1
						must = e.readable[0]
					else
						last = e.readable.pop()
						must = e.readable.join(', ') + ' or ' + last

				num = i + 1
				throw new Error num + count(num) + ' argument must be ' + must

			params[i] = e.d

	return params


for name, fn of exportFunc
	args[name] = fn


module.exports = args