﻿Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_ЕРП_Документ_СписаниеНедостачТоваров");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_ЕРП_Документ_СписаниеНедостачТоваров");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_ЕРП_Документ_СписаниеНедостачТоваров",
		"Форма_Плагин_RabbitMQ_импорт_из_ЕРП_Документ_СписаниеНедостачТоваров",
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


// ///////////   ИМПОРТ  В ОБЪЕКТ ////////////


Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "") Экспорт
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("документ.списаниенедостачтоваров") Тогда
		Возврат Неопределено;
	КонецЕсли;
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;


	//------------------------------------- работа с GUID
	
	СуществующийОбъект = Документы.СписаниеТоваров.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	Если ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		СуществующийОбъект = Неопределено;
	Иначе 
		
		ОбъектДанных = Документы.СписаниеТоваров.СоздатьДокумент();
		СсылкаНового = Документы.СписаниеТоваров.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов
	
	ОбъектДанных.Номер = деф.Number;
	ОбъектДанных.Дата = деф.Date;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;



	ОбъектДанных.АналитикаХозяйственнойОперации = Справочники.АналитикаХозяйственныхОпераций.ПересортицаТоваров;

	//гуид="";
	//ЕстьАтрибут = деф.ДокументОснование.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ДокументОснование = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ДокументОснование.Ref ) );
	//Иначе
	//	ОбъектДанных.ДокументОснование = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ДокументОснование = ксп_ИмпортСлужебный.НайтиДокументОснование(деф.ДокументОснование);

	//ОбъектДанных.ЕстьКиЗГИСМ = деф.ЕстьКиЗГИСМ;

	//ОбъектДанных.ЕстьМаркируемаяПродукцияГИСМ = деф.ЕстьМаркируемаяПродукцияГИСМ;

	ОбъектДанных.Комментарий = деф.Комментарий;


	//ОбъектДанных.ОснованиеСписания = деф.ОснованиеСписания;

	//гуид="";
	//ЕстьАтрибут = деф.ОтчетОРозничныхПродажах.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ОтчетОРозничныхПродажах = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ОтчетОРозничныхПродажах.Ref ) );
	//Иначе
	//	ОбъектДанных.ОтчетОРозничныхПродажах = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ОтчетОРозничныхПродажах = ксп_ИмпортСлужебный.НайтиОтчетОРозничныхПродажах(деф.ОтчетОРозничныхПродажах);

	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);

	ОбъектДанных.Ответственный = Пользователи.ТекущийПользователь();

	ОбъектДанных.Склад = ксп_ИмпортСлужебный.НайтиСклад(деф.Склад, мВнешняяСистема);

	ОбъектДанных.Магазин = 	РегистрыСведений.ксп_МэппингСкладМагазин.ПоМэппингу(ОбъектДанных.Склад, мВнешняяСистема);
	
	//ОбъектДанных.СуммаДокумента = деф.СуммаДокумента;



	////------------------------------------------------------     ТЧ СерийныеНомера



	//ОбъектДанных.СерийныеНомера.Очистить();


	//Для счТовары = 0 По деф.ТЧСерийныеНомера.Количество()-1 Цикл
	//	стрк = деф.ТЧСерийныеНомера[счТовары];
	//	СтрокаТЧ = ОбъектДанных.СерийныеНомера.Добавить();


	//	СтрокаТЧ.КлючСвязиСерийныхНомеров = стрк.КлючСвязиСерийныхНомеров;

	//	гуид="";
	//	ЕстьАтрибут = стрк.СерийныйНомер.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.СерийныйНомер = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.СерийныйНомер.Ref ) );
	//	Иначе
	//		СтрокаТЧ.СерийныйНомер = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.СерийныйНомер = ксп_ИмпортСлужебный.НайтиСерийныйНомер(стрк.СерийныйНомер);

	//КонецЦикла;

	////------------------------------------------------------     ТЧ Товары



	ОбъектДанных.Товары.Очистить();


	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];
		СтрокаТЧ = ОбъектДанных.Товары.Добавить();


	//	гуид="";
	//	ЕстьАтрибут = стрк.АлкогольнаяПродукция.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.АлкогольнаяПродукция = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.АлкогольнаяПродукция.Ref ) );
	//	Иначе
	//		СтрокаТЧ.АлкогольнаяПродукция = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.АлкогольнаяПродукция = ксп_ИмпортСлужебный.НайтиАлкогольнаяПродукция(стрк.АлкогольнаяПродукция);

	//	СтрокаТЧ.КлючСвязи = стрк.КлючСвязи;

	//	СтрокаТЧ.КлючСвязиСерийныхНомеров = стрк.КлючСвязиСерийныхНомеров;

		СтрокаТЧ.Количество = стрк.Количество;

		СтрокаТЧ.КоличествоУпаковок = стрк.Количество;

		СтрокаТЧ.Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(стрк.Номенклатура);

	//	гуид="";
	//	ЕстьАтрибут = стрк.Справка2.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Справка2 = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Справка2.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Справка2 = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Справка2 = ксп_ИмпортСлужебный.НайтиСправка2(стрк.Справка2);

		СтрокаТЧ.СтатусУказанияСерий = стрк.СтатусУказанияСерий;

	//	СтрокаТЧ.Сумма = стрк.Сумма;

	//	гуид="";
	//	ЕстьАтрибут = стрк.Упаковка.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Упаковка = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Упаковка.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Упаковка = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Упаковка = ксп_ИмпортСлужебный.НайтиУпаковка(стрк.Упаковка);
	
		СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.Характеристика);
		ВидЦены = РегистрыСведений.ксп_ДополнительныеНастройкиИнтеграций.Настройка("ВидЦеныДляДокументаСписанияТоваров", мВнешняяСистема);
		СтруктураЦены = ксп_ИмпортСлужебный.ЦенаНоменклатуры(СтрокаТЧ.Номенклатура, СтрокаТЧ.Характеристика, ВидЦены, ОбъектДанных.Дата);
		СтрокаТЧ.Цена = СтруктураЦены.Цена;
		СтрокаТЧ.Сумма = СтрокаТЧ.Цена * СтрокаТЧ.Количество;
	КонецЦикла;

	////------------------------------------------------------     ТЧ Серии



	//ОбъектДанных.Серии.Очистить();


	//Для счТовары = 0 По деф.ТЧСерии.Количество()-1 Цикл
	//	стрк = деф.ТЧСерии[счТовары];
	//	СтрокаТЧ = ОбъектДанных.Серии.Добавить();


	//	СтрокаТЧ.Количество = стрк.Количество;

	//	гуид="";
	//	ЕстьАтрибут = стрк.Номенклатура.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Номенклатура = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Номенклатура.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Номенклатура = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатура(стрк.Номенклатура);

	//	гуид="";
	//	ЕстьАтрибут = стрк.Серия.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Серия = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Серия.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Серия = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Серия = ксп_ИмпортСлужебный.НайтиСерия(стрк.Серия);

	//	гуид="";
	//	ЕстьАтрибут = стрк.Характеристика.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Характеристика = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Характеристика.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Характеристика = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристика(стрк.Характеристика);

	//КонецЦикла;

	////------------------------------------------------------     ТЧ АкцизныеМарки



	//ОбъектДанных.АкцизныеМарки.Очистить();


	//Для счТовары = 0 По деф.ТЧАкцизныеМарки.Количество()-1 Цикл
	//	стрк = деф.ТЧАкцизныеМарки[счТовары];
	//	СтрокаТЧ = ОбъектДанных.АкцизныеМарки.Добавить();


	//	гуид="";
	//	ЕстьАтрибут = стрк.АкцизнаяМарка.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.АкцизнаяМарка = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.АкцизнаяМарка.Ref ) );
	//	Иначе
	//		СтрокаТЧ.АкцизнаяМарка = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.АкцизнаяМарка = ксп_ИмпортСлужебный.НайтиАкцизнаяМарка(стрк.АкцизнаяМарка);

	//	СтрокаТЧ.КлючСвязи = стрк.КлючСвязи;

	//	гуид="";
	//	ЕстьАтрибут = стрк.Справка2.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Справка2 = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Справка2.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Справка2 = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Справка2 = ксп_ИмпортСлужебный.НайтиСправка2(стрк.Справка2);

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


мВнешняяСистема = "erp";

