var Vote = React.createClass({

  getInitialState: function() {
    return {
      voted: this.props.currentUserVoted
    };
  },

  handleClick: function(event) {
    event.preventDefault();
    console.log('cat');
    var answer = this.props.answer;
    if (!answer) {
      return;
    }
    this.handleVoteSubmit(answer);
  },

  handleVoteSubmit: function(answer) {
    console.log('made it');
    var postUrl = "";
    var postUrl = "/answers/" 
          + answer.id
            + "/vote";
    console.log(postUrl);
    $.ajax({
          url: postUrl,
          dataType: 'json',
          type: 'PUT',
          data: {},
          success: function(response) {
            this.setState({voted: !this.state.voted});
          }.bind(this),
          error: function() {
            console.error("Vote failed");
          }.bind(this)
    });
  },

  handleVoteCount: function() {
    var count = this.props.answer.votes.length
    if(this.props.currentUserVoted) {
      if(this.state.voted) {
        return count;
      }
      else {
        return count - 1;
      }
    }
    else {
      if(this.state.voted) {
        return count + 1;
      }
      else {
        return count;
      }
    }
  },

  render: function() {
    var text = this.state.voted ? 'UPVOTED' : 'vote';
    var voteCount = this.handleVoteCount();
    return (
      <button onClick={this.handleClick}>
        {text} {voteCount}
      </button>
    );
  }

});
