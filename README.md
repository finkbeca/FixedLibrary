# FixedLibrary
A fixed point integer math library for Solidity
## Introduction
Fixed Library is an expanded int256 fixed point integer library buildt off Cement Dao's Fixidity. Fixedlibrary offers new implementation
of hyperbolic and trigonometric functions that work with fixed points integers, along with bug fixes and further testing. The goal of FixedLibrary
is to provide the mathematical tools needed for higher precison computations through decimal emulation. Building on top of Cement Dao's Fixidity we were
able to protection against overflowing while offering int256 fixed point integers allowing numbers up to 10^55 to be computed

A set of common constants have been added to make working with irrational numbers simpler.

The library is currently supporting 24 decimal spots, with slight changes to the constants this library could easily be adapted to support 
any amount of decimals. 

Extensive testing has been made to test each functions. Require statements have been added to revert any unsuitable action for each function as well as each function's
upper limit. With functions that grow expotentially like the newly implemented factorial function, upper limits tend to be quite low, with added require statements
we have hope to mitigate the chance that any individual function could overflow. It is important to note that FixedLib does not offer a new datatype
but rather a new representation of Solidity's int256 datatype. Therefore, it is important to recognize what form of int256 you are using, the supported 
fixed point version, or a regular int256 version. 

## FixedLib
This library implements addition, subtraction, multiplication and division, along with the related constants and limits.

__function digits() public pure returns(uint8)__ Number of positions that the comma is shifted to the right. Default: 24

__function fixed1() public pure returns(int256)__ This is 1 in the fixed point units used in this library. Calculated as fixed1() = equals 10^digits() Default: 1000000000000000000000000000000000000

__function mulPrecision() public pure returns(int256)__ The amount of decimals lost on each multiplication operand. Calcualted as mulPrecision() = sqrt(fixed1) Default: 1000000000000000000

__function maxInt256() public pure returns(int256)__ Maximum value that can be represented in an int256 Calculated as maxInt256() = 2^255 -1 Default: 57896044618658097711785492504343953926634992332820282019728792003956564819967

__function minInt256() public pure returns(int256)__ Minimum value that can be represented in an int256 Calculated as minInt256() = (2^255) * (-1) Default: -57896044618658097711785492504343953926634992332820282019728792003956564819968

__function maxNewFixed() public pure returns(int256)__ Maximum value that can be converted to fixed point. Default: 57896044618658097711785492504343953926634

__function minNewFixed() public pure returns(int256)__ Maximum value that can be converted to fixed point. Calculated as minNewFixed() = -(maxInt256()) / fixed1() Default: -57896044618658097711785492504343953926634

__function maxFixedAdd() public pure returns(int256)__ Maximum value that can be safely used as an addition operand. Additions with one operand over this value might overflow, but not necessarily so. Calculated as maxFixedAdd() equals maxInt256()-1 / 2 Default: 28948022309329048855892746252171976963317496166410141009864396001978282409983

__function maxFixedSub() public pure returns(int256)__ Maximum negative value that can be safely subtracted. Operations where values larger than maxFixedSub() are subtracted might overflow, but not necessarily so. Calculated as maxFixedSub() = minInt256() / 2 Default: -28948022309329048855892746252171976963317496166410141009864396001978282409984

__function maxFixedMul() public pure returns(int256)__ Maximum value that can be safely used as a multiplication operator. Divisions where a value is divided by another over this value might overflow, but not necessarily so. Calculated as maxFixedMul() = sqrt(maxNewFixed())*fixed1(). Default: 240615969168004511545000000000000000000000000000000000000

__function maxFixedDiv() public pure returns(int256)__ Maximum value that can be safely used as a dividend. Operations where values larger than maxFixedDiv() are divided might overflow, but not necessarily so. Calculated as divide(maxFixedDiv,newFixedFraction(1,fixed1())) = maxInt256(). Default: 57896044618658097711785492504343953926634 }

__function maxFixedDivisor() public pure returns(int256)__ Maximum value that can be safely used as a divisor. The divide(x, y) function uses reciprocal(y), and numbers above maxFixedDivisor() will cause a division by zero. Calculated as maxFixedDivisor() = fixed1()*fixed1() Default: 1000000000000000000000000000000000000000000000000000000000000000000000000

__function newFixed(int256 x)__ Converts an int256 to fixed point units, equivalent to multiplying by 10^digits().

