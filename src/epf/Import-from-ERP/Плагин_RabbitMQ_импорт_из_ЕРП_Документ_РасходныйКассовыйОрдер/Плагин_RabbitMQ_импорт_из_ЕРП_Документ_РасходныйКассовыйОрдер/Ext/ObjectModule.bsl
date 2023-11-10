﻿Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_ЕРП_Документ_РасходныйКассовыйОрдер");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_ЕРП_Документ_РасходныйКассовыйОрдер");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_ЕРП_Документ_РасходныйКассовыйОрдер",
		"Форма_Плагин_RabbitMQ_импорт_из_ЕРП_Документ_РасходныйКассовыйОрдер",
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
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("документ.расходныйкассовыйордер") Тогда
		Возврат Неопределено;
	КонецЕсли;
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;


	//------------------------------------- работа с GUID
	
	СуществующийОбъект = Документы.РасходныйКассовыйОрдер.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	Если ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		СуществующийОбъект = Неопределено;
	Иначе 
		
		ОбъектДанных = Документы.РасходныйКассовыйОрдер.СоздатьДокумент();
		СсылкаНового = Документы.РасходныйКассовыйОрдер.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов
	
	ОбъектДанных.Номер = id.Number;
	ОбъектДанных.Дата = id.Date;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;



	//ОбъектДанных.АдресЭП = деф.АдресЭП;

	НомерСчета="";
	ЕстьАтрибут = деф.БанковскийСчет.свойство("НомерСчета",НомерСчета);
	Если ЕстьАтрибут Тогда
		ОбъектДанных.БанковскийСчет = ксп_ИмпортСлужебный.НайтиБанковскийСчет(НомерСчета, деф.БанковскийСчет.БИК);
	Иначе
		ОбъектДанных.БанковскийСчет = Неопределено;
	КонецЕсли;

	ОбъектДанных.Выдать = деф.Выдать;

	// доделать
	гуид="";
	ЕстьАтрибут = деф.Договор.свойство("Ref",гуид);
	Если ЕстьАтрибут Тогда
		ОбъектДанных.ДоговорКонтрагента = Справочники.ДоговорыКонтрагентов.ПолучитьСсылку(деф.Договор.Ref);
	Иначе
		ОбъектДанных.ДоговорКонтрагента = Неопределено;
	КонецЕсли;

	//гуид="";
	//ЕстьАтрибут = деф.ДокументОснование.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ДокументОснование = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ДокументОснование.Ref ) );
	//Иначе
	//	ОбъектДанных.ДокументОснование = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ДокументОснование = ксп_ИмпортСлужебный.НайтиДокументОснование(деф.ДокументОснование);

	ОбъектДанных.Касса = ксп_ИмпортСлужебный.НайтиКассу(деф.Касса, мВнешняяСистема);
	
	ОбъектДанных.КассаККМ = ксп_ИмпортСлужебный.НайтиКассуККМ(деф.КассаККМ);
	
	ОбъектДанных.КассаПолучатель = ксп_ИмпортСлужебный.НайтиКассу(деф.КассаПолучатель, мВнешняяСистема);

	ОбъектДанных.Комментарий = деф.Комментарий;

	ОбъектДанных.Контрагент = ксп_ИмпортСлужебный.НайтиКонтрагента(деф.Контрагент, мВнешняяСистема);

	//ОбъектДанных.НомерСумки = деф.НомерСумки;

	//ОбъектДанных.НомерЧекаККМ = деф.НомерЧекаККМ;

	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);

	ОбъектДанных.Основание = деф.Основание;

	ОбъектДанных.Ответственный = Пользователи.ТекущийПользователь();

	//гуид="";
	//ЕстьАтрибут = деф.ОтчетОРозничныхПродажах.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ОтчетОРозничныхПродажах = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ОтчетОРозничныхПродажах.Ref ) );
	//Иначе
	//	ОбъектДанных.ОтчетОРозничныхПродажах = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ОтчетОРозничныхПродажах = ксп_ИмпортСлужебный.НайтиОтчетОРозничныхПродажах(деф.ОтчетОРозничныхПродажах);

	//гуид="";
	//ЕстьАтрибут = деф.ПлатежнаяВедомость.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ПлатежнаяВедомость = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ПлатежнаяВедомость.Ref ) );
	//Иначе
	//	ОбъектДанных.ПлатежнаяВедомость = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ПлатежнаяВедомость = ксп_ИмпортСлужебный.НайтиПлатежнаяВедомость(деф.ПлатежнаяВедомость);

	ОбъектДанных.ПоДокументу = деф.ПоДокументу;

	ОбъектДанных.Приложение = деф.Приложение;

	//ОбъектДанных.ПробиватьЧекиПоКассеККМ = деф.ПробиватьЧекиПоКассеККМ;

	//ОбъектДанных.ПробитЧек = деф.ПробитЧек;

	//_знч = "";
	//ЕстьЗначение = деф.СистемаНалогообложения.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.СистемаНалогообложения = деф.СистемаНалогообложения.Значение;
	//Иначе
	//	ОбъектДанных.СистемаНалогообложения = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.СистемаНалогообложения = ксп_ИмпортСлужебный.НайтиПеречисление_СистемаНалогообложения(деф.СистемаНалогообложения);

	//ОбъектДанных.СменаЗакрыта = деф.СменаЗакрыта;

	ОбъектДанных.СуммаДокумента = деф.СуммаДокумента;

	//ОбъектДанных.Телефон = деф.Телефон;

	ОбъектДанных.ХозяйственнаяОперация = КонвертацияХозОперации(деф.ХозяйственнаяОперация);




	////------------------------------------------------------     ТЧ РасшифровкаПлатежа



	ОбъектДанных.РасшифровкаПлатежа.Очистить();


	Для счТовары = 0 По деф.ТЧРасшифровкаПлатежа.Количество()-1 Цикл
		стрк = деф.ТЧРасшифровкаПлатежа[счТовары];
		СтрокаТЧ = ОбъектДанных.РасшифровкаПлатежа.Добавить();


	//	гуид="";
	//	ЕстьАтрибут = стрк.ДоговорКонтрагента.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ДоговорКонтрагента = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ДоговорКонтрагента.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ДоговорКонтрагента = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ДоговорКонтрагента = ксп_ИмпортСлужебный.НайтиДоговорКонтрагента(стрк.ДоговорКонтрагента);

	//	гуид="";
	//	ЕстьАтрибут = стрк.ДокументРасчетовСКонтрагентом.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ДокументРасчетовСКонтрагентом = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ДокументРасчетовСКонтрагентом.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ДокументРасчетовСКонтрагентом = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ДокументРасчетовСКонтрагентом = ксп_ИмпортСлужебный.НайтиДокументРасчетовСКонтрагентом(стрк.ДокументРасчетовСКонтрагентом);

	//	гуид="";
	//	ЕстьАтрибут = стрк.ОперацияКассовойОтчетности.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ОперацияКассовойОтчетности = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ОперацияКассовойОтчетности.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ОперацияКассовойОтчетности = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ОперацияКассовойОтчетности = ксп_ИмпортСлужебный.НайтиОперацияКассовойОтчетности(стрк.ОперацияКассовойОтчетности);

	//	_знч = "";
	//	ЕстьЗначение = стрк.ПризнакСпособаРасчета.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.ПризнакСпособаРасчета = стрк.ПризнакСпособаРасчета.Значение;
	//	Иначе
	//		СтрокаТЧ.ПризнакСпособаРасчета = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ПризнакСпособаРасчета = ксп_ИмпортСлужебный.НайтиПеречисление_ПризнакСпособаРасчета(стрк.ПризнакСпособаРасчета);

		СтрокаТЧ.СтатьяДвиженияДенежныхСредств = ксп_ИмпортСлужебный.НайтиСтатьюДДС(стрк.СтатьяДвиженияДенежныхСредств, мВнешняяСистема);

		СтрокаТЧ.Сумма = стрк.Сумма;

	КонецЦикла;

	////------------------------------------------------------     ТЧ ОписьСдаваемыхНаличныхДенег



	//ОбъектДанных.ОписьСдаваемыхНаличныхДенег.Очистить();


	//Для счТовары = 0 По деф.ТЧОписьСдаваемыхНаличныхДенег.Количество()-1 Цикл
	//	стрк = деф.ТЧОписьСдаваемыхНаличныхДенег[счТовары];
	//	СтрокаТЧ = ОбъектДанных.ОписьСдаваемыхНаличныхДенег.Добавить();


	//	СтрокаТЧ.КоличествоБанкнот = стрк.КоличествоБанкнот;

	//	СтрокаТЧ.Коэффициент = стрк.Коэффициент;

	//	СтрокаТЧ.НаименованиеБанкноты = стрк.НаименованиеБанкноты;

	//	СтрокаТЧ.Номинал = стрк.Номинал;

	//	СтрокаТЧ.ПараметрКоличествоБанкнот = стрк.ПараметрКоличествоБанкнот;

	//	СтрокаТЧ.ПараметрСуммаБанкнот = стрк.ПараметрСуммаБанкнот;

	//	СтрокаТЧ.Сумма = стрк.Сумма;

	//КонецЦикла;




	//------------------------------------------------------ ФИНАЛ


	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	ОбъектДанных.Записать();

	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_01(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_02(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_03(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_04(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);
	ксп_ИмпортСлужебный.Документы_ПослеИмпорта_05(ОбъектДанных, мВнешняяСистема, СтруктураОбъекта, jsonText, ЭтотОбъект);


	Возврат ОбъектДанных.Ссылка;
	
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
	//Если Свойство = "Сумма" Тогда
	//	Возврат XMLЗначение(Тип("Число"),Значение);
	//КонецЕсли;
	Если Свойство = "Валюта" Тогда
		Возврат Значение;
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



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция КонвертацияХозОперации(Узел)
	//
	//    "ХозяйственнаяОперация": {
	//        "type": "Перечисление.ХозяйственныеОперации",
	//        "Значение": "ОплатаПоставщику",
	//        "Представление": "Оплата поставщику"
	
	_знч = "";
	ЕстьЗначение = узел.свойство("Значение",_знч);
	Если ЕстьЗначение Тогда
		рез = узел.Значение;
	Иначе
		рез = Неопределено;
	КонецЕсли;
	
	Если рез = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;               
	
	_Опер = Неопределено;
	
	Если Рез = "ОплатаПоставщику" Тогда
		_Опер = Перечисления.ХозяйственныеОперации.ОплатаПоставщику;
	ИначеЕсли Рез = "ВыдачаДенежныхСредствПодотчетнику" Тогда
		_Опер = Перечисления.ХозяйственныеОперации.ПрочиеРасходы;
	ИначеЕсли Рез = "ОплатаДенежныхСредствВДругуюОрганизацию" Тогда
		_Опер = Перечисления.ХозяйственныеОперации.ВыдачаДенежныхСредствВДругуюОрганизацию;
	ИначеЕсли Рез = "ВнутренняяПередачаДенежныхСредств" Тогда
		_Опер = Перечисления.ХозяйственныеОперации.ВнутренняяПередачаДенежныхСредств;
	ИначеЕсли Рез = "СдачаДенежныхСредствВБанк" Тогда
		_Опер = Перечисления.ХозяйственныеОперации.СдачаДенежныхСредствВБанк;
	ИначеЕсли Рез = "ИнкассацияДенежныхСредствВБанк" Тогда
		_Опер = Перечисления.ХозяйственныеОперации.СдачаДенежныхСредствВБанк;
	ИначеЕсли Рез = "ВыдачаДенежныхСредствВДругуюКассу" Тогда
		_Опер = Перечисления.ХозяйственныеОперации.ВыдачаДенежныхСредствВДругуюКассу;
	ИначеЕсли Рез = "ВыдачаДенежныхСредствВКассуККМ" Тогда
		_Опер = Перечисления.ХозяйственныеОперации.ВыдачаДенежныхСредствВКассуККМ;
	ИначеЕсли Рез = "ПрочаяВыдачаДенежныхСредств" Тогда
		_Опер = Перечисления.ХозяйственныеОперации.ПрочиеРасходы;
	ИначеЕсли Рез = "ВозвратОплатыКлиенту" Тогда
		_Опер = Перечисления.ХозяйственныеОперации.ВозвратОплатыКлиенту;
	Иначе
		_Опер = Перечисления.ХозяйственныеОперации.ПрочиеРасходы;
	КонецЕсли;
	

	// операции Розницы:
	//+Оплата поставщику
	//Сдача ДС в банк
	//Выдача ДС в другую кассу
	//+Внутренняя передача ДС
	//Возврат оплаты покупателю
	//Выдача ДС в кассу ККМ
	//Прочие расходы
	//+Выдача ДС в другую организацию
	
	
	
	
	Возврат _Опер;
	
КонецФункции






мВнешняяСистема = "erp";

