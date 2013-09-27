expect = require('chai').expect

args = require '../../lib/Args'

describe 'Args', ->

	it 'should return empty array', ->
		expect(args()).to.be.eql([])

	it 'should throw an error if required argument is missing', ->
		expect( -> args([], [args.number]) ).to.throw(Error)

	it 'should throw an error if argument is not of the right type', ->
		expect( -> args([1], [args.string]) ).to.throw(Error)

	it 'should pass default value for one argument', ->
		expect(args([], [args.number(1)])).to.be.eql([1])

	it 'should let pass any argument', ->
		date = new Date
		expect(args([date], [args.any])).to.be.eql([date])

	it 'should pass default value with other arguments', ->
		expect(args([1], [args.number, args.string('test')])).to.be.eql([1, 'test'])

	it 'should pass arguments like in first example of doc', ->
		fn = (list, count, a, base) ->
			return args(arguments, [args.object, args.number(null), args.object({}), args.string(null)])

		expect(fn({}, 'and base argument')).to.be.eql([{}, null, {}, 'and base argument'])



	it 'should pass default values for advanced options', ->
		expect(args([1, 'one', true], [args.number, args.boolean(false), args.string, args.boolean])).to.be.eql([1, false, 'one', true])
		expect(args(['one'], [args.object({}), args.string])).to.be.eql([{}, 'one'])
		expect(args(['one', 2, 'three', 4], [args.string])).to.be.eql(['one', 2, 'three', 4])