// Generated by CoffeeScript 1.6.3
(function() {
  var args, expect;

  expect = require('chai').expect;

  args = require('../../lib/Args');

  describe('Args', function() {
    it('should return empty array', function() {
      return expect(args()).to.be.eql([]);
    });
    it('should throw an error if required argument is missing', function() {
      return expect(function() {
        return args([], [args.number]);
      }).to["throw"](Error);
    });
    it('should throw an error if argument is not of the right type', function() {
      return expect(function() {
        return args([1], [args.string]);
      }).to["throw"](Error);
    });
    it('should pass default value for one argument', function() {
      return expect(args([], [args.number(1)])).to.be.eql([1]);
    });
    it('should let pass any argument', function() {
      var date;
      date = new Date;
      return expect(args([date], [args.any])).to.be.eql([date]);
    });
    it('should pass default value with other arguments', function() {
      return expect(args([1], [args.number, args.string('test')])).to.be.eql([1, 'test']);
    });
    it('should pass arguments like in first example of doc', function() {
      var fn;
      fn = function(list, count, a, base) {
        return args(arguments, [args.object, args.number(null), args.object({}), args.string(null)]);
      };
      return expect(fn({}, 'and base argument')).to.be.eql([{}, null, {}, 'and base argument']);
    });
    return it('should pass default values for advanced options', function() {
      expect(args([1, 'one', true], [args.number, args.boolean(false), args.string, args.boolean])).to.be.eql([1, false, 'one', true]);
      expect(args(['one'], [args.object({}), args.string])).to.be.eql([{}, 'one']);
      return expect(args(['one', 2, 'three', 4], [args.string])).to.be.eql(['one', 2, 'three', 4]);
    });
  });

}).call(this);