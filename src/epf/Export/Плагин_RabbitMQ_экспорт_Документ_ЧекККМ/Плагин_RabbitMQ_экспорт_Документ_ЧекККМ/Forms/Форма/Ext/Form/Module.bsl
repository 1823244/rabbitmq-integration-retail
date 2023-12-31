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

	ТестовыйОбъект = Документы.ЧекККМ.СоздатьДокумент();

	ТестовыйОбъект.дата = ТекущаяДатаСеанса();

	//-------	ТАБЛИЧНЫЕ ЧАСТИ

	ТестовыйОбъект.Товары.Добавить();

	ТестовыйОбъект.Оплата.Добавить();

	ТестовыйОбъект.УправляемыеСкидки.Добавить();

	ТестовыйОбъект.Подарки.Добавить();

	ТестовыйОбъект.СкидкиНаценки.Добавить();

	ТестовыйОбъект.СерийныеНомера.Добавить();

	ТестовыйОбъект.СерииПодарков.Добавить();

	ТестовыйОбъект.ПогашениеПодарочныхСертификатов.Добавить();

	ТестовыйОбъект.Серии.Добавить();

	ТестовыйОбъект.БонусныеБаллыКНачислению.Добавить();

	ТестовыйОбъект.АкцизныеМарки.Добавить();

	ТестовыйОбъект.ПредъявленныеКодыОднократныхСкидок.Добавить();

	ТестовыйОбъект.КодыМаркировки.Добавить();

	ТестовыйОбъект.ТоварыОрганизации.Добавить();

	//-------	ФИНАЛ

	ТестовыйОбъект.ОбменДанными.Загрузка = Истина;

	ТестовыйОбъект.Записать();

	СсылочныйТип = ТестовыйОбъект.Ссылка;

	сообщить(ВыгрузитьОбъектНаСервере());

	ОтменитьТранзакцию();

КонецПроцедуры

&НаКлиенте
Процедура СоздатьТестовыйОбъект(Команда)
	СоздатьТестовыйОбъектНаСервере();
КонецПроцедуры


&НаСервере
Функция ВыгрузитьЗаПериодНаСервере()
	
	ВремяНачала = ТекущаяУниверсальнаяДатаВМиллисекундах();
	
	РеквизитФормыВЗначение("Объект").ВыгрузитьОбъектыЗаПериод(ПериодВыгрузки);
	
	ВремяРаботы = ТекущаяУниверсальнаяДатаВМиллисекундах() - ВремяНачала;
	
	return ВремяРаботы;
КонецФункции


&НаКлиенте
Процедура ВыгрузитьЗаПериод(Команда)
	ВремяРаботы = ВыгрузитьЗаПериодНаСервере();
	
	СОобщить("Время работы = "+Строка(ВремяРаботы)+" мс");
КонецПроцедуры


&НаСервере
Функция ВыгрузитьЗаПериодВерсия2НаСервере()
	ВремяНачала = ТекущаяУниверсальнаяДатаВМиллисекундах();
	
	РеквизитФормыВЗначение("Объект").ВыгрузитьОбъектыЗаПериод_Версия2(ПериодВыгрузки);
	
	ВремяРаботы = ТекущаяУниверсальнаяДатаВМиллисекундах() - ВремяНачала;
	
	return ВремяРаботы;
КонецФункции


&НаКлиенте
Процедура ВыгрузитьЗаПериодВерсия2(Команда)
	ВремяРаботы = ВыгрузитьЗаПериодВерсия2НаСервере();
	СОобщить("Время работы (версия 2) = "+Строка(ВремяРаботы)+" мс");
КонецПроцедуры


&НаСервере
Процедура СоздатьОбъектыДляТестаЭкспортаНаСервере()
	РеквизитФормыВЗначение("Объект").СоздатьОбъектыДляТестаЭкспорта();
КонецПроцедуры


&НаКлиенте
Процедура СоздатьОбъектыДляТестаЭкспорта(Команда)
	СоздатьОбъектыДляТестаЭкспортаНаСервере();
КонецПроцедуры

