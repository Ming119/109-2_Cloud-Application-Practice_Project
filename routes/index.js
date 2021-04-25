//
// routers/index.js
//

const IndexController = require('../controllers/index_controller');

indexController = new IndexController();

router.get('/', indexController.sayHiController);:

