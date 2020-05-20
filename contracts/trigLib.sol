pragma solidity >=0.4.22 <0.7.0;

import "./fixedLib.sol";
import "./ExponentLib.sol";


library trigLib{
    
    /**
     * Fixed Point version of Pi
    */
    function fixedPi() public pure returns(int256 result ) {
        return 3141592653589793238462643;
    }
    
    /**
     * hardcoded fixed Point version of Pi / 2
    */
    function fixedHalfPi() public pure returns(int256 result) {
        return 1570796326794896619231321;
    }

    /**
     * hardcoded fixed Point version of Pi / 4
    */ 
    function fixedQuarterPi() public pure returns(int256 result) {
        return 785398163397448309615660;
    }

     /**
     * hardcoded fixed Point version of Pi / 3
    */
    function fixedThirdPi() public pure returns (int256 result) {
        return 1047197551196597746154214;
    }
    /**
     * Low cost sin approxiomation using Bhaskara's function for the approximation of sin 
     * returns the approximation in int256 fixed point integer form
     * @param _x radian value as an positive int256 fixed point integer
     */ 
    function sin(uint256 _x) public pure returns(int256 result) {
        int256 mod2Pi =  int256(_x) % (2 * fixedPi());
        int256 x = (int256(_x) % fixedPi());
        int256 multiplier = 1;
        if(mod2Pi > fixedPi()) {
            multiplier = -1;
        }
        int256 numerator = (fixedLib.multiply(fixedLib.multiply(16000000000000000000000000, x), fixedLib.subtract( fixedPi(), x)));
        int256 denominator = (  fixedLib.subtract(fixedLib.multiply(fixedLib.multiply(5000000000000000000000000, fixedPi()),  fixedPi()), 
            (fixedLib.multiply(fixedLib.multiply(4000000000000000000000000, x), fixedLib.subtract(fixedPi(), x)))      ));
         return  (fixedLib.divide(numerator, denominator) * multiplier);
    }
    
    
    /**
    * Low cost cos approximation using a translation of sin function
    * returns the approximation in int256 fixed point integer form
    * @param _y radian value as an postive int256 fixed point integer
     */
    function cos(uint256 _y) public pure returns(int256 result) {
        
        //cos(x) = sin(pi/2 + x)
        uint256 mod2Pi =  uint256(int256(_y) % (fixedLib.multiply(2000000000000000000000000, fixedPi())));
        uint256 halfPi = uint256(fixedLib.divide(fixedPi(), 2000000000000000000000000));
        uint256 sum = (halfPi + mod2Pi);
        return (sin(sum));
    }
    
    /**
    * Low cost tan approximation using the library's sin, cos and division function.
    * returns the approximation in int256 fixed point integer form
    * @param x radian value as an postive int256 fixed point integer that is defined in the domain
     */
    function tan(uint256 x) public pure returns(int256 result) {
       if( (int256(x) % fixedPi()) > 100000) {
           require( int256(x) % (fixedPi() /2) >= 100000 );
       } 
       return fixedLib.divide(sin(x), cos(x));
        
    }
    
    /**
    * Low cost csc approximation using library's reciprocoal and sin function.
    * returns the approximation in int256 fixed point integer form
    * @param x radian value as an postive int256 fixed point integer that is defined in the domain
     */
    function csc(uint256 x) public pure returns(int256 result) {
        require( int256(x) % fixedPi() != 0 );
        return fixedLib.reciprocal(sin(x));
    }
    
    /**
    * Low cost csc approximation using library's reciprocoal and cos function. 
    * returns the approximation in int256 fixed point integer form
    * @param x radian value as an postive int256 fixed point integer that is defined in the domain
     */
    function sec(uint256 x) public pure returns(int256 result) {
         if((int256(x) % fixedPi())> 100000) {
           require( int256(x) % (fixedPi() /2) >= 100000 );
       }
        return fixedLib.reciprocal(cos(x));
    }
    
    /**
    * Low cost cot approximation using the library's sin, cos and division function. 
    * returns the approximation in int256 fixed point integer form
    * @param x radian value as an postive int256 fixed point integer thatis definedin the domain
     */
    function cot(uint256 x) public pure returns(int256 result) {
        require((int256(x) % fixedPi()) != 0, "Not valid in the domain");
        return fixedLib.divide(cos(x), sin(x));
    }
    
    
    ////////////////////////////////////////////////////////
    
    
    ////////////////////////////////////////////////////////
    
    /**
    * Integer Version NOT IN FIXED POINT FORM
    * sin approximation from degrees
    * returns the approximation in int256 fixed point integer form
    * @param _x degree integer value as a postive uint16 NOT IN FIXED POINT FORM
     */
    function SinDegreeInt(uint16 _x) public pure returns(int256 result)  {
      uint256 x = uint256(_x) * (10 ** 24);
     return sinDegree(x);
      
    }
    
    
    

    /**
    * Fixed Point version suitable for decimals
    * sin approximation from degrees suitable for decimals
    * returns the approximation in int256 fixed point integer form
    * @param x degree integer value as a postive int256 fixed point integer
     */
    function sinDegree(uint256 x) public pure returns(int256 result)  {
      int256 mod180x = int256(x) % 180000000000000000000000000;
      int256 mod360x = int256(x) % 360000000000000000000000000;
      int256 multiplier = 1;
      if(mod360x > 180000000000000000000000000 ) {
          multiplier = -1;
      }
      
      int256 numerator = fixedLib.multiply(fixedLib.multiply(4000000000000000000000000, mod180x),
        fixedLib.subtract(180000000000000000000000000, mod180x));
      int256 denominator = fixedLib.subtract(40500000000000000000000000000,
        fixedLib.multiply(mod180x, fixedLib.subtract(180000000000000000000000000, mod180x)) );
      return (fixedLib.divide(numerator, denominator) * multiplier);
      
    }
    
    /**
    * cos approximation from degrees, suitable for decimals
    * returns the approximation in int256 fixed point integer form
    * @param x degree integer value as a postive int256 fixed point integer
     */
    function cosDegree(uint256 x) public pure returns(int256 result) {
        
      int256 mod360x = int256(x) % 360000000000000000000000000;
      int256 multiplier = 1;
      if(mod360x > 90000000000000000000000000 && mod360x < 270000000000000000000000000) {
          multiplier = -1;
      }
        
        uint256 halfPi = 90000000000000000000000000;
        uint256 sum =  x + halfPi;
        uint256 mod180x = sum % 180000000000000000000000000;
        return (sinDegree(mod180x) * multiplier);
        
    }
    
     /**
    * tan approximation from degrees, suitable for decimals
    * returns the approximation in int256 fixed point integer form
    * @param x degree value as a postive int256 fixed point integer that is defined in the domain
     */
    function tanDegree(uint256 x) public pure returns(int256 result) {
       if((int256(x) % 18000000000000000000000000) > 100000) {
           require(int256(x) % (90000000000000000000000000) >= 100000, "Not valid in the domain");
       }
        return fixedLib.divide(sinDegree(x), cosDegree(x));
    }
    
     /**
    * sec approximation from degrees, suitable for decimals
    * returns the approximation in int256 fixed point integer form
    * @param x degree value as a postive int256 fixed point integer that is defined in the domain
     */
     function secDegree(uint256 x) public pure returns(int256 result) {
      if((int256(x) % 18000000000000000000000000) > 100000) {
           require(int256(x) % (90000000000000000000000000) >= 100000, "Not valid in the domain" );
       }
         return fixedLib.reciprocal(cosDegree(x));
    }
    
     /**
    * csc approximation from degrees, suitable for decimals
    * returns the approximation in int256 fixed point integer form
    * @param x degree value as a postive int256 fixed point integer that is defined in the domain
     */
     function cscDegree(uint256 x) public pure returns(int256 result) {
         require((x % 180000000000000000000000000) != 0,  "Not valid in the domain");
         return fixedLib.reciprocal(sinDegree(x));
    }
    
     /**
    * cot approximation from degrees, suitable for decimals
    * returns the approximation in int256 fixed point integer form
    * @param x degree value as a postive int256 fixed point integer that is defined in the domain
     */
     function cotDegree(uint256 x) public pure returns(int256 result) {
        require((x % 180000000000000000000000000) != 0, "Not valid in the domain");
        return fixedLib.divide(cosDegree(x), sinDegree(x));
    }
    
    
}