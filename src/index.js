// pull in desired CSS/SASS files
require('./styles/main.scss');

require('./images/favicon.ico');

var Elm = require('./App/Main');
Elm.App.Main.embed(document.getElementById('main'));
