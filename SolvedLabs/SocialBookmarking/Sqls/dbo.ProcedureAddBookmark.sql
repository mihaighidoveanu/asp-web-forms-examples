CREATE PROCEDURE [dbo].[ProcedureAddBookmark]
	@title nvarchar(50),
	@description nvarchar,
	@url varchar,
	@createdAt date,
	@authorId uniqueidentifier,
	@photo varchar,
	@profile bit,
	@categoryTitle nvarchar(50)
AS
	            DECLARE @markpageId int;
                DECLARE @bookmarkId int;
                DECLARE @categoryId int;

                INSERT INTO Bookmarks(Title, Description, Url, CreatedAt, AuthorId, Photo) 
                VALUES(@title, @description, @url, @createdAt, @authorId, @photo);

                SELECT @bookmarkId = Bookmarks.Id              
                FROM Bookmarks
                WHERE Bookmarks.Title = @title AND Bookmarks.CreatedAt = @createdAt AND Bookmarks.AuthorId = @authorId;

                SELECT @markpageId = Markpages.Id
                FROM MarkPages
                WHERE MarkPages.UserId = @authorId;

                INSERT INTO BookmarksInProfile(MarkPageId,BookmarkId) 
                VALUES(@markpageId, @bookmarkId); 
                
                SELECT @categoryId = Categories.Id
                FROM Categories
                WHERE Categories.Title = @categoryTitle;

                IF @categoryId IS NOT Null
				BEGIN
					INSERT INTO BookmarksInCategory(BookmarkId,CategoryId,MarkPageId)
					VALUES(@bookmarkId,@categoryId,@markpageId);
                END
				ELSE
				BEGIN
					INSERT INTO Categories(Title,Description)
					VALUES(@title,@description);	

					SELECT @categoryId = SCOPE_IDENTITY();

					INSERT INTO BookmarksInCategory(BookmarkId,CategoryId,MarkPageId)
					VALUES(@bookmarkId,@categoryId,@markpageId);
				END;                
RETURN 0
