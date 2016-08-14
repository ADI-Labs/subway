var QuestionAnswer = React.createClass({
	
	render: function() {
		return (
			<div className="questionAnswer">
				<b> {this.props.userEmail} </b>
				<em> {this.props.answerBody} </em>
				<Vote 
					answer={this.props.answer} 
					currentUserUpvoted={this.props.currentUserUpvoted}
					currentUserDownvoted={this.props.currentUserDownvoted}/>
			</div>
		);
	}
});
