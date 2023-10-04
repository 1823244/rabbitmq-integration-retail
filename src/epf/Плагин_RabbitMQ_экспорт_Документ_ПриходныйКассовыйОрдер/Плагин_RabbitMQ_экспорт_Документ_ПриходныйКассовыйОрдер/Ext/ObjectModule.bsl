﻿#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_экспорт_Документ_ПриходныйКассовыйОрдер");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_экспорт_Документ_ПриходныйКассовыйОрдер");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_экспорт_Документ_ПриходныйКассовыйОрдер",
		"Форма_Плагин_RabbitMQ_экспорт_Документ_ПриходныйКассовыйОрдер",
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
	Если ТипЗнч(ДанныеСсылка) = Тип("ДокументСсылка.ПриходныйКассовыйОрдер") Тогда
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
	definition.Вставить("АдресЭП", Обк.АдресЭП);
	definition.Вставить("БанковскийСчет", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.БанковскийСчет));
	definition.Вставить("ВТомЧислеНДС", Обк.ВТомЧислеНДС);
	definition.Вставить("ДоговорКонтрагента", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ДоговорКонтрагента));
	definition.Вставить("ДокументОснование", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ДокументОснование));
	definition.Вставить("ЗаказПокупателя", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ЗаказПокупателя));
	definition.Вставить("Касса", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Касса));
	definition.Вставить("КассаККМ", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.КассаККМ));
	definition.Вставить("Комментарий", Обк.Комментарий);
	definition.Вставить("Контрагент", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Контрагент));
	definition.Вставить("НомерЧекаККМ", Обк.НомерЧекаККМ);
	definition.Вставить("Организация", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Организация));
	definition.Вставить("Основание", Обк.Основание);
	definition.Вставить("Ответственный", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Ответственный));
	definition.Вставить("ОтчетОРозничныхПродажах", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ОтчетОРозничныхПродажах));
	definition.Вставить("Приложение", Обк.Приложение);
	definition.Вставить("ПринятоОт", Обк.ПринятоОт);
	definition.Вставить("ПробиватьЧекиПоКассеККМ", Обк.ПробиватьЧекиПоКассеККМ);
	definition.Вставить("ПробитЧек", Обк.ПробитЧек);
	definition.Вставить("СистемаНалогообложения", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СистемаНалогообложения));
	definition.Вставить("СменаЗакрыта", Обк.СменаЗакрыта);
	definition.Вставить("СуммаДокумента", Обк.СуммаДокумента);
	definition.Вставить("Телефон", Обк.Телефон);
	definition.Вставить("УдалитьБанковскийСчет", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.УдалитьБанковскийСчет));
	definition.Вставить("УдалитьВидНалога", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.УдалитьВидНалога));
	definition.Вставить("ХозяйственнаяОперация", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ХозяйственнаяОперация));

	//------------------------------------------------------     ТЧ РасшифровкаПлатежа

	ТЧРасшифровкаПлатежа = Новый Массив;

	Для сч = 0 По обк.РасшифровкаПлатежа.Количество()-1 Цикл

		стрк = обк.РасшифровкаПлатежа[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("ДокументРасчетовСКонтрагентом", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ДокументРасчетовСКонтрагентом));
		НовСтр.Вставить("ПризнакСпособаРасчета", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ПризнакСпособаРасчета));
		НовСтр.Вставить("СтатьяДвиженияДенежныхСредств", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СтатьяДвиженияДенежныхСредств));
		НовСтр.Вставить("Сумма", стрк.Сумма);
		ТЧРасшифровкаПлатежа.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧРасшифровкаПлатежа", ТЧРасшифровкаПлатежа);




	//------------------------------------------------------ ФИНАЛ


	СтруктураОбъекта.Вставить("definition", definition);
	ЗаписатьJSON(ЗаписьJson, СтруктураОбъекта);
	json = ЗаписьJson.Закрыть();
	Возврат json;
КонецФункции