**function fromFixed(int256 x)** Converts an int256 in the fixed point representation of this library to a non decimal. All decimal digits will be truncated.

**function convertFixed(int256 x, uint8 _originDigits, uint8 _destinationDigits)** Converts an int256 which is already in some fixed point representation to a different fixed precision representation. Both the origin and destination precisions must be 38 or less digits. Origin values with a precision higher than the destination precision will be truncated accordingly.

**function newFixed(int256 x, uint8 _originDigits)*** Converts an int256 which is already in some fixed point representation to that of this library. The _originDigits parameter is the precision of x. Values with a precision higher than FixidityLib.digits() will be truncated accordingly.

**function fromFixed(int256 x, uint8 _destinationDigits)** Converts an int256 in the fixed point representation of this library to a different representation. The _destinationDigits parameter is the precision of the output x. Values with a precision below than FixidityLib.digits() will be truncated accordingly.

__function newFixedFraction(int256 numerator, int256 denominator)__ Converts two int256 representing a fraction to fixed point units, equivalent to multiplying dividend and divisor by 10^digits() and then dividing them.

__function integer(int256 x) public pure returns (int256)__ Returns the integer part of a fixed point number, still in fixed point format.

__function fractional(int256 x) public pure returns (int256)__ Returns the fractional part of a fixed point number. In the case of a negative number the fractional is also negative.

__function abs(int256 x) public pure returns (int256)__ Converts to positive if negative. Due to int256 having one more negative number than positive numbers abs(minInt256) reverts.

__function add(int256 x, int256 y) public pure returns (int256)__ x+y. If any operator is higher than maxFixedAdd() it might overflow.

__function subtract(int256 x, int256 y) public pure returns (int256)__ x-y. You can use add(x,-y) instead.

__function multiply(int256 x, int256 y) public pure returns (int256)__ x*y. If any of the operators is higher than maxFixedMul() it might overflow.

__function reciprocal(int256 x) public pure returns (int256)__ 1/x.

__function divide(int256 x, int256 y) public pure returns (int256)__ x/y. If the dividend is higher than maxFixedDiv() it might overflow. You can use multiply(x,reciprocal(y)) instead. There is a loss of precision on division for the lower mulPrecision() decimals.

__function factorial(uint256 _x) public pure returns (int256)__ If any number is greater than 57 it might overflow

## LogarithmLib
This library extends FixedLib by implementing logarithms, along with the related constants and limits.

__function fixedE() public pure returns(int256)__ This is e in the fixed point units used in this library. Default: 27182818284590452353602874713526624977572470936999595749669676277240766303535/fixed1()

__function fixedLn1_5() public pure returns(int256)__ ln(1.5) Default: 405465108108164381978013115464349137;

__function fixedLn10() public pure returns (int256)__ ln(10) Default: 2302585092994045684017991454684364208;

__function ln(int256 value) public pure returns (int256)__ ln(x). This function has a 1/50 deviation close to ln(-1), 1/maxFixedMul() deviation at fixedE()**2, but diverges to 10x deviation at maxNewFixed().

__function log_b(int256 b, int256 x) public pure returns (int256) log_b(x)__

int256 b Base in fixed point representation.
int256 x Value to calculate the logarithm for in fixed point representation.

## ExponentLib
This library extends FixedLib by implementing exponents, along with the related constants

__function fixedExp10() public pure returns(int256)__ This is e^10 in the fixed point units in this library. 22026465794806716516957900645

__function fixedE() public pure returns(int256)__ This is e in the fixed point units used in this library. 2718281828459045235360287

**function powerE(int256 _x) internal pure returns (int256)** e^x

__function powerAny(int256 a, int256 b) public pure returns (int256)__ Takes the power of any two numbers that are in fixed point units. Supports fractions and negative numbers.

__function rootAny(int256 a, int256 b) public pure returns (int256)__ Takes the root of any two numbers that are in fixed point units.
    
__function rootN(int256 a, uint8 n) public pure returns (int256)__ Takes the root of a number who is in fixed point units where the root is in standard int8 integer

**function round_off(int256 _v, uint8 digits) public pure returns (int256)** Rounds off numbers to 24 decimal spots.

__function trunc_digits(int256 v, uint8 digits) public pure returns (int256)__ Truncates a number in fixed point units to the positions given by digits

## TrigLib
This library extends FixedLib by implementing trigonometric functions that supports radians and degrees, along with the related constants

