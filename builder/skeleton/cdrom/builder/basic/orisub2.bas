REM orisub2.bas
Version$ = "1.1"

'Takes picdata.txt file and extracts just orientation data from it.
'A modified version of orient.bas, intended to accept data with a
'preceeding subdirectory name which must be stripped off.

PRINT
PRINT "ORISUB2  Version "; Version$

OPEN "picdata.txt" FOR INPUT AS #1
OPEN "orient.txt" FOR OUTPUT AS #2

WHILE NOT EOF(1)
    LINE INPUT #1, a$
    REM Remove any trailing spaces
    WHILE RIGHT$(a$, 1) = " "
        a$ = LEFT$(a$, LEN(a$) - 1)
    WEND
    a$ = LCASE$(a$)
    IF RIGHT$(a$, 4) = ".jpg" THEN
        'Strip subdirectory header
        PRINT #2, MID$(a$, 6)
    ELSEIF LEFT$(a$, 13) = "jpeg image is" THEN
        w = VAL(MID$(a$, 14))
        IF w < 10 THEN
            n = 19
        ELSEIF w < 100 THEN
            n = 20
        ELSEIF w < 1000 THEN
            n = 21
        ELSEIF w < 10000 THEN
            n = 22
        ELSE
            n = 23
        END IF
        h = VAL(MID$(a$, n))
        IF w > h THEN b$ = CHR$(163) ELSE b$ = "%"
        REM N.B. QB45 version of "œ" doesn't work in windows
        PRINT #2, b$
    END IF
WEND
CLOSE





