var QuestionAnswer = React.createClass({
	
	render: function() {
		return (
			<div className="questionAnswer">
				<b> {this.props.userEmail} </b>
				<em> {this.props.answerBody} </em>
				<Vote answer={this.props.answer} currentUserVoted={this.props.currentUserVoted}/>
			</div>
		);
	}
});
