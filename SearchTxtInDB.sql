DECLARE @SearchText varchar(1000) = 'This text is wanted to be found';
 
/* From SPs */
SELECT DISTINCT SPName 
FROM (
    (SELECT ROUTINE_NAME SPName
        FROM INFORMATION_SCHEMA.ROUTINES
        WHERE ROUTINE_DEFINITION LIKE '%' + @SearchText + '%'
        AND ROUTINE_TYPE='PROCEDURE')
    UNION ALL
    (SELECT OBJECT_NAME(id) SPName
        FROM SYSCOMMENTS
        WHERE [text] LIKE '%' + @SearchText + '%'
        AND OBJECTPROPERTY(id, 'IsProcedure') = 1 
        GROUP BY OBJECT_NAME(id))
    UNION ALL
    (SELECT OBJECT_NAME(object_id) SPName
        FROM sys.sql_modules
        WHERE OBJECTPROPERTY(object_id, 'IsProcedure') = 1
        AND definition LIKE '%' + @SearchText + '%')
) AS T
ORDER BY T.SPName
 
/* From Functions and SPs */
SELECT DISTINCT
    o.name AS Object_Name,o.type_desc
    FROM sys.sql_modules        m
        INNER JOIN sys.objects  o ON m.object_id=o.object_id
    WHERE m.definition Like '%'+@SearchText+'%'
    ORDER BY 2,1
 
