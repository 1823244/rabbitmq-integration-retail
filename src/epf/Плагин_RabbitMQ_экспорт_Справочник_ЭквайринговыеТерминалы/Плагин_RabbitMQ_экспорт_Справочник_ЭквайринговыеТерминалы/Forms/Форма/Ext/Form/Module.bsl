﻿
&НаСервере
Функция ВыгрузитьОбъектНаСервере()
	json = РеквизитФормыВЗначение("Объект").ВыгрузитьОбъект(СсылочныйТип);
	return json;
КонецФункции

&НаКлиенте
Процедура ВыгрузитьОбъект(Команда)
	json = ВыгрузитьОбъектНаСервере();
	message(json);
КонецПроцедуры




&НаСервере


Процедура СоздатьТестовыйОбъектНаСервере()

	НачатьТранзакцию();

	ТестовыйОбъект = Справочники.ЭквайринговыеТерминалы.СоздатьЭлемент();

	

	//-------	ТАБЛИЧНЫЕ ЧАСТИ

	ТестовыйОбъект.ТарифыЗаРасчетноеОбслуживание.Добавить();

	//-------	ФИНАЛ

	ТестовыйОбъект.ОбменДанными.Загрузка = Истина;

	ТестовыйОбъект.Записать();

	СсылочныйТип = ТестовыйОбъект.Ссылка;

	сообщить(ВыгрузитьОбъектНаСервере());

	ОтменитьТранзакцию();

КонецПроцедуры

&НаКлиенте
Процедура создатьТестовыйОбъект(Команда)
	создатьТестовыйОбъектНаСервере();
КонецПроцедуры
