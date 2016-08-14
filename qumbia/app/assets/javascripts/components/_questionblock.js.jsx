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
			var userUpvotedAnswer = false;
			var userDownvotedAnswer = false;
			if(this.props.currentUser.hasOwnProperty("votes")) {
				for (var i=0; i < this.props.currentUser.votes.length; i++) {
					var currVote = this.props.currentUser.votes[i]
					if(currVote["answer_id"] === answer.id) {
						if(currVote["isUpvote"]) {
							userUpvotedAnswer = true
							break;
						}
						else {
							userDownvotedAnswer = true
							break;
						}
					}
				}
			}
			return(<QuestionAnswer 
					userEmail={answer.user.email} 
					answerBody={answer.body} 
					answer={answer}
					currentUserUpvoted={userUpvotedAnswer}
					currentUserDownvoted={userDownvotedAnswer}/>);
		}.bind(this));

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
		this.setState(this.getInitialState());
		this.props.refreshQuestions();
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
						onAnswerSubmit={this.handleAnswerSubmit}
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
