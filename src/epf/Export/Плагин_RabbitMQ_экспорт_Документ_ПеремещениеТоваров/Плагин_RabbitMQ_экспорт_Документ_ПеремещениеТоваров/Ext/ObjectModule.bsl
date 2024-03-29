﻿#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.2");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_экспорт_Документ_ПеремещениеТоваров");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_экспорт_Документ_ПеремещениеТоваров");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_экспорт_Документ_ПеремещениеТоваров",
		"Форма_Плагин_RabbitMQ_экспорт_Документ_ПеремещениеТоваров",
		ТипКоманды, 
		Ложь) ;
	
	
	Возврат ПараметрыРегистрации;
	
КонецФункции

Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")

	//ТаблицаКоманд.Колонки.Добавить("Представление", РеквизитыТабличнойЧасти.Представление.Тип);
	//ТаблицаКоманд.Колонки.Добавить("Идентификатор", РеквизитыТабличнойЧасти.Идентификатор.Тип);
	//ТаблицаКоманд.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка"));
	//ТаблицаКоманд.Колонки.Добавить("ПоказыватьОповещение", РеквизитыТабличнойЧасти.ПоказыватьОповещение.Тип);
	//ТаблицаКоманд.Колонки.Добавить("Модификатор", РеквизитыТабличнойЧасти.Модификатор.Тип);
	//ТаблицаКоманд.Колонки.Добавить("Скрыть",      РеквизитыТабличнойЧасти.Скрыть.Тип);
	//ТаблицаКоманд.Колонки.Добавить("ЗаменяемыеКоманды", РеквизитыТабличнойЧасти.ЗаменяемыеКоманды.Тип);
	
//           ** Использование - Строка - тип команды:
//               "ВызовКлиентскогоМетода",
//               "ВызовСерверногоМетода",
//               "ЗаполнениеФормы",
//               "ОткрытиеФормы" или
//               "СценарийВБезопасномРежиме".
//               Для получения типов команд рекомендуется использовать функции
//               ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКоманды<ИмяТипа>.
//               В комментариях к этим функциям также даны шаблоны процедур-обработчиков команд.

	НоваяКоманда = ТаблицаКоманд.Добавить() ;
	НоваяКоманда.Представление = Представление ;
	НоваяКоманда.Идентификатор = Идентификатор ;
	НоваяКоманда.Использование = Использование ;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение ;
	НоваяКоманда.Модификатор = Модификатор ;
КонецПроцедуры


#КонецОбласти 	

