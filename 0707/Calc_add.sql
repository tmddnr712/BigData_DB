BEGIN
	DECLARE ADD VALUE INT;
	SET total_value = 0;
	label1: while total_value <= 3000 do
	SET total_value = total_value + starting_value;
	END while label1;
	RETURN total_value;
END