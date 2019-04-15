module BooksHelper
    def summary(book)
        summary = []
        summary << truncate(book.description, length: 30, separator:  " ") if book.description.present?
        summary << t("helpers.books.written_by", editor_name: book.editor_name) if book.editor_name.present?
        summary.join("... ")
    end
end