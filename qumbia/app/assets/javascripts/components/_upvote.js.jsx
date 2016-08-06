var Upvote = React.createClass({

  getInitialState: function() {
    return {
      upvoted: false
    };
  },

  handleClick: function(event) {
    event.preventDefault();
    console.log('cat');
    var answer = this.props.answer;
    if (!answer) {
      return;
    }
    this.handleUpvoteSubmit(answer);
  },

  handleUpvoteSubmit: function(answer) {
    console.log('made it');
    var postUrl = "/answers/" 
          + answer.id
            + "/upvotes";
    console.log(postUrl);
    $.ajax({
          url: postUrl,
          dataType: 'json',
          type: 'POST',
          data: {"upvote":
                {"answer_id": answer.id}
          },
          success: function(response) {
            this.setState({upvoted: !this.state.upvoted});
          }.bind(this),
          error: function() {
            console.error("Upvote failed");
          }.bind(this)
    });
  },

  render: function() {
    const text = this.state.upvoted ? 'UPVOTED' : 'upvote';
    return (
      <button onClick={this.handleClick}>
        {text} {this.props.answer.upvotes.length}
      </button>
    );
  }

});