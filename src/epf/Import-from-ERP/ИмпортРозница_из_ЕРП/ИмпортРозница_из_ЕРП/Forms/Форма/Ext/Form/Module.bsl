﻿
&НаСервере
Процедура ТестИмпортаНСИНаСервере()
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ТестИмпортаНСИ(Команда)
	ТестИмпортаНСИНаСервере();
КонецПроцедуры





&НаСервере
Процедура ВыполнитьИмпортНаСервере()
	РеквизитФормыВЗначение("Объект").ВыполнитьИмпорт();
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьИмпорт(Команда)
	ВыполнитьИмпортНаСервере();
	ПоказатьПредупреждение(,"Импорт завершен");
КонецПроцедуры