__function fixedPi() public pure returns(int256 result )__ This is pi in the fixed point units used in this library. 3141592653589793238462643

__function fixedHalfPi() public pure returns(int256 result)__ This is pi/2 in the fixed point units used in this library.  1570796326794896619231321

__function fixedQuarterPi() public pure returns(int256 result)__ This is pi/4 in the fixed point units used in this library. 785398163397448309615660

__function fixedThirdPi() public pure returns (int256 result)__ This is pi/3 in the fixed point units used in this library.  1047197551196597746154214

**function sin(uint256 _x) public pure returns(int256 result)** Returns the fixed point unit approximation of sin(x) where x is a positive number representing radians in fixed point units 

**function cos(uint256 _y) public pure returns(int256 result)** Returns the fixed point unit approximation of cos(y) where y is a positive number representing radians in fixed point units 

**function tan(uint256 _x) public pure returns(int256 result)** Returns the fixed point unit approximation of tan(x) where x is a positive number representing radians in fixed point units 
Note that this requires tan(x) to be defined in the domain.

**function sec(uint256 _x) public pure returns(int256 result)** Returns the fixed point unit approximation of sec(x) where x is a positive number representing radians in fixed point units 
Note that this requires sec(x) to be defined in the domain.

**function csc(uint256 _x) public pure returns(int256 result)** Returns the fixed point unit approximation of csc(x) where x is a positive number representing radians in fixed point units 
Note that this requires csc(x) to be defined in the domain.

**function cot(uint256 _x) public pure returns(int256 result)** Returns the fixed point unit approximation of cot(x) where x is a positive number representing radians in fixed point units 
Note that this requires cot(x) to be defined in the domain.

**function SinDegreeInt(uint16 _x) public pure returns(int256 result)** Return the fixed point unit approximation of sin(x) where x ia a positive standard int16 number representing degrees

__function sinDegree(uint256 x) public pure returns(int256 result)__  Returns the fixed point unit approximation of sin(x) where x is a posiitve number representing degrees in fixed point units

__function cosDegree(uint256 x) public pure returns(int256 result)__ Returns the fixed point unit approximation of cos(x) where x is a posiitve number representing degrees in fixed point units

__function tanDegree(uint256 x) public pure returns(int256 result)__ Returns the fixed point unit approximation of tan(x) where x is a posiitve number representing degrees in fixed point units
Note that this requires csc(x) to be defined in the domain.

__function secDegree(uint256 x) public pure returns(int256 result)__ Returns the fixed point unit approximation of sec(x) where x is a posiitve number representing degrees in fixed point units
Note that this requires csc(x) to be defined in the domain.

__function cscDegree(uint256 x) public pure returns(int256 result)__ Returns the fixed point unit approximation of csc(x) where x is a posiitve number representing degrees in fixed point units
Note that this requires csc(x) to be defined in the domain.

__function cotDegree(uint256 x) public pure returns(int256 result)__ Returns the fixed point unit approximation of cot(x) where x is a posiitve number representing degrees in fixed point units
Note that this requires csc(x) to be defined in the domain.

## HyperLib
This library extends FixedLib by implementing hyperbolic functions

__function sinh(int256 x) public pure returns(int256 results)__ Returns the fixed point unit approximation of sinh(x) where x is a positive number in fixed point units. Note this requires x < 120 
as this function grows rapidly

__function cosh(int256 x) public pure returns(int256 results)__ Returns the fixed point unit approximation of cosh(x) where x is a positive number in fixed point units. Note this requires x < 120 
as this function relies on e^x which grows rapidly

__function tanh(int256 x) public pure returns(int256 results)__ Returns the fixed point unit approximation of tanh(x) where x is a positive number in fixed point units. Note this requires x < 120 
as this function relies on e^x which grows rapidly

__function csch(int256 x) public pure returns(int256 results)__ Returns the fixed point unit approximation of csch(x) where x is a positive number in fixed point units. Note this requires x < 120 
as this function relies on e^x which grows rapidly

__function sech(int256 x) public pure returns(int256 results)__ Returns the fixed point unit approximation of sech(x) where x is a positive number in fixed point units. Note this requires x < 120 
as this function relies on e^x which grows rapidly

__function coth(int256 x) public pure returns(int256 results)__ Returns the fixed point unit approximation of coth(x) where x is a positive number in fixed point units. Note this requires x < 120 
as this function relies on e^x which grows rapidly


