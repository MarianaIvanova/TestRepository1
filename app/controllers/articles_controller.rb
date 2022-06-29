class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end
        
    def show
        @article = Article.find(params[:id])
    end

    def new    
        #MI: Creating a new instance variable @article, otherwise @article would be nil in our view
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end    

    #MI: typically in Rails, the action that is used for new form submissions is called "create", and so the form should be pointed to that action. POST.
    def create
        #MI: automatically mapping the model to the respective database columns. Here we are reffering to a class Article, defined in models:
        @article = Article.new(article_params)

        #MI: If the result of saving is yes:
        if @article.save
            #MI:redirect the user to the show action:
            redirect_to @article
        #MI: if the result of saving is no
        else
            #MI: send the user to the form again:
            render 'new'
        end        
    end
    
    def update
        @article = Article.find(params[:id])
       
        if @article.update(article_params)
          redirect_to @article
        else
          render 'edit'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
       
        redirect_to articles_path
      end

    private
        def article_params
            params.require(:article).permit(:title, :text)
        end
end