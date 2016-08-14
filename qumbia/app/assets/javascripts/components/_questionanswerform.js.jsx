var QuestionAnswerForm = React.createClass({

	handleQuestionAnswerTextChange: function(event) {
		this.props.onQuestionAnswerTextChange(event.target.value);
	},

	handleSubmit: function(event) {
		event.preventDefault();
		console.log('dog');
		var answer = this.props.questionAnswerText;
		if (!answer) {
			return;
		}
		this.handleAnswerSubmit(answer);
		this.collapseAnswerForm();
	},

	handleAnswerSubmit: function(answerBody) {
		var postUrl = "/questions/" 
					+ this.props.questionId 
						+ "/answers";
		$.ajax({
		      url: postUrl,
		      dataType: 'json',
		      type: 'POST',
		      data: {answer: 
		      			{body: answerBody}
		      		},
		      success: function(response) {
		      	return true;
		      }.bind(this),
		      error: function() {
		        console.error("Answer create failed");
		      }.bind(this)
		});
	},

	collapseAnswerForm: function() {
		this.props.onAnswerSubmit();
	},

	render: function() {
		return (
			<div className="questionAnswerForm">
				<form onSubmit={this.handleSubmit}>
					<textarea 
						name="questionAnswerText" 
						value={this.props.questionAnswerText}
						onChange={this.handleQuestionAnswerTextChange}
						placeholder="Enter answer"/>
					<button>Submit</button>
				</form>
			</div>
		);
	}
});
