var Main = React.createClass({
	
	getInitialState: function() {
		return {
			questions: null
		}
	},

	loadQuestionsFromServer: function() {
	    $.ajax({
	    	type: "GET",
	    	url: "/questions",
	   		contentType: 'application/json',
	    	cache: false,
	    success: function(questions) {
	    	console.log(JSON.stringify(questions));
	        this.setState({questions: questions});
	    }.bind(this),
	    error: function() {
	        console.error('Error receiving questions');
	    }.bind(this)
	    });
	},

	generateQuestionBlocks: function(questionsAsJsonObject) {
		if (questionsAsJsonObject) {
			var questionHeaders = [];
			questionHeaders = questionsAsJsonObject.map(function(question) {
				return (<QuestionBlock question={question} key={question.id} 
							currentUser={this.props.currentUser}/>);
			}.bind(this));
			return questionHeaders;
		}
	},

	componentDidMount: function() {
    	this.loadQuestionsFromServer();
    },

	render: function() {
		console.log(this.props.currentUser);
		var questionBlocks = this.generateQuestionBlocks(this.state.questions);
		return (
			<div className="questionBlocks">
				{questionBlocks}
			</div>
		);
	}
});