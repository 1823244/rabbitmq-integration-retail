﻿Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_ЕРП_Документ_ЧекККМКоррекции");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_ЕРП_Документ_ЧекККМКоррекции");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_ЕРП_Документ_ЧекККМКоррекции",
		"Форма_Плагин_RabbitMQ_импорт_из_ЕРП_Документ_ЧекККМКоррекции",
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
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("документ.чекККМкоррекции") Тогда
		Возврат Неопределено;
	КонецЕсли;
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;


	//------------------------------------- работа с GUID
	
	СуществующийОбъект = Документы.ЧекКоррекции.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	Если ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		СуществующийОбъект = Неопределено;
	Иначе 
		
		ОбъектДанных = Документы.ЧекКоррекции.СоздатьДокумент();
		СсылкаНового = Документы.ЧекКоррекции.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов
	
	ОбъектДанных.Номер = id.Number;
	ОбъектДанных.Дата = id.Date;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;



	//ОбъектДанных.АдресМагазина = деф.АдресМагазина;

	//ОбъектДанных.АдресРасчетов = деф.АдресРасчетов;

	//_знч = "";
	//ЕстьЗначение = деф.ВидОперации.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.ВидОперации = деф.ВидОперации.Значение;
	//Иначе
	//	ОбъектДанных.ВидОперации = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ВидОперации = ксп_ИмпортСлужебный.НайтиПеречисление_ВидОперации(деф.ВидОперации);
	ОбъектДанных.ВидОперации = Перечисления.ВидыОперацийЧекККМ.Продажа;

	ОбъектДанных.ВыручкаНаличными = деф.ПолученоНаличными;

	ОбъектДанных.ДатаКоррекции = деф.ДатаСовершенияКорректируемогоРасчета;

	//гуид="";
	//ЕстьАтрибут = деф.ДисконтнаяКарта.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ДисконтнаяКарта = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ДисконтнаяКарта.Ref ) );
	//Иначе
	//	ОбъектДанных.ДисконтнаяКарта = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ДисконтнаяКарта = ксп_ИмпортСлужебный.НайтиДисконтнаяКарта(деф.ДисконтнаяКарта);

	//гуид="";
	//ЕстьАтрибут = деф.ДокументОснование.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ДокументОснование = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ДокументОснование.Ref ) );
	//Иначе
	//	ОбъектДанных.ДокументОснование = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ДокументОснование = ксп_ИмпортСлужебный.НайтиДокументОснование(деф.ДокументОснование);

	//гуид="";
	//ЕстьАтрибут = деф.ДокументРасчетов.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ДокументРасчетов = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ДокументРасчетов.Ref ) );
	//Иначе
	//	ОбъектДанных.ДокументРасчетов = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ДокументРасчетов = ксп_ИмпортСлужебный.НайтиДокументРасчетов(деф.ДокументРасчетов);

	//ОбъектДанных.ДополнительныйРеквизит = деф.ДополнительныйРеквизит;

	//гуид="";
	//ЕстьАтрибут = деф.ЗаказПокупателя.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ЗаказПокупателя = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ЗаказПокупателя.Ref ) );
	//Иначе
	//	ОбъектДанных.ЗаказПокупателя = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ЗаказПокупателя = ксп_ИмпортСлужебный.НайтиЗаказПокупателя(деф.ЗаказПокупателя);

	//гуид="";
	//ЕстьАтрибут = деф.КассаККМ.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.КассаККМ = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.КассаККМ.Ref ) );
	//Иначе
	//	ОбъектДанных.КассаККМ = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	ОбъектДанных.КассаККМ = ксп_ИмпортСлужебный.НайтиКассуККМ(деф.КассаККМ);

	//ОбъектДанных.Кассир = деф.Кассир;

	//ОбъектДанных.КассирИНН = деф.КассирИНН;

	ОбъектДанных.Комментарий = деф.Комментарий;

	//гуид="";
	//ЕстьАтрибут = деф.Магазин.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Магазин = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Магазин.Ref ) );
	//Иначе
	//	ОбъектДанных.Магазин = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Магазин = ксп_ИмпортСлужебный.НайтиМагазин(деф.Магазин);

	//ОбъектДанных.МестоРасчетов = деф.МестоРасчетов;

	//ОбъектДанных.НеприменениеККТ = деф.НеприменениеККТ;

	//ОбъектДанных.НомерПредписания = деф.НомерПредписания;

	//ОбъектДанных.НомерСмены = деф.НомерСмены;

	//ОбъектДанных.НомерЧека = деф.НомерЧека;

	//ОбъектДанных.ОперацияСДенежнымиСредствами = деф.ОперацияСДенежнымиСредствами;

	ОбъектДанных.ОписаниеКоррекции = деф.ОписаниеКоррекции;

	ОбъектДанных.Организация = ксп_ИмпортСлужебный.НайтиОрганизацию(деф.Организация, мВнешняяСистема);

	//гуид="";
	//ЕстьАтрибут = деф.Ответственный.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Ответственный = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Ответственный.Ref ) );
	//Иначе
	//	ОбъектДанных.Ответственный = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	ОбъектДанных.Ответственный = Пользователи.ТекущийПользователь();

	//гуид="";
	//ЕстьАтрибут = деф.Покупатель.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.Покупатель = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.Покупатель.Ref ) );
	//Иначе
	//	ОбъектДанных.Покупатель = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.Покупатель = ксп_ИмпортСлужебный.НайтиПокупатель(деф.Покупатель);

	//ОбъектДанных.ПокупательEmail = деф.ПокупательEmail;

	//ОбъектДанных.ПокупательИНН = деф.ПокупательИНН;

	//ОбъектДанных.ПокупательНомер = деф.ПокупательНомер;

	//_знч = "";
	//ЕстьЗначение = деф.ПризнакАгента.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.ПризнакАгента = деф.ПризнакАгента.Значение;
	//Иначе
	//	ОбъектДанных.ПризнакАгента = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ПризнакАгента = ксп_ИмпортСлужебный.НайтиПеречисление_ПризнакАгента(деф.ПризнакАгента);

	//ОбъектДанных.ПробитЧек = деф.ПробитЧек;

	//гуид="";
	//ЕстьАтрибут = деф.РабочееМесто.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.РабочееМесто = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.РабочееМесто.Ref ) );
	//Иначе
	//	ОбъектДанных.РабочееМесто = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.РабочееМесто = ксп_ИмпортСлужебный.НайтиРабочееМесто(деф.РабочееМесто);

	//_знч = "";
	//ЕстьЗначение = деф.СистемаНалогообложения.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.СистемаНалогообложения = деф.СистемаНалогообложения.Значение;
	//Иначе
	//	ОбъектДанных.СистемаНалогообложения = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.СистемаНалогообложения = ксп_ИмпортСлужебный.НайтиПеречисление_СистемаНалогообложения(деф.СистемаНалогообложения);

	//ОбъектДанных.ТипКоррекции = деф.ТипКоррекции;

	//_знч = "";
	//ЕстьЗначение = деф.ТипРасчета.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.ТипРасчета = деф.ТипРасчета.Значение;
	//Иначе
	//	ОбъектДанных.ТипРасчета = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ТипРасчета = ксп_ИмпортСлужебный.НайтиПеречисление_ТипРасчета(деф.ТипРасчета);

	//ОбъектДанных.ЭтоСторно = деф.ЭтоСторно;




	////------------------------------------------------------     ТЧ ПозицииЧека



	ОбъектДанных.ПозицииЧека.Очистить();


	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];
		СтрокаТЧ = ОбъектДанных.ПозицииЧека.Добавить();


	//	СтрокаТЧ.ГлобальныйИдентификаторТорговойЕдиницы = стрк.ГлобальныйИдентификаторТорговойЕдиницы;

	//	СтрокаТЧ.ДанныеПоставщикаИНН = стрк.ДанныеПоставщикаИНН;

	//	СтрокаТЧ.ДанныеПоставщикаНаименование = стрк.ДанныеПоставщикаНаименование;

	//	СтрокаТЧ.ДанныеПоставщикаТелефон = стрк.ДанныеПоставщикаТелефон;

	//	СтрокаТЧ.ЕдиницаИзмерения = стрк.ЕдиницаИзмерения;

	//	СтрокаТЧ.ИзмененияСостояния = стрк.ИзмененияСостояния;

	//	СтрокаТЧ.КодКонтрольнойМарки = стрк.КодКонтрольнойМарки;

	//	СтрокаТЧ.КодСтраныПроисхожденияТовара = стрк.КодСтраныПроисхожденияТовара;

	//	СтрокаТЧ.КодТоварнойНоменклатуры = стрк.КодТоварнойНоменклатуры;

		СтрокаТЧ.Количество = стрк.Количество;

	//	СтрокаТЧ.КонтрольныйИдентификационныйЗнак = стрк.КонтрольныйИдентификационныйЗнак;

	//	гуид="";
	//	ЕстьАтрибут = стрк.НаименованиеПредметаРасчета.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.НаименованиеПредметаРасчета = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.НаименованиеПредметаРасчета.Ref ) );
	//	Иначе
	//		СтрокаТЧ.НаименованиеПредметаРасчета = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
		СтрокаТЧ.НаименованиеПредметаРасчета = ксп_ИмпортСлужебный.НайтиНоменклатуру(стрк.Номенклатура);

	//	СтрокаТЧ.НомерТаможеннойДекларации = стрк.НомерТаможеннойДекларации;

	//	СтрокаТЧ.ОператорПереводаАдрес = стрк.ОператорПереводаАдрес;

	//	СтрокаТЧ.ОператорПереводаИНН = стрк.ОператорПереводаИНН;

	//	СтрокаТЧ.ОператорПереводаНаименование = стрк.ОператорПереводаНаименование;

	//	СтрокаТЧ.ОператорПереводаТелефон = стрк.ОператорПереводаТелефон;

	//	СтрокаТЧ.ОператорПоПриемуПлатежейТелефон = стрк.ОператорПоПриемуПлатежейТелефон;

	//	СтрокаТЧ.ПлатежныйАгентОперация = стрк.ПлатежныйАгентОперация;

	//	СтрокаТЧ.ПлатежныйАгентТелефон = стрк.ПлатежныйАгентТелефон;

	//	_знч = "";
	//	ЕстьЗначение = стрк.ПризнакАгентаПоПредметуРасчета.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.ПризнакАгентаПоПредметуРасчета = стрк.ПризнакАгентаПоПредметуРасчета.Значение;
	//	Иначе
	//		СтрокаТЧ.ПризнакАгентаПоПредметуРасчета = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ПризнакАгентаПоПредметуРасчета = ксп_ИмпортСлужебный.НайтиПеречисление_ПризнакАгентаПоПредметуРасчета(стрк.ПризнакАгентаПоПредметуРасчета);

	//	_знч = "";
	//	ЕстьЗначение = стрк.ПризнакПредметаРасчета.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.ПризнакПредметаРасчета = стрк.ПризнакПредметаРасчета.Значение;
	//	Иначе
	//		СтрокаТЧ.ПризнакПредметаРасчета = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ПризнакПредметаРасчета = ксп_ИмпортСлужебный.НайтиПеречисление_ПризнакПредметаРасчета(стрк.ПризнакПредметаРасчета);

	//	_знч = "";
	//	ЕстьЗначение = стрк.ПризнакСпособаРасчета.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.ПризнакСпособаРасчета = стрк.ПризнакСпособаРасчета.Значение;
	//	Иначе
	//		СтрокаТЧ.ПризнакСпособаРасчета = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ПризнакСпособаРасчета = ксп_ИмпортСлужебный.НайтиПеречисление_ПризнакСпособаРасчета(стрк.ПризнакСпособаРасчета);

	//	СтрокаТЧ.СерийныйНомер = стрк.СерийныйНомер;

	//	гуид="";
	//	ЕстьАтрибут = стрк.Склад.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Склад = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Склад.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Склад = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	СтрокаТЧ.Склад = ксп_ИмпортСлужебный.НайтиСклад(деф.Склад, мВнешняяСистема);

	//	_знч = "";
	//	ЕстьЗначение = стрк.СтавкаНДС.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.СтавкаНДС = стрк.СтавкаНДС.Значение;
	//	Иначе
	//		СтрокаТЧ.СтавкаНДС = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	СтрокаТЧ.СтавкаНДС = ксп_ИмпортСлужебный.ОпределитьСтавкуНДСПоСправочникуЕРП(стрк.СтавкаНДС);

	//	СтрокаТЧ.СуммаАкциза = стрк.СуммаАкциза;

		СтрокаТЧ.СуммаНДС = стрк.СуммаНДС;

	//	СтрокаТЧ.СуммаСкидок = стрк.СуммаСкидок;

		СтрокаТЧ.СуммаСоСкидками = стрк.Сумма;

	//	_знч = "";
	//	ЕстьЗначение = стрк.ТипМаркировки.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.ТипМаркировки = стрк.ТипМаркировки.Значение;
	//	Иначе
	//		СтрокаТЧ.ТипМаркировки = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ТипМаркировки = ксп_ИмпортСлужебный.НайтиПеречисление_ТипМаркировки(стрк.ТипМаркировки);

	//	гуид="";
	//	ЕстьАтрибут = стрк.Упаковка.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Упаковка = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Упаковка.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Упаковка = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	СтрокаТЧ.Упаковка = ксп_ИмпортСлужебный.НайтиЕдиницуИзмерения(стрк.Упаковка, стрк.Номенклатура);

	//	гуид="";
	//	ЕстьАтрибут = стрк.Характеристика.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Характеристика = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Характеристика.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Характеристика = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
		СтрокаТЧ.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристику(стрк.Характеристика);

		СтрокаТЧ.ЦенаСоСкидками = стрк.Цена;

		СтрокаТЧ.Штрихкод = стрк.Штрихкод;

	//	СтрокаТЧ.ШтрихкодBase64 = стрк.ШтрихкодBase64;

	КонецЦикла;

	////------------------------------------------------------     ТЧ Оплата



	ОбъектДанных.Оплата.Очистить();


	Для счТовары = 0 По деф.ТЧОплатаПлатежнымиКартами.Количество()-1 Цикл
		стрк = деф.ТЧОплатаПлатежнымиКартами[счТовары];
		СтрокаТЧ = ОбъектДанных.Оплата.Добавить();


	//	гуид="";
	//	ЕстьАтрибут = стрк.ВидОплаты.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ВидОплаты = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ВидОплаты.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ВидОплаты = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ВидОплаты = ксп_ИмпортСлужебный.НайтиВидОплаты(стрк.ВидОплаты);
		СтрокаТЧ.ВидОплаты = Справочники.ВидыОплатЧекаККМ.БанковскийПлатеж;

		СтрокаТЧ.Сумма = стрк.Сумма;

	//	_знч = "";
	//	ЕстьЗначение = стрк.ТипОплаты.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.ТипОплаты = стрк.ТипОплаты.Значение;
	//	Иначе
	//		СтрокаТЧ.ТипОплаты = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ТипОплаты = ксп_ИмпортСлужебный.НайтиПеречисление_ТипОплаты(стрк.ТипОплаты);
		СтрокаТЧ.ТипОплаты = Перечисления.ТипыОплатыККТ.Электронно;

	//	гуид="";
	//	ЕстьАтрибут = стрк.ЭквайринговыйТерминал.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.ЭквайринговыйТерминал = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.ЭквайринговыйТерминал.Ref ) );
	//	Иначе
	//		СтрокаТЧ.ЭквайринговыйТерминал = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
		СтрокаТЧ.ЭквайринговыйТерминал = ксп_ИмпортСлужебный.НайтиЭквайринговыйТерминал(стрк.ЭквайринговыйТерминал, мВнешняяСистема);

	КонецЦикла;




	//------------------------------------------------------ ФИНАЛ


	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	ОбъектДанных.Записать();
	
	ОбъектДанных.ОбменДанными.Загрузка = Ложь;
	Если деф.isPosted Тогда 
		ОбъектДанных.Записать(РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Неоперативный);
	КонецЕсли;

	// сохранить исходный json
	//РегистрыСведений.ксп_ИсходныеДанныеСообщений.ДобавитьЗапись(ОбъектДанных.Ссылка, jsonText);


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
Функция ПроверитьКачествоДанных(ДокументОбъект)
	
	// проверить шапку
	
	Для каждого рек Из МассивРеквизитовШапкиДляПроверки() Цикл
		
		Если НЕ ЗначениеЗаполнено(ДокументОбъект[рек]) Тогда
			
			ксп_ИмпортСлужебный.ДобавитьПроблемуОтложенногоПроведения(
				ДокументОбъект.Ссылка, рек, Неопределено, 0, 
				Перечисления.ксп_ВидыПроблемКачестваДокументов.НетЗначения);
				
		ИначеЕсли ЗначениеЗаполнено(ДокументОбъект[рек]) 
			И НЕ ЗначениеЗаполнено(ДокументОбъект[рек].ВерсияДанных) Тогда

			ксп_ИмпортСлужебный.ДобавитьПроблемуОтложенногоПроведения(
				ДокументОбъект.Ссылка, рек, Неопределено, 0, 
				Перечисления.ксп_ВидыПроблемКачестваДокументов.БитаяСсылка);
		КонецЕсли;
		
	КонецЦикла;
	
	// проверить все Табл Части
	
		
	Возврат Неопределено;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция МассивРеквизитовШапкиДляПроверки()
	
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

