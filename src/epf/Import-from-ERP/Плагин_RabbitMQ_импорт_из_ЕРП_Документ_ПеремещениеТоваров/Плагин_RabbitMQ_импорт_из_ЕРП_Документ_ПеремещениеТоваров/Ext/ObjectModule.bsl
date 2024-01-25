﻿Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.2");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_ЕРП_Документ_ПеремещениеТоваров");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_ЕРП_Документ_ПеремещениеТоваров");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_ЕРП_Документ_ПеремещениеТоваров",
		"Форма_Плагин_RabbitMQ_импорт_из_ЕРП_Документ_ПеремещениеТоваров",
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



Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "") Экспорт
	
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("документ.перемещениетоваров") Тогда
		Возврат Неопределено;
	КонецЕсли;

	ИмяСобытияЖР = "Импорт_из_RabbitMQ_ЕРП";

	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
    ВидОбъекта = "перемещениетоваров";

	//------------------------------------- работа с GUID	
	ОбъектДанных = Неопределено;
	ДанныеСсылка = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	ПредставлениеОбъекта = Строка(ДанныеСсылка);
	ЭтоНовый = Ложь;
	Если НЕ ЗначениеЗаполнено(ДанныеСсылка.ВерсияДанных) Тогда
		ОбъектДанных = Документы[ВидОбъекта].СоздатьДокумент();
		СсылкаНового = Документы[ВидОбъекта].ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
		ПредставлениеОбъекта = Строка(ОбъектДанных);
		ЭтоНовый = Истина;
	КонецЕсли; 
	
	// -------------------------------------------- БЛОКИРОВКА
	Если НЕ ЭтоНовый Тогда
		Блокировка = ксп_Блокировки.СоздатьБлокировкуОдногоОбъекта(ДанныеСсылка);
	КонецЕсли;

	НачатьТранзакцию();
	
	Если НЕ ЭтоНовый Тогда
		Попытка
			Блокировка.Заблокировать();
			ОбъектДанных = ДанныеСсылка.ПолучитьОбъект();
		Исключение
			т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,ОбъектДанных.Ссылка,
				"Объект не загружен! Ошибка блокировки объекта <"+ПредставлениеОбъекта+">. Подробности: "+т);
			ОтменитьТранзакцию();
			ВызватьИсключение;
		КонецПопытки;
	КонецЕсли;
	
	//------------------------------------- Отмена проведения
	Попытка			
		Если ОбъектДанных.Проведен Тогда
			ОбъектДанных.Записать(РежимЗаписиДокумента.ОтменаПроведения);
		КонецЕсли;
	Исключение
		т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,ДанныеСсылка,
			"Объект не загружен! Ошибка в отмены проведения: <"+ПредставлениеОбъекта+">. Подробности: "+т);
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;	
	
	//------------------------------------- Заполнение реквизитов
	Попытка			
		ЗаполнитьРеквизиты(ОбъектДанных, СтруктураОбъекта, jsonText);		
		ЗафиксироватьТранзакцию();          		
		Возврат ДанныеСсылка;		
	Исключение
		т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,УровеньЖурналаРегистрации.Ошибка,,ДанныеСсылка,
			"Объект не загружен! Ошибка в процессе загрузки объекта: <"+ПредставлениеОбъекта+">. Подробности: "+т);
		Если ТранзакцияАктивна() Тогда
			ОтменитьТранзакцию();
		КонецЕсли;
		ВызватьИсключение;
	КонецПопытки;	
			
КонецФункции



// Заполняет реквизиты объекта и пишет сопутствующие данные. Должна вызываться в транзакции.
Функция ЗаполнитьРеквизиты(ОбъектДанных, СтруктураОбъекта, jsonText = "") Экспорт

	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;
	
