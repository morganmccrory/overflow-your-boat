class CommentsController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    if params[:answer_id]
      @answer = Answer.find(params[:answer_id])
      @comment = @answer.comments.create(comment_params)
      @comment.update_attributes(commenter: current_user)
      redirect_to @question
    else
      @comment = @question.comments.create(comment_params)
      @comment.update_attributes(commenter: current_user)
      redirect_to @question
    end
  end
end

def edit
  @question = Question.find(params[:question_id])
  if current_user
    @comment = @question.comments.find(params[:id])
  else
    @question = Question.find(params[:question_id])
    flash[:failure] = "Must be logged in to perform this action"
    redirect_to @question
  end
end

# def update
#   @question = Question.find(params[:question_id])
#   if params[:answer_id]
#      @answer = @question.answers.find(params[:answer_id])
#      @comment = @answer.comments.find(params[:id])
#      @comment.update_attributes(comment_params)

#   else
#     @comment = @question.comments.find(params[:id])
#     @comment.update_attributes(comment_params)
#   end
#    if @comment.save
#     redirect_to @question
#   else
#     render "edit"
#   end
# end




private

def comment_params
  params.require(:comment).permit(:message)
end
