SELECT STRING_AGG(CHR(value), '') AS character
FROM letters_b
WHERE
    (value >= 65 AND value < 90)  -- Uppercase letters A-Z
    OR (value >= 97 AND value < 123)  -- Lowercase letters a-z
    OR value = 32  -- Space
    OR CHR(value) IN ('!', '"', '''', '(', ')', ',', '-', '.', ':', ';', '?');  -- Symbols

