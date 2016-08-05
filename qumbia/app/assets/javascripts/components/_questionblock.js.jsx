var QuestionBlock = React.createClass({
	
	getInitialState: function() {
		return {
			questionAnswerText: "",
			answerQuestionClicked: false
		};
	},

	generateQuestionAnswers: function() {
		var answers = this.props.question.answers;
		var questionAnswers = answers.map(function(answer) {
			return(<QuestionAnswer userEmail={answer.user.email} answerBody={answer.body} />);
		});
		return questionAnswers;
	},

	handleQuestionAnswerTextChange: function(newQuestionAnswerText) {
		this.setState({questionAnswerText: newQuestionAnswerText});
	},

	generateQuestionHeader: function() {
		var userEmail = this.props.question.hasOwnProperty('user') ? this.props.question.user.email : "dog@dog.com";
		return (<QuestionHeader userEmail={userEmail} question={this.props.question.title}/>);
	},

	toggleQuestionAnswerForm: function() {
		this.setState({answerQuestionClicked: !this.state.answerQuestionClicked});
	},

	handleAnswerSubmit: function() {
		this.setState({answerQuestionClick: !this.state.answerQuestionClicked});
		console.log('blerg');
	},

	render: function() {
		return (
			<div className="questionBlockDiv">
				{this.generateQuestionHeader()}
				{this.generateQuestionAnswers()}
				{this.state.answerQuestionClicked ? 
					(<span> <QuestionAnswerForm 
						questionAnswerText={this.state.questionAnswerText}
						onQuestionAnswerTextChange={this.handleQuestionAnswerTextChange}
						onAnswerSubmit={this.props.handleAnswerSubmit}
						questionId={this.props.question.id}
						currentUser={this.props.currentUser}
					 />
					 <button onClick={this.toggleQuestionAnswerForm}> Cancel </button> </span>
					)
					: (<button onClick={this.toggleQuestionAnswerForm}>Answer Question</button>)
				}
			</div>
		);
	}
});