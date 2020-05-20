pragma solidity >=0.4.22 <0.7.0;

import "./fixedLib.sol";
import "./ExponentLib.sol";

library hyperLib {

    /**
    * Approximation of sinh() using indentity
    * @param x fixed point integers
    * @dev sinh grows expotentially thus small numbers quickly run out of the scope of a int256
     */
    function sinh(int256 x) public pure returns(int256 results) {
        require(x < 122000000000000000000000000, "Cannot support larger numbers");
        int256 neg_x = -1 * x;
        int256 denominator = 2000000000000000000000000;
        int256 numerator = fixedLib.subtract(
            ExponentLib.powerAny(ExponentLib.fixedE(), x),
            ExponentLib.powerAny(ExponentLib.fixedE(), neg_x)
        );
        return fixedLib.divide(numerator,denominator);
    }

    /**
    * Approximation of sinh() using indentity
    * @param x fixed point integers
     */
    function cosh(int256 x) public pure returns(int256 results) {
        require(x < 122000000000000000000000000, "Cannot support larger numbers");
        int256 neg_x = -1 * x;
        int256 denominator = 2000000000000000000000000;
        int256 numerator = fixedLib.add(
            ExponentLib.powerAny(ExponentLib.fixedE(), x),
            ExponentLib.powerAny(ExponentLib.fixedE(), neg_x)
        );
        return fixedLib.divide(numerator,denominator);
    }

    /**
    * Approximation of tanh() using sinh and cosh
    * @param x fixed point integers
     */
    function tanh(int256 x) public pure returns(int256 results) {
        require(x < 122000000000000000000000000, "Cannot support larger numbers");
        return fixedLib.divide(sinh(x), cosh(x));
    }

    /**
    * Approximation of csch() using the reciprocal of sinh
    * @param x fixed point integers
     */
    function csch(int256 x) public pure returns(int256 results) {
        require(x < 122000000000000000000000000, "Cannot support larger numbers");
        return fixedLib.reciprocal(sinh(x));
    }

    /**
    * Approximation of sech() using the reciprocoal of cosh
    * @param x fixed point integers
     */
    function sech(int256 x) public pure returns(int256 results) {
        require(x < 122000000000000000000000000, "Cannot support larger numbers");
        return fixedLib.reciprocal(cosh(x));
    }

    /**
    * Approximation of sinh() using cosh and sinh
    * @param x fixed point integers
     */
    function coth(int256 x) public pure returns(int256 results) {
    require(x < 122000000000000000000000000, "Cannot support larger numbers");
        return fixedLib.divide(cosh(x), sinh(x));
    }
}