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

	ТестовыйОбъект = Справочники.СтатьиДвиженияДенежныхСредств.СоздатьЭлемент();

	

	//-------	ТАБЛИЧНЫЕ ЧАСТИ

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
