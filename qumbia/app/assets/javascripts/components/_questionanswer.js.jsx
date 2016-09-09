var QuestionAnswer = React.createClass({
	
	getInitialState: function() {
		return {
			answerDeleted: false
		}
	},

	handleDeleteClick: function(event) {
		event.preventDefault();
		var postUrl = "";
	    var postUrl = "questions/"
	    			+ this.props.question.id
	    			+ "/answers/" 
	        		+ this.props.answer.id;
		$.ajax({
			url: postUrl,
			dataType: 'json',
			type: 'DELETE',
			data: {},
			success: function(response) {
				this.setState({answerDeleted: true});
			}.bind(this),
			error: function() {
				console.error("Delete failed");
			}.bind(this)
		});
	},

	render: function() {
		if (!this.state.answerDeleted) {
			return (
			<div className="questionAnswer">
				<b> {this.props.userEmail} </b>
				<em> {this.props.answerBody} </em>

				{(this.props.answer.user.id === this.props.currentUser.id) 
					? <input type="submit" value="Delete" onClick={this.handleDeleteClick} />
					: null
				}
				<Vote 
					answer={this.props.answer} 
					currentUserUpvoted={this.props.currentUserUpvoted}
					currentUserDownvoted={this.props.currentUserDownvoted}/>
			</div>
			);
		}
		else {
			return null;
		}
	}
});
