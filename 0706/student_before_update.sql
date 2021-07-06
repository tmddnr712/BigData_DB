BEGIN
	SET NEW.total = NEW.kor + NEW.mat + NEW.eng;
	SET NEW.average = ROUND(NEW.total / 3,2);
	
	if NEW.average >= 90 then SET new.grade = 'A';
	ELSEIF NEW.average >= 80 then SET new.grade = 'B';
	ELSEIF NEW.average >= 70 then SET new.grade = 'C';
	ELSEIF NEW.average >= 60 then SET new.grade = 'D';
	ELSE SET NEW.grade = 'F';
	END if;	
	
END