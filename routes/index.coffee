express = require('express')
router = express.Router()

### GET home page. ###

router.get '/', (req, res) ->
  res.render 'index', title: 'Front Page'
  return
module.exports = router


router.get '/:step', (req, res) ->
	step = req.params.step
	res.render 'index', title: 'Step page' + step.toString()