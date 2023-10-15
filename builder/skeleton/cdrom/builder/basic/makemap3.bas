DECLARE FUNCTION getpair! (code!, value$)
REM Converts .DXF into Image Map
'
Version$ = "3.03"
'Revision .03  2003-02-22  (Adds ability to handle suffix in range A-Z)
'Revision .02  2002-12-30  (Requests path rather than using default)
'Created  .01  2002-05-09
'
'Version 3.xx is rigourous version, base on true DXF specification
'
'
'Expects to find exactly two POINTS on drawing, for use as fiducals.
'Locates these on a first pass of the input file.
'
'On a second pass, looks specifically for TEXT entities.
'Each text string found is parsed to confirm it is a plausible grave number
'For each plausible grave, an HTML <AREA> tag is generated.


REM Define constants
DIM SHARED false, true, q$
false = 0
true = NOT false
q$ = CHR$(34)


CLS
PRINT "MAKEMAP   (DXF file to HTML Image Map Generator)"
PRINT "Version "; Version$
PRINT
PRINT

REM Get path for input and output files

INPUT "Path for Data Files (Blank to use current directory) "; path$
IF LEN(path$) <> 0 AND RIGHT$(path$, 1) <> "\" THEN path$ = path$ + "\"

REM force new default during program testing
'path$ = "c:\alan\ofhs\mi\eynsham\cdrom\plans\"


PRINT

REM Get area of graveyard and ensure lower case
INPUT "Area (a-z) "; area$
area$ = LCASE$(area$)


REM First identify fiducals

OPEN path$ + area$ + ".dxf" FOR INPUT AS #1

notfinished = getpair(code, value$)
pointcount = 0

WHILE notfinished
    IF code = 0 AND value$ = "POINT" THEN
        notfinished = getpair(code, value$)
        WHILE code <> 0
            SELECT CASE code
                CASE 10
                X(pointcount) = VAL(value$)
                CASE 20
                Y(pointcount) = VAL(value$)
            END SELECT
            notfinished = getpair(code, value$)
        WEND
        pointcount = pointcount + 1
    ELSE
        notfinished = getpair(code, value$)
    END IF
WEND
CLOSE

IF pointcount < 2 THEN PRINT "Error, less than 2 fiducal points": CLOSE : END
IF pointcount > 2 THEN PRINT "Error, more than 2 fiducal points": CLOSE : END

REM Sort the fiducals
IF X(0) > X(1) THEN SWAP X(0), X(1)
IF Y(0) > Y(1) THEN SWAP Y(0), Y(1)

PRINT "Located Fiducals"
PRINT
INPUT "Number of digits in grave number "; digits%
INPUT "Width  of Image in pixels "; xs
INPUT "Height of Image in pixels "; ys

X0 = X(0)
X1 = xs / (X(1) - X(0))
Y0 = Y(0)
Y1 = ys / (Y(1) - Y(0))


REM Now get the TEXT entries

OPEN path$ + area$ + ".dxf" FOR INPUT AS #1
OPEN path$ + "map" + area$ + ".txt" FOR OUTPUT AS #2

notfinished = getpair(code, value$)

WHILE notfinished
    IF code = 0 AND value$ = "TEXT" THEN
        notfinished = getpair(code, value$)
        WHILE code <> 0
            SELECT CASE code
                CASE 1
                name$ = value$
                CASE 10
                X = VAL(value$)
                CASE 11
                XR = VAL(value$)
                CASE 20
                Y = VAL(value$)
                CASE 21
                YR = VAL(value$)
                CASE 40
                H = VAL(value$)
            END SELECT
            notfinished = getpair(code, value$)
        WEND
        
        REM Now got a TEXT entity with its parameters
        '   So compute left, right, top and bottom of
        '   hotspot in World coordinates
       
        WL = X
        WR = XR
        WT = Y + H
        WB = Y

        REM Convert from World to Pixel coordinates

        PL = INT((WL - X0) * X1)
        PR = INT((WR - X0) * X1) + 2
        PT = ys - INT((WT - Y0) * Y1) - 2
        PB = ys - INT((WB - Y0) * Y1)


        REM Convert the text to a correct URL
        '   First check that the text contains a numeric part

        FOR i = 1 TO LEN(name$)
            num% = VAL(MID$(name$, i))
            IF num% > 0 THEN EXIT FOR
        NEXT i
        IF num% = 0 THEN GOTO Skip     'Ignore text with no numeric part

        REM Check for any non-numeric suffix letter
        suffix$ = LCASE$(RIGHT$(name$, 1))
        IF suffix$ < "a" THEN suffix$ = ""
       
        REM Add area prefix to any text before the numeric part
        '   and ensure string is all in lower case

        url$ = LCASE$(area$ + LEFT$(name$, i - 1))

        REM Create numeric$ with required number of leading zeros
        '   (Need to strip leading space produced by STR$() function)

        numeric$ = "00000000" + MID$(STR$(num%), 2)
        numeric$ = RIGHT$(numeric$, digits%)
        url$ = url$ + numeric$ + suffix$

        REM keep a copy for ALT text

        alt$ = UCASE$(url$)
       
        REM Add subdirectory portion and htm extension to URL

        url$ = area$ + "/" + url$ + ".htm"

     
        REM Format strings for area boundaries
       
        L$ = MID$(STR$(PL), 2)
        R$ = MID$(STR$(PR), 2)
        T$ = MID$(STR$(PT), 2)
        B$ = MID$(STR$(PB), 2)
     
        REM Output complete <AREA> tag

        PRINT #2, "<area coords=" + q$;
        PRINT #2, L$ + "," + T$ + "," + R$ + "," + B$ + q$;
        PRINT #2, " href=" + q$ + url$ + q$;
        PRINT #2, " alt=" + q$ + alt$ + q$ + ">"
     
Skip:
    ELSE
        notfinished = getpair(code, value$)
    END IF
WEND

CLOSE
END

FUNCTION getpair (code, value$)
REM Gets next pair of lines from DXF file
    INPUT #1, code
    LINE INPUT #1, value$
    IF EOF(1) OR value$ = "EOF" THEN getpair = false ELSE getpair = true
END FUNCTION

