var QuestionAnswer = React.createClass({
	
	render: function() {
		return (
			<div className="questionAnswer">
				<b> {this.props.userEmail} </b>
				<em> {this.props.answerBody} </em>
				<Upvote answer={this.props.answer}/>
			</div>
		);
	}
});