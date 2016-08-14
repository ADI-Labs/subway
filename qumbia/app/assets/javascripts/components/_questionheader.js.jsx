var QuestionHeader = React.createClass({
	render() {
		return (
			<div className="questionHeader">
				<b> {this.props.userEmail}: </b>
				<em> {this.props.question} </em>
			</div>
		);
	}
});
