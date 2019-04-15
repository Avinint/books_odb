class BooksController < ApplicationController
    before_action :find_book, only: [:show, :edit, :update, :destroy]
    before_action :store_editor_name, only: [:create, :update]

    def show
    end

    def index
        @books = Book.page(params[:page]).per(20)
    end

    def new
        @book = Book.new
    end

    def edit
    end

    def create
        @book = Book.new book_params
        if @book.save
            flash[:notice] = t "books.created"
            redirect_to books_path
        else
            render :new
        end
    end

    def update
        if @book.update(book_params)
            flash[:notice] = t "books.updated"
            redirect_to books_path
        else
            render :edit
        end
    end

    def destroy
        @book.destroy
        #flash[:alert] = t "books.destroyed"
    end

    private

    def book_params
        params.require(:book).permit(:title, :author, :description, :pages_count, :published_at, :editor_name)
    end

    def find_book
        @book = Book.find params[:identifier]
        @book ||= Book.find_by_slug(params[:slug])
        raise ActionController::RoutingError.new("Not Found") unless @book
    end

    def store_editor_name
        session[:editor_name] = book_params[:editor_name]
    end
end