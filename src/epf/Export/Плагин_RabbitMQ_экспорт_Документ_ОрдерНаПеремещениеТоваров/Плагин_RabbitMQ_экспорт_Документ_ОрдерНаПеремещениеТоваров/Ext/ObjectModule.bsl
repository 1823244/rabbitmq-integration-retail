﻿#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_экспорт_Документ_ОрдерНаПеремещениеТоваров");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_экспорт_Документ_ОрдерНаПеремещениеТоваров");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_экспорт_Документ_ОрдерНаПеремещениеТоваров",
		"Форма_Плагин_RabbitMQ_экспорт_Документ_ОрдерНаПеремещениеТоваров",
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
	Если ТипЗнч(ДанныеСсылка) = Тип("ДокументСсылка.ОрдерНаПеремещениеТоваров") Тогда
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
	definition.Вставить("Договор", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Договор));
	definition.Вставить("ДокументОснование", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ДокументОснование));
	definition.Вставить("ЗаказПокупателя", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ЗаказПокупателя));
	definition.Вставить("Комментарий", Обк.Комментарий);
	definition.Вставить("Контрагент", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Контрагент));
	definition.Вставить("Магазин", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Магазин));
	definition.Вставить("Организация", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Организация));
	definition.Вставить("Ответственный", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Ответственный));
	definition.Вставить("СкладОтправитель", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СкладОтправитель));
	definition.Вставить("СкладПолучатель", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СкладПолучатель));
	definition.Вставить("СуммаДокумента", Обк.СуммаДокумента);

	//------------------------------------------------------     ТЧ Товары

	ТЧТовары = Новый Массив;

	Для сч = 0 По обк.Товары.Количество()-1 Цикл

		стрк = обк.Товары[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("КлючСвязи", стрк.КлючСвязи);
		НовСтр.Вставить("КлючСвязиСерийныхНомеров", стрк.КлючСвязиСерийныхНомеров);
		НовСтр.Вставить("Количество", стрк.Количество);
		НовСтр.Вставить("КоличествоУпаковок", стрк.КоличествоУпаковок);
		НовСтр.Вставить("Номенклатура", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Номенклатура));
		НовСтр.Вставить("СтатусУказанияСерий", стрк.СтатусУказанияСерий);
		НовСтр.Вставить("Сумма", стрк.Сумма);
		НовСтр.Вставить("Упаковка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Упаковка));
		НовСтр.Вставить("Характеристика", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Характеристика));
		НовСтр.Вставить("Цена", стрк.Цена);
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




	//------------------------------------------------------ ФИНАЛ


	СтруктураОбъекта.Вставить("definition", definition);
	ЗаписатьJSON(ЗаписьJson, СтруктураОбъекта);
	json = ЗаписьJson.Закрыть();
	Возврат json;
КонецФункции








