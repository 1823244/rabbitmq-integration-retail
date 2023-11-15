﻿#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.3");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_экспорт_Документ_ЧекККМ");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_экспорт_Документ_ЧекККМ");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_экспорт_Документ_ЧекККМ",
		"Форма_Плагин_RabbitMQ_экспорт_Документ_ЧекККМ",
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
	Если ТипЗнч(ДанныеСсылка) = Тип("ДокументСсылка.ЧекККМ") Тогда
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
	definition.Вставить("АдресЧекаЕГАИС", Обк.АдресЧекаЕГАИС);
	definition.Вставить("АдресЭП", Обк.АдресЭП);
	definition.Вставить("АналитикаХозяйственнойОперации", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.АналитикаХозяйственнойОперации));
	definition.Вставить("БонусыНачислены", Обк.БонусыНачислены);
	definition.Вставить("ВидОперации", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ВидОперации));
	definition.Вставить("ВладелецДисконтнойКарты", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ВладелецДисконтнойКарты));
	definition.Вставить("ВыручкаНаличными", Обк.ВыручкаНаличными);
	definition.Вставить("ДатаРождения", Обк.ДатаРождения);
	definition.Вставить("ДисконтнаяКарта", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ДисконтнаяКарта));
	definition.Вставить("ДоговорКонтрагента", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ДоговорКонтрагента));
	definition.Вставить("ДокументРасчета", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ДокументРасчета));
	definition.Вставить("ЗаказПокупателя", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ЗаказПокупателя));
	definition.Вставить("ИдентификаторЧекаВОчереди", Обк.ИдентификаторЧекаВОчереди);
	definition.Вставить("КассаККМ", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.КассаККМ));
	definition.Вставить("КодТРУ", Обк.КодТРУ);
	definition.Вставить("Комментарий", Обк.Комментарий);
	definition.Вставить("Контрагент", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Контрагент));
	definition.Вставить("Магазин", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Магазин));
	definition.Вставить("НомерСменыККМ", Обк.НомерСменыККМ);
	definition.Вставить("НомерЧекаККМ", Обк.НомерЧекаККМ);
	definition.Вставить("ОперацияСДенежнымиСредствами", Обк.ОперацияСДенежнымиСредствами);
	definition.Вставить("Оплачивается", Обк.Оплачивается);
	definition.Вставить("Организация", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Организация));
	definition.Вставить("Ответственный", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Ответственный));
	definition.Вставить("ОтработанПереход", Обк.ОтработанПереход);
	definition.Вставить("ОтчетОРозничныхПродажах", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ОтчетОРозничныхПродажах));
	definition.Вставить("ПоДокументу", Обк.ПоДокументу);
	definition.Вставить("ПодписьЧекаЕГАИС", Обк.ПодписьЧекаЕГАИС);
	definition.Вставить("Продавец", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.Продавец));
	definition.Вставить("СистемаНалогообложения", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СистемаНалогообложения));
	definition.Вставить("СкидкиРассчитаны", Обк.СкидкиРассчитаны);
	definition.Вставить("СсылкаЯндексКассы", Обк.СсылкаЯндексКассы);
	definition.Вставить("СтатусЧекаККМ", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.СтатусЧекаККМ));
	definition.Вставить("СуммаДокумента", Обк.СуммаДокумента);
	definition.Вставить("Телефон", Обк.Телефон);
	definition.Вставить("УдалитьВидНалога", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.УдалитьВидНалога));
	definition.Вставить("УдалитьДоговорЭквайринга", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.УдалитьДоговорЭквайринга));
	definition.Вставить("УникальныйИдентификаторПлатежа", Обк.УникальныйИдентификаторПлатежа);
	definition.Вставить("ЦенаВключаетНДС", Обк.ЦенаВключаетНДС);
	definition.Вставить("ЧекККМПродажа", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(Обк.ЧекККМПродажа));

	//------------------------------------------------------     ТЧ Товары

	ТЧТовары = Новый Массив;

	Для сч = 0 По обк.Товары.Количество()-1 Цикл

		стрк = обк.Товары[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("ДоговорКонтрагента", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ДоговорКонтрагента));
		НовСтр.Вставить("ЗаказПокупателя", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ЗаказПокупателя));
		НовСтр.Вставить("КлючСвязи", стрк.КлючСвязи);
		НовСтр.Вставить("КлючСвязиСерийныхНомеров", стрк.КлючСвязиСерийныхНомеров);
		НовСтр.Вставить("КлючСвязиУслугаАгента", стрк.КлючСвязиУслугаАгента);
		НовСтр.Вставить("КодСтроки", стрк.КодСтроки);
		НовСтр.Вставить("Количество", стрк.Количество);
		НовСтр.Вставить("КоличествоУпаковок", стрк.КоличествоУпаковок);
		НовСтр.Вставить("МРЦ", стрк.МРЦ);
		НовСтр.Вставить("НеобходимостьВводаАкцизнойМарки", стрк.НеобходимостьВводаАкцизнойМарки);
		НовСтр.Вставить("НеобходимостьВводаКодаМаркировки", стрк.НеобходимостьВводаКодаМаркировки);
		НовСтр.Вставить("Номенклатура", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Номенклатура));
		НовСтр.Вставить("Продавец", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Продавец));
		НовСтр.Вставить("ПродажаПодарка", стрк.ПродажаПодарка);
		НовСтр.Вставить("ПроцентАвтоматическойСкидки", стрк.ПроцентАвтоматическойСкидки);
		НовСтр.Вставить("ПроцентРучнойСкидки", стрк.ПроцентРучнойСкидки);
		НовСтр.Вставить("РегистрацияПродажи", стрк.РегистрацияПродажи);
		НовСтр.Вставить("Резервировать", стрк.Резервировать);
		НовСтр.Вставить("Склад", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Склад));
		НовСтр.Вставить("СтавкаНДС", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СтавкаНДС));
		НовСтр.Вставить("СтатусУказанияСерий", стрк.СтатусУказанияСерий);
		НовСтр.Вставить("Сумма", стрк.Сумма);
		НовСтр.Вставить("СуммаАвтоматическойСкидки", стрк.СуммаАвтоматическойСкидки);
		НовСтр.Вставить("СуммаНДС", стрк.СуммаНДС);
		НовСтр.Вставить("СуммаРучнойСкидки", стрк.СуммаРучнойСкидки);
		НовСтр.Вставить("СуммаСкидкиОплатыБонусом", стрк.СуммаСкидкиОплатыБонусом);
		НовСтр.Вставить("Упаковка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Упаковка));
		НовСтр.Вставить("Характеристика", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Характеристика));
		НовСтр.Вставить("Цена", стрк.Цена);
		НовСтр.Вставить("Штрихкод", стрк.Штрихкод);
		ТЧТовары.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧТовары", ТЧТовары);

	//------------------------------------------------------     ТЧ Оплата

	ТЧОплата = Новый Массив;

	Для сч = 0 По обк.Оплата.Количество()-1 Цикл

		стрк = обк.Оплата[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("БонуснаяПрограммаЛояльности", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.БонуснаяПрограммаЛояльности));
		НовСтр.Вставить("ВидОплаты", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ВидОплаты));
		НовСтр.Вставить("ДанныеПереданыВБанк", стрк.ДанныеПереданыВБанк);
		НовСтр.Вставить("ДоговорКонтрагента", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ДоговорКонтрагента));
		НовСтр.Вставить("КлючСвязиОплаты", стрк.КлючСвязиОплаты);
		НовСтр.Вставить("КоличествоБонусов", стрк.КоличествоБонусов);
		НовСтр.Вставить("КоличествоБонусовВСкидках", стрк.КоличествоБонусовВСкидках);
		НовСтр.Вставить("НомерПлатежнойКарты", стрк.НомерПлатежнойКарты);
		НовСтр.Вставить("НомерЧекаЭТ", стрк.НомерЧекаЭТ);
		НовСтр.Вставить("ПроцентКомиссии", стрк.ПроцентКомиссии);
		НовСтр.Вставить("СсылочныйНомер", стрк.СсылочныйНомер);
		НовСтр.Вставить("Сумма", стрк.Сумма);
		НовСтр.Вставить("СуммаБонусовВСкидках", стрк.СуммаБонусовВСкидках);
		НовСтр.Вставить("СуммаКомиссии", стрк.СуммаКомиссии);
		НовСтр.Вставить("ЭквайринговыйТерминал", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ЭквайринговыйТерминал));
		ТЧОплата.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧОплата", ТЧОплата);

	//------------------------------------------------------     ТЧ УправляемыеСкидки

	ТЧУправляемыеСкидки = Новый Массив;

	Для сч = 0 По обк.УправляемыеСкидки.Количество()-1 Цикл

		стрк = обк.УправляемыеСкидки[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("СкидкаНаценка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СкидкаНаценка));
		ТЧУправляемыеСкидки.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧУправляемыеСкидки", ТЧУправляемыеСкидки);

	//------------------------------------------------------     ТЧ Подарки

	ТЧПодарки = Новый Массив;

	Для сч = 0 По обк.Подарки.Количество()-1 Цикл

		стрк = обк.Подарки[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("КлючСвязи", стрк.КлючСвязи);
		НовСтр.Вставить("Количество", стрк.Количество);
		НовСтр.Вставить("КоличествоУпаковок", стрк.КоличествоУпаковок);
		НовСтр.Вставить("Номенклатура", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Номенклатура));
		НовСтр.Вставить("СкидкаНаценка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СкидкаНаценка));
		НовСтр.Вставить("Склад", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Склад));
		НовСтр.Вставить("Справка2", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Справка2));
		НовСтр.Вставить("СтатусУказанияСерий", стрк.СтатусУказанияСерий);
		НовСтр.Вставить("Сумма", стрк.Сумма);
		НовСтр.Вставить("Упаковка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Упаковка));
		НовСтр.Вставить("Характеристика", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Характеристика));
		НовСтр.Вставить("Цена", стрк.Цена);
		НовСтр.Вставить("ШтрихкодУпаковки", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ШтрихкодУпаковки));
		ТЧПодарки.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧПодарки", ТЧПодарки);

	//------------------------------------------------------     ТЧ СкидкиНаценки

	ТЧСкидкиНаценки = Новый Массив;

	Для сч = 0 По обк.СкидкиНаценки.Количество()-1 Цикл

		стрк = обк.СкидкиНаценки[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("КлючСвязи", стрк.КлючСвязи);
		НовСтр.Вставить("ОграниченаМинимальнойЦеной", стрк.ОграниченаМинимальнойЦеной);
		НовСтр.Вставить("СкидкаНаценка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СкидкаНаценка));
		НовСтр.Вставить("Сумма", стрк.Сумма);
		ТЧСкидкиНаценки.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧСкидкиНаценки", ТЧСкидкиНаценки);

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

	//------------------------------------------------------     ТЧ СерииПодарков

	ТЧСерииПодарков = Новый Массив;

	Для сч = 0 По обк.СерииПодарков.Количество()-1 Цикл

		стрк = обк.СерииПодарков[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("КлючСвязи", стрк.КлючСвязи);
		НовСтр.Вставить("Количество", стрк.Количество);
		НовСтр.Вставить("Номенклатура", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Номенклатура));
		НовСтр.Вставить("Серия", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Серия));
		НовСтр.Вставить("Характеристика", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Характеристика));
		ТЧСерииПодарков.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧСерииПодарков", ТЧСерииПодарков);

	//------------------------------------------------------     ТЧ ПогашениеПодарочныхСертификатов

	ТЧПогашениеПодарочныхСертификатов = Новый Массив;

	Для сч = 0 По обк.ПогашениеПодарочныхСертификатов.Количество()-1 Цикл

		стрк = обк.ПогашениеПодарочныхСертификатов[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("ПодарочныйСертификат", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ПодарочныйСертификат));
		НовСтр.Вставить("СерийныйНомер", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СерийныйНомер));
		НовСтр.Вставить("СуммаПогашенияСертификата", стрк.СуммаПогашенияСертификата);
		ТЧПогашениеПодарочныхСертификатов.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧПогашениеПодарочныхСертификатов", ТЧПогашениеПодарочныхСертификатов);

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

	//------------------------------------------------------     ТЧ БонусныеБаллыКНачислению

	ТЧБонусныеБаллыКНачислению = Новый Массив;

	Для сч = 0 По обк.БонусныеБаллыКНачислению.Количество()-1 Цикл

		стрк = обк.БонусныеБаллыКНачислению[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("БонуснаяПрограммаЛояльности", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.БонуснаяПрограммаЛояльности));
		НовСтр.Вставить("ДатаНачисления", стрк.ДатаНачисления);
		НовСтр.Вставить("ДатаСписания", стрк.ДатаСписания);
		НовСтр.Вставить("КлючСвязи", стрк.КлючСвязи);
		НовСтр.Вставить("КоличествоБонусныхБаллов", стрк.КоличествоБонусныхБаллов);
		НовСтр.Вставить("СкидкаНаценка", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.СкидкаНаценка));
		ТЧБонусныеБаллыКНачислению.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧБонусныеБаллыКНачислению", ТЧБонусныеБаллыКНачислению);

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

	//------------------------------------------------------     ТЧ ПредъявленныеКодыОднократныхСкидок

	ТЧПредъявленныеКодыОднократныхСкидок = Новый Массив;

	Для сч = 0 По обк.ПредъявленныеКодыОднократныхСкидок.Количество()-1 Цикл

		стрк = обк.ПредъявленныеКодыОднократныхСкидок[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("КодСкидки", стрк.КодСкидки);
		ТЧПредъявленныеКодыОднократныхСкидок.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧПредъявленныеКодыОднократныхСкидок", ТЧПредъявленныеКодыОднократныхСкидок);

	//------------------------------------------------------     ТЧ КодыМаркировки

	ТЧКодыМаркировки = Новый Массив;

	Для сч = 0 По обк.КодыМаркировки.Количество()-1 Цикл

		стрк = обк.КодыМаркировки[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("КлючСвязи", стрк.КлючСвязи);
		НовСтр.Вставить("КодМаркировки", стрк.КодМаркировки);
		НовСтр.Вставить("ТипКода", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.ТипКода));
		ТЧКодыМаркировки.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧКодыМаркировки", ТЧКодыМаркировки);

	//------------------------------------------------------     ТЧ ТоварыОрганизации

	ТЧТоварыОрганизации = Новый Массив;

	Для сч = 0 По обк.ТоварыОрганизации.Количество()-1 Цикл

		стрк = обк.ТоварыОрганизации[сч];

		НовСтр = Новый Структура;

		НовСтр.Вставить("Договор", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Договор));
		НовСтр.Вставить("КлючСвязи", стрк.КлючСвязи);
		НовСтр.Вставить("Количество", стрк.Количество);
		НовСтр.Вставить("Номенклатура", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Номенклатура));
		НовСтр.Вставить("НомерГТД", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.НомерГТД));
		НовСтр.Вставить("Поставщик", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Поставщик));
		НовСтр.Вставить("Характеристика", ксп_ЭкспортСлужебный.СоздатьУзелIdentification(стрк.Характеристика));
		ТЧТоварыОрганизации.Добавить(НовСтр);

	КонецЦикла;

	definition.Вставить("ТЧТоварыОрганизации", ТЧТоварыОрганизации);




	//------------------------------------------------------ ФИНАЛ


	СтруктураОбъекта.Вставить("definition", definition);
	ЗаписатьJSON(ЗаписьJson, СтруктураОбъекта);
	json = ЗаписьJson.Закрыть();
	Возврат json;
КонецФункции


// для тестирования. выполняет выгрузку без регистрации объектов в плане обмена
//
// Параметры:
//	ПериодВыгрузки 	- СтандартныйПериод - 
//
Процедура ВыгрузитьОбъектыЗаПериод(ПериодВыгрузки) Экспорт

	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЧекККМ.Ссылка КАК Ссылка
		|ИЗ
		|	Документ.ЧекККМ КАК ЧекККМ
		|ГДЕ
		|	ЧекККМ.Дата >= &Дата1
		|	И ЧекККМ.Дата <= &Дата2";
	
	Запрос.УстановитьПараметр("Дата1", ПериодВыгрузки.ДатаНачала);
	Запрос.УстановитьПараметр("Дата2", ПериодВыгрузки.ДатаОкончания);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	ВремяНачала = ТекущаяУниверсальнаяДатаВМиллисекундах();
	

	ИмяТочкиОбмена = Константы.ксп_ТочкаОбмена.Получить().Наименование;
	
	Если Не ЗначениеЗаполнено(ИмяТочкиОбмена) Тогда
		ВызватьИсключение "Константа ксп_ТочкаОбмена не установлена!";
	КонецЕсли;

	Узел = Константы.ксп_УзелОбменаRabbit.Получить();
	Если Не ЗначениеЗаполнено(Узел) Тогда
		ВызватьИсключение "Константа ксп_УзелОбменаRabbit не установлена!";
	КонецЕсли;
	Клиент = PinkRabbit.ПолучитьКлиента();	
	
	RoutingKey = "doc";
	
	КолОбъектов = 0;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		json = ВыгрузитьОбъект(ВыборкаДетальныеЗаписи.Ссылка);
		
		Попытка
			Клиент.BasicPublish(ИмяТочкиОбмена, RoutingKey, json, 0, Ложь);
			УспешноОпубликован = Истина;
		Исключение
	        т = Клиент.GetLastError();
			тт = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации("Экспорт_в_RabbitMQ",УровеньЖурналаРегистрации.Ошибка,,ВыборкаДетальныеЗаписи.Ссылка,	
				"Ошибка публикации объекта <"+ВыборкаДетальныеЗаписи.ссылка+">. Ошибка PinkRabbitMQ: "+т+символы.ПС+
				"Ошибка 1С: "+тт);
			
			ВызватьИсключение;
		КонецПопытки;
		
		КолОбъектов = КолОбъектов + 1;
	КонецЦикла;

	Клиент = Неопределено;
	
	ВремяРаботы = ТекущаяУниверсальнаяДатаВМиллисекундах() - ВремяНачала;       
	
	ЗаписьЖурналаРегистрации("ЗамерВремениЭкспортЧекККМ", УровеньЖурналаРегистрации.Предупреждение,,,
		"Время работы = "+Строка(ВремяРаботы)+" мс, Количество объектов = "+Строка(КолОбъектов));
		
КонецПроцедуры

          