ОбъектДанных.Номер = деф.Number;
	ОбъектДанных.Дата = деф.Date;
	
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;

	ОбъектДанных.СкладОтправитель = ксп_ИмпортСлужебный.НайтиСклад(деф.СкладОтправитель, мВнешняяСистема);
	ОбъектДанных.СкладПолучатель = ксп_ИмпортСлужебный.НайтиСклад(деф.СкладПолучатель, мВнешняяСистема);
	
	ОбъектДанных.МагазинОтправитель = РегистрыСведений.ксп_МэппингСкладМагазин.ПоМэппингу(деф.СкладОтправитель, мВнешняяСистема);
	ОбъектДанных.МагазинПолучатель = РегистрыСведений.ксп_МэппингСкладМагазин.ПоМэппингу(деф.СкладПолучатель, мВнешняяСистема);
	
	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);
	ОбъектДанных.ОрганизацияПолучатель = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.ОрганизацияПолучатель, мВнешняяСистема);
	Если не ЗначениеЗаполнено(ОбъектДанных.ОрганизацияПолучатель) Тогда
		ОбъектДанных.ОрганизацияПолучатель = ОбъектДанных.Организация;
	КонецЕсли;
	
	ОбъектДанных.Ответственный = ксп_ИмпортСлужебный.ОтветственныйПоУмолчанию();
	
	
	
	
	
	
	ОбъектДанных.Товары.Очистить();

	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];
		НовСтр = ОбъектДанных.Товары.Добавить();
		//Реквизит	Тип	Вид
		//КлючСвязи	Число	
		НовСтр.КлючСвязи = счТовары;
		//КлючСвязиСерийныхНомеров	Число	
		НовСтр.КлючСвязиСерийныхНомеров = счТовары;
		//Количество	Число	                   
		НовСтр.Количество = стрк.Количество;
		//КоличествоПоРНПТ	Число	
		//КоличествоУпаковок	Число	    
		НовСтр.КоличествоУпаковок = стрк.КоличествоУпаковок;
		//НеобходимостьВводаАкцизнойМарки	Булево	
		//Номенклатура	Справочник	Номенклатура
		НовСтр.Номенклатура = Справочники.Номенклатура.ПолучитьСсылку(
			Новый УникальныйИдентификатор(стрк.Номенклатура.ref));
		//НомерГТД	Справочник	НомераГТД
		//Справка2	Справочник	Справки2ЕГАИС
		//СтатусУказанияСерий	Число	
		НовСтр.СтатусУказанияСерий = стрк.СтатусУказанияСерий;
		//СтатусУказанияСерийОтправитель	Число	
		НовСтр.СтатусУказанияСерийОтправитель = стрк.СтатусУказанияСерийОтправитель;
		//СтатусУказанияСерийПолучатель	Число	
		НовСтр.СтатусУказанияСерийПолучатель = стрк.СтатусУказанияСерийПолучатель;
		//Сумма	Число	
		//УдалитьСправка1	Справочник	Справки1ЕГАИС
		//Упаковка	Справочник	УпаковкиНоменклатуры
		//Упаковка = "";
		//Если стрк.Упаковка.Свойство("ref", Упаковка) Тогда
		//	НовСтр.Упаковка = Справочники.УпаковкиНоменклатуры.ПолучитьСсылку(
		//		Новый УникальныйИдентификатор(Упаковка));
		//КонецЕсли;
		НовСтр.Упаковка = ксп_ИмпортСлужебный
			.ПолучитьСсылкуСправочникаСПроверкой(стрк.Упаковка, "УпаковкиНоменклатуры");
		//Характеристика	Справочник	ХарактеристикиНоменклатуры
		//Характеристика = "";
		//Если стрк.Характеристика.Свойство("ref", Характеристика) Тогда
		//	НовСтр.Характеристика = Справочники.ХарактеристикиНоменклатуры.ПолучитьСсылку(
		//		Новый УникальныйИдентификатор(Характеристика));
		//КонецЕсли;
		НовСтр.Характеристика = ксп_ИмпортСлужебный.ПолучитьСсылкуСправочникаСПроверкой(стрк.Характеристика, "УпаковкиНоменклатуры");
		//Цена	Число	
		//Штрихкод	Строка	
	КонецЦикла;
	
	
	
	ОбъектДанных.Серии.Очистить();

	Для счТовары = 0 По деф.ТЧСерии.Количество()-1 Цикл
		
		стрк = деф.ТЧСерии[счТовары];
		НовСтр = ОбъектДанных.Серии.Добавить();
		НовСтр.Количество = стрк.Количество;
		НовСтр.Номенклатура = Справочники.Номенклатура.ПолучитьСсылку(
			Новый УникальныйИдентификатор(стрк.Номенклатура.ref));
		НовСтр.Характеристика = Справочники.ХарактеристикиНоменклатуры.ПолучитьСсылку(
			Новый УникальныйИдентификатор(стрк.Характеристика.ref));
		НовСтр.Серия = Справочники.СерииНоменклатуры.ПолучитьСсылку(
			Новый УникальныйИдентификатор(стрк.Серия.ref));
		
	КонецЦикла;



	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	ОбъектДанных.Записать();

	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);

КонецФункции





#Область Тестирование

// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗагрузитьИзJsonНаСервере(Json) export


	мЧтениеJSON = Новый ЧтениеJSON;

	
	мЧтениеJSON.УстановитьСтроку(Json);
		
	СтруктураОбъекта = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура

	
	
	Возврат ЗагрузитьОбъект(СтруктураОбъекта);
	
КонецФункции

#КонецОбласти 	


Функция ФункцияВосстановленияJSON(Свойство, Значение, ДопПараметры) Экспорт
	
	Если Свойство = "Date"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Период"Тогда
		Возврат ПрочитатьДатуJSON(Значение, ФорматДатыJSON.ISO);
	КонецЕсли;
	Если Свойство = "Сумма" Тогда
		Возврат XMLЗначение(Тип("Число"),Значение);
	КонецЕсли;
	Если Свойство = "Валюта" Тогда
		Возврат Справочники.Валюты.НайтиПоКоду(Значение);
	КонецЕсли;
	
КонецФункции



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция МассивРеквизитовШапкиДляПроверки() экспорт
	
	мРеквизиты = Новый Массив;
	//мРеквизиты.Добавить("СкладОтправитель");
	//мРеквизиты.Добавить("СкладПолучатель");
	//мРеквизиты.Добавить("МагазинОтправитель");
	//мРеквизиты.Добавить("МагазинПолучатель");
	//мРеквизиты.Добавить("Организация");
	//мРеквизиты.Добавить("ОрганизацияПолучатель");
	//мРеквизиты.Добавить("Ответственный");
	Возврат мРеквизиты;
	
КонецФункции





мВнешняяСистема = "erp";

