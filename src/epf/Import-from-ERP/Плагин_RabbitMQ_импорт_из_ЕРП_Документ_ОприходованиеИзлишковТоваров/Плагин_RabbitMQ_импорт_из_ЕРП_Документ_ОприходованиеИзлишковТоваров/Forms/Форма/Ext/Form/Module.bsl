﻿

&НаСервере
Функция ЗагрузитьИзJsonНаСервере()
	Ссылка = РеквизитФормыВЗначение("Объект").ЗагрузитьИзJsonНаСервере(JsonText);
    Возврат Ссылка;
КонецФункции

&НаКлиенте
Процедура ЗагрузитьИзJson(Команда)
	Ссылка = ЗагрузитьИзJsonНаСервере();
	СсылочныйТип = ссылка;
	Сообщить(НСтр("ru = '"+строка(ссылка)+"'"), СтатусСообщения.БезСтатуса);
КонецПроцедуры

