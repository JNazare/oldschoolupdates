express = require('express')
router = express.Router()

### GET home page. ###

router.get '/', (req, res) ->
  res.render 'index', title: 'Front Page'
  return
module.exports = router


router.get '/:step', (req, res) ->
	step = req.params.step
	if step == "1"
		res.render 'step1', title: 'Step ' + step.toString()
	if step == "2"
		res.render 'step2', title: 'Step ' + step.toString()
	if step == "3"
		res.render 'step3', title: 'Step ' + step.toString()