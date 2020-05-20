pragma solidity >=0.4.22 <0.7.0;

import "./fixedLib.sol";
import "./LogarithmLib.sol";


library ExponentLib {

    function fixedExp10() public pure returns(int256) {
        return 22026465794806716516957900645;
    }

    function fixedE() public pure returns(int256) {
        return 2718281828459045235360287;
    }
    /**
     * @notice Not fully tested anymore.
     */
    function powerE(int256 _x)
        internal
        pure
        returns (int256)
    {
        assert(_x < 172 * fixedLib.fixed1());
        int256 x = _x;
        int256 r = fixedLib.fixed1();
        while (x >= 10 * fixedLib.fixed1()) {
            x -= 10 * fixedLib.fixed1();
            r = fixedLib.multiply(r, fixedExp10());
        }
        if (x == fixedLib.fixed1()) {
            return fixedLib.multiply(r, LogarithmLib.fixedE());
        } else if (x == 0) {
            return r;
        }
        int256 tr = 100 * fixedLib.fixed1();
        int256 d = tr;
        for (uint8 i = 1; i <= 2 * fixedLib.digits(); i++) {
            d = (d * x) / (fixedLib.fixed1() * i);
            tr += d;
        }
        return fixedLib.multiply(tr, r);
        //return trunc_digits(fixedLib.multiply(tr, r), 2);
    }

    function powerAny(int256 a, int256 b)
        public
        pure
        returns (int256)
    {
        return powerE(fixedLib.multiply(LogarithmLib.ln(a), b));
    }

    function rootAny(int256 a, int256 b)
        public
        pure
        returns (int256)
    {
        return powerAny(a, fixedLib.reciprocal(b));
    }

    function rootN(int256 a, uint8 n)
        public
        pure
        returns (int256)
    {
        return powerE(fixedLib.divide(LogarithmLib.ln(a), fixedLib.fixed1() * n));
    }

    // solium-disable-next-line mixedcase
    function round_off(int256 _v, uint8 digits)
        public
        pure
        returns (int256)
    {
        int256 t = int256(uint256(10) ** uint256(digits));
        int8 sign = 1;
        int256 v = _v;
        if (v < 0) {
            sign = -1;
            v = 0 - v;
        }
        if (v % t >= t / 2) v = v + t - v % t;
        return v * sign;
    }

    // solium-disable-next-line mixedcase
    function trunc_digits(int256 v, uint8 digits)
        public
        pure
        returns (int256)
    {
        if (digits <= 0) return v;
        return round_off(v, digits) / fixedLib.fixed1();
    }
}