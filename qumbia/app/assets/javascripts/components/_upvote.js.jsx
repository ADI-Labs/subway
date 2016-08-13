var Upvote = React.createClass({

  getInitialState: function() {
    return {
      upvoted: this.props.currentUserUpvoted
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
    var postUrl = "";
    var postUrl = "/answers/" 
          + answer.id
            + "/upvote";
    console.log(postUrl);
    $.ajax({
          url: postUrl,
          dataType: 'json',
          type: 'PUT',
          data: {},
          success: function(response) {
            this.setState({upvoted: !this.state.upvoted});
          }.bind(this),
          error: function() {
            console.error("Upvote failed");
          }.bind(this)
    });
  },

  handleUpvoteCount: function() {
    var count = this.props.answer.upvotes.length
    if(this.props.currentUserUpvoted) {
      if(this.state.upvoted) {
        return count;
      }
      else {
        return count - 1;
      }
    }
    else {
      if(this.state.upvoted) {
        return count + 1;
      }
      else {
        return count;
      }
    }
  },

  render: function() {
    var text = this.state.upvoted ? 'UPVOTED' : 'upvote';
    var upvoteCount = this.handleUpvoteCount();
    return (
      <button onClick={this.handleClick}>
        {text} {upvoteCount}
      </button>
    );
  }

});