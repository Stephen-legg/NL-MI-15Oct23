REM orimag.bas
Version$ = "2.0"


'Version 1.0
'Takes orient.txt file and checks for presence of magnified images
'(identified by a "m" as last letter of filename).
'If found the orientation code for the non-magnified image is
'amended to reflect this.
'Result is returned in orientm.txt

'Version 2.0
'Extends this mechanism to allow up to 9 separate magnified images
'with final letter of filename as "m" through to "u". There must be
'no gaps, so if no "m" is present program does not look for an "n".
'The orientation code is no longer changed, but a single digit in the
'range 0 to 9 is appended immediately following the orientation code
'to indicate the number of magnified images found.
'N.B. This requires a different version of Orienter macro to interpret.

PRINT
PRINT "ORIMAG  Version "; Version$

DIM mag$(5000)  'Array to hold list of all graves with a magnified image

FALSE = 0
TRUE = NOT FALSE

'First pass. Build mag$ array

OPEN "orient.txt" FOR INPUT AS #1
n = 0

WHILE NOT EOF(1)
    LINE INPUT #1, a$
    b$ = MID$(a$, LEN(a$) - 4, 1)
    c$ = LEFT$(a$, LEN(a$) - 5) + RIGHT$(a$, 4)
    IF b$ >= "m" AND b$ <= "u" THEN
        notInList = TRUE
        FOR i = 0 TO n - 1
            bb$ = LEFT$(mag$(i), 1)
            cc$ = MID$(mag$(i), 2)
            IF c$ = cc$ THEN
                IF b$ > bb$ THEN bb$ = b$
                mag$(i) = bb$ + cc$
                notInList = FALSE
            END IF
        NEXT i
        IF notInList THEN
            mag$(n) = b$ + c$
            n = n + 1
        END IF
    END IF
    LINE INPUT #1, a$   'Bypass code line
WEND
CLOSE 1


'Second Pass. Ammend codes

OPEN "orient.txt" FOR INPUT AS #1
OPEN "orientm.txt" FOR OUTPUT AS #2


WHILE NOT EOF(1)
    LINE INPUT #1, a$
    PRINT #2, a$
    FOR i = 0 TO n - 1
        bb$ = LEFT$(mag$(i), 1)
        cc$ = MID$(mag$(i), 2)
        IF a$ = cc$ THEN i = 9999
    NEXT i

    LINE INPUT #1, a$
    IF i > 9999 THEN
        b$ = CHR$(ASC(bb$) - ASC("m") + ASC("1"))
    ELSE
        b$ = "0"
    END IF
    PRINT #2, a$ + b$
WEND

CLOSE





