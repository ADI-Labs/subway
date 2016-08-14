var Vote = React.createClass({

  getInitialState: function() {
    return {
      upvoted: this.props.currentUserUpvoted,
      downvoted: this.props.currentUserDownvoted
    };
  },

  handleUpvoteClick: function(event) {
    event.preventDefault();
    var answer = this.props.answer;
    if (!answer) {
      return;
    }
    this.handleVoteSubmit(answer, true);
  },

  handleDownvoteClick: function(event) {
    event.preventDefault();
    var answer = this.props.answer;
    if (!answer) {
      return;
    }
    this.handleVoteSubmit(answer, false);
  },

  handleVoteSubmit: function(answer, isUpvote) {
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
          data: {isUpvote: isUpvote},
          success: function(response) {
            if(isUpvote) {
              this.setState({downvoted: false});
              this.setState({upvoted: !this.state.upvoted});
            }
            else {
              this.setState({upvoted: false});
              this.setState({downvoted: !this.state.downvoted});
            }
          }.bind(this),
          error: function() {
            console.error("Vote failed");
          }.bind(this)
    });
  },

  handleVoteCount: function() {
    //count upvotes
    var upvoteCount = 0;
    var downvoteCount = 0;
    var countObject = {};
    countObject["upvoteCount"] = upvoteCount;
    countObject["downvoteCount"] = downvoteCount;

    for (var i=0; i < this.props.answer.votes.length; i++) {
      var vote = this.props.answer.votes[i];
      if(vote["isUpvote"]) {
        upvoteCount = upvoteCount + 1;
      }
      else {
        downvoteCount = downvoteCount + 1;
      }
    }

    if(this.props.currentUserUpvoted) {
      if(this.state.upvoted) {
        countObject["upvoteCount"] = upvoteCount;
        countObject["downvoteCount"] = downvoteCount;
      }
      else {
        if(this.state.downvoted) {
          countObject["upvoteCount"] = upvoteCount - 1;
          countObject["downvoteCount"] = downvoteCount + 1;
        }
        else {
          countObject["upvoteCount"] = upvoteCount - 1;
          countObject["downvoteCount"] = downvoteCount;
        }
      }
    }
    else if (this.props.currentUserDownvoted) {
      if(this.state.downvoted) {
        countObject["upvoteCount"] = upvoteCount;
        countObject["downvoteCount"] = downvoteCount;
      }
      else {
        if(this.state.upvoted) {
          countObject["upvoteCount"] = upvoteCount + 1;
          countObject["downvoteCount"] = downvoteCount - 1;
        }
        else {
          countObject["upvoteCount"] = upvoteCount;
          countObject["downvoteCount"] = downvoteCount - 1;
        }
      }
    }
    else {
      if(this.state.upvoted) {
        countObject["upvoteCount"] = upvoteCount + 1;
        countObject["downvoteCount"] = downvoteCount;
      }
      else if (this.state.downvoted) {
        countObject["upvoteCount"] = upvoteCount;
        countObject["downvoteCount"] = downvoteCount + 1;
      }
    }
    return countObject;
  },

  render: function() {
    var upvoteText = this.state.upvoted ? 'UPVOTED' : 'upvote';
    var downvoteText = this.state.downvoted ? 'DOWNVOTED' : 'downvote';

    var voteCountObject = this.handleVoteCount();
    return (
      <div>
        <button onClick={this.handleUpvoteClick}>
          {upvoteText} {voteCountObject["upvoteCount"]}
        </button>
        <button onClick={this.handleDownvoteClick}>
          {downvoteText} {voteCountObject["downvoteCount"]}
        </button>
      </div>
    );
  }

});