Функция ВыгрузитьОбъект(ДанныеСсылка) Экспорт
	Если ТипЗнч(ДанныеСсылка) = Тип("ДокументСсылка.ПеремещениеТоваров") Тогда
		Обк = ДанныеСсылка.ПолучитьОбъект(); 
	Иначе 
		Обк = ДанныеСсылка; 
	КонецЕсли;
	ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Авто, Символы.Таб);
	ЗаписьJson = Новый ЗаписьJSON;
	ЗаписьJson.УстановитьСтроку(ПараметрыЗаписиJSON);
	// Это основной объект json-сообщения
	СтруктураОбъекта = Новый Структура;
	СтруктураОбъекта.Вставить("source", "retail");
	СтруктураОбъекта.Вставить("type", Обк.метаданные().ПолноеИмя());
	СтруктураОбъекта.Вставить("datetime", XMLСтрока(ТекущаяДатаСеанса()));
	identification = ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Ссылка);
	СтруктураОбъекта.Вставить("identification", identification);
	//	DEFINITION          
	definition = ксп_ЭкспортСлужебный.СоздатьУзелDefinition(Обк.Ссылка);
	definition.Вставить("ДокументОснование", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ДокументОснование));
	definition.Вставить("Комментарий", Обк.Комментарий);
	definition.Вставить("МагазинОтправитель", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.МагазинОтправитель));
	definition.Вставить("МагазинПолучатель", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.МагазинПолучатель));
	definition.Вставить("Организация", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Организация));
	definition.Вставить("ОрганизацияПолучатель", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ОрганизацияПолучатель));
	definition.Вставить("Ответственный", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Ответственный));
	definition.Вставить("ПредставлениеДокументаОснования", Обк.ПредставлениеДокументаОснования);
	definition.Вставить("СкладОтправитель", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СкладОтправитель));
	definition.Вставить("СкладПолучатель", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СкладПолучатель));
	definition.Вставить("СуммаДокумента", Обк.СуммаДокумента);
	definition.Вставить("ТТНВходящаяЕГАИС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ТТНВходящаяЕГАИС));
	definition.Вставить("ТТНИсходящаяЕГАИС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ТТНИсходящаяЕГАИС));
	definition.Вставить("УдалитьСтатусОбработки_ЕГАИС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.УдалитьСтатусОбработки_ЕГАИС));
	definition.Вставить("УдалитьТоварноТранспортнаяНакладнаяЕГАИСИсходящая", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.УдалитьТоварноТранспортнаяНакладнаяЕГАИСИсходящая));
	definition.Вставить("ФиксироватьНомераГТД", Обк.ФиксироватьНомераГТД);
	
	definition.Вставить("КСП_НеНуженВЕРП", Обк.КСП_НеНуженВЕРП);
	
	//------------------------------------------------------     ТЧ Товары

	ТЧТовары = Новый Массив;

	Для сч = 0 По обк.Товары.Количество()-1 Цикл

		стрк = обк.Товары[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("КлючСвязи", стрк.КлючСвязи);
		НовСтр.Вставить("КлючСвязиСерийныхНомеров", стрк.КлючСвязиСерийныхНомеров);
		НовСтр.Вставить("Количество", стрк.Количество);
		НовСтр.Вставить("КоличествоПоРНПТ", стрк.КоличествоПоРНПТ);
		НовСтр.Вставить("КоличествоУпаковок", стрк.КоличествоУпаковок);
		НовСтр.Вставить("НеобходимостьВводаАкцизнойМарки", стрк.НеобходимостьВводаАкцизнойМарки);
		НовСтр.Вставить("Номенклатура", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Номенклатура));
		НовСтр.Вставить("НомерГТД", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.НомерГТД));
		НовСтр.Вставить("Справка2", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Справка2));
		НовСтр.Вставить("СтатусУказанияСерий", стрк.СтатусУказанияСерий);
		НовСтр.Вставить("СтатусУказанияСерийОтправитель", стрк.СтатусУказанияСерийОтправитель);
		НовСтр.Вставить("СтатусУказанияСерийПолучатель", стрк.СтатусУказанияСерийПолучатель);
		НовСтр.Вставить("Сумма", стрк.Сумма);
		НовСтр.Вставить("УдалитьСправка1", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.УдалитьСправка1));
		НовСтр.Вставить("Упаковка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Упаковка));
		НовСтр.Вставить("Характеристика", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Характеристика));
		НовСтр.Вставить("Цена", стрк.Цена);
		НовСтр.Вставить("Штрихкод", стрк.Штрихкод);
		ТЧТовары.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧТовары", ТЧТовары);

	//------------------------------------------------------     ТЧ СерийныеНомера

	ТЧСерийныеНомера = Новый Массив;

	Для сч = 0 По обк.СерийныеНомера.Количество()-1 Цикл

		стрк = обк.СерийныеНомера[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("КлючСвязиСерийныхНомеров", стрк.КлючСвязиСерийныхНомеров);
		НовСтр.Вставить("СерийныйНомер", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СерийныйНомер));
		ТЧСерийныеНомера.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧСерийныеНомера", ТЧСерийныеНомера);

	//------------------------------------------------------     ТЧ Серии

	ТЧСерии = Новый Массив;

	Для сч = 0 По обк.Серии.Количество()-1 Цикл

		стрк = обк.Серии[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("Количество", стрк.Количество);
		НовСтр.Вставить("Номенклатура", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Номенклатура));
		НовСтр.Вставить("Серия", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Серия));
		НовСтр.Вставить("Характеристика", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Характеристика));
		ТЧСерии.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧСерии", ТЧСерии);

	//------------------------------------------------------     ТЧ УдалитьШтрихкодыУпаковок

	ТЧУдалитьШтрихкодыУпаковок = Новый Массив;

	Для сч = 0 По обк.УдалитьШтрихкодыУпаковок.Количество()-1 Цикл

		стрк = обк.УдалитьШтрихкодыУпаковок[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("ШтрихкодУпаковки", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ШтрихкодУпаковки));
		ТЧУдалитьШтрихкодыУпаковок.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧУдалитьШтрихкодыУпаковок", ТЧУдалитьШтрихкодыУпаковок);

	//------------------------------------------------------     ТЧ АкцизныеМарки

	ТЧАкцизныеМарки = Новый Массив;

	Для сч = 0 По обк.АкцизныеМарки.Количество()-1 Цикл

		стрк = обк.АкцизныеМарки[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("АкцизнаяМарка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.АкцизнаяМарка));
		НовСтр.Вставить("КлючСвязи", стрк.КлючСвязи);
		НовСтр.Вставить("КодАкцизнойМарки", стрк.КодАкцизнойМарки);
		НовСтр.Вставить("Справка2", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Справка2));
		НовСтр.Вставить("ШтрихкодУпаковки", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ШтрихкодУпаковки));
		ТЧАкцизныеМарки.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧАкцизныеМарки", ТЧАкцизныеМарки);




	//------------------------------------------------------ ФИНАЛ


	СтруктураОбъекта.Вставить("definition", definition);
	ЗаписатьJSON(ЗаписьJson, СтруктураОбъекта);
	json = ЗаписьJson.Закрыть();
	Возврат json;
КонецФункции








