SELECT [Bookmarks].*, [Tags].Text  
             FROM [Bookmarks]  
             INNER JOIN [TagsInBookmarks] ON [TagsInBookmarks].BookmarkId = [Bookmarks].Id  
             INNER JOIN [Tags] ON [TagsInBookmarks].TagId = [Tags].Id  
             WHERE 