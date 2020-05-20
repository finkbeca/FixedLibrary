const FixidityLib = artifacts.require('./fixedLib.sol');
const LogarithmLib = artifacts.require('./LogarithmLib.sol');
const ExponentLib = artifacts.require('./ExponentLib.sol');
const trig = artifacts.require('./trigLib.sol');
const hyper = artifacts.require('./hyperLib.sol');


module.exports = (deployer) => {
    // deploy fixidity
    deployer.deploy(FixidityLib);
    deployer.link(FixidityLib, LogarithmLib);
    deploy.link(FixidityLib, ExponentLib );
    deploy.link(FixidityLib, trig);
    deploy.link(FixidityLib, hyper);

    // deploy logarithm
    deployer.deploy(LogarithmLib);
    deployer.deploy(ExponentLib);
    deployer.deploy(trig);
    deployer.deploy(hyper);

};