﻿
Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_ЕРП_Справочник_СтатьиДвиженияДенежныхСредств");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_ЕРП_Справочник_СтатьиДвиженияДенежныхСредств");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_ЕРП_Справочник_СтатьиДвиженияДенежныхСредств",
		"Форма_Плагин_RabbitMQ_импорт_из_ЕРП_Справочник_СтатьиДвиженияДенежныхСредств",
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
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("справочник.статьидвиженияденежныхсредств") Тогда
		Возврат Неопределено;
	КонецЕсли;
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;


	//------------------------------------- работа с мэппингом
	
	ПоМэппингу = Неопределено;
	Если РегистрыСведений.ксп_МэппингСправочникСтатьиДДС.ЕстьГУИД(id.Ref, мВнешняяСистема) Тогда
		ПоМэппингу = РегистрыСведений.ксп_МэппингСправочникСтатьиДДС.ПоМэппингу(id.Ref, мВнешняяСистема);
	Иначе 
		РегистрыСведений.ксп_МэппингСправочникСтатьиДДС.ДобавитьГУИД(id.Ref, деф.Description+", Код: "+id.code, мВнешняяСистема);
		// здесь идеально было бы отправить алерт, чтобы пользователь проставил мэппинг
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ПоМэппингу) Тогда
		Возврат ПоМэппингу;
	КонецЕсли;
	
	//------------------------------------- работа с GUID
	
	СуществующийОбъект = Справочники.СтатьиДвиженияДенежныхСредств.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	Если ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		СуществующийОбъект = Неопределено;
	Иначе 
		
		Если id.isFolder Тогда
			ОбъектДанных = Справочники.СтатьиДвиженияДенежныхСредств.СоздатьГруппу();
		Иначе 
			ОбъектДанных = Справочники.СтатьиДвиженияДенежныхСредств.СоздатьЭлемент();
		КонецЕсли;
		СсылкаНового = Справочники.СтатьиДвиженияДенежныхСредств.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов
	
	ОбъектДанных.Наименование = деф.Description;
	ОбъектДанных.Код = id.Code;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;



	//_знч = "";
	//ЕстьЗначение = деф.ВидДвиженияДенежныхСредств.свойство("Значение",_знч);
	//Если ЕстьЗначение Тогда
	//	ОбъектДанных.ВидДвиженияДенежныхСредств = деф.ВидДвиженияДенежныхСредств.Значение;
	//Иначе
	//	ОбъектДанных.ВидДвиженияДенежныхСредств = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ВидДвиженияДенежныхСредств = ксп_ИмпортСлужебный.НайтиПеречисление_ВидДвиженияДенежныхСредств(деф.ВидДвиженияДенежныхСредств);

	//ОбъектДанных.КорреспондирующийСчет = деф.КорреспондирующийСчет;

	//ОбъектДанных.НеУчитываетсяВНалоговойБазеАУСН = деф.НеУчитываетсяВНалоговойБазеАУСН;

	//ОбъектДанных.Описание = деф.Описание;

	//гуид="";
	//ЕстьАтрибут = деф.ПриоритетОплаты.свойство("Ref",гуид);
	//Если ЕстьАтрибут Тогда
	//	ОбъектДанных.ПриоритетОплаты = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( деф.ПриоритетОплаты.Ref ) );
	//Иначе
	//	ОбъектДанных.ПриоритетОплаты = Неопределено;
	//КонецЕсли;
	//// на случай, если есть метод поиска ссылки:
	//ОбъектДанных.ПриоритетОплаты = ксп_ИмпортСлужебный.НайтиПриоритетОплаты(деф.ПриоритетОплаты);

	//ОбъектДанных.РеквизитДопУпорядочивания = деф.РеквизитДопУпорядочивания;




	////------------------------------------------------------     ТЧ ХозяйственныеОперации



	//ОбъектДанных.ХозяйственныеОперации.Очистить();


	//Для счТовары = 0 По деф.ТЧХозяйственныеОперации.Количество()-1 Цикл
	//	стрк = деф.ТЧХозяйственныеОперации[счТовары];
	//	СтрокаТЧ = ОбъектДанных.ХозяйственныеОперации.Добавить();


	//	_знч = "";
	//	ЕстьЗначение = стрк.ХозяйственнаяОперация.свойство("Значение",_знч);
	//	Если ЕстьЗначение Тогда
	//		СтрокаТЧ.ХозяйственнаяОперация = стрк.ХозяйственнаяОперация.Значение;
	//	Иначе
	//		СтрокаТЧ.ХозяйственнаяОперация = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.ХозяйственнаяОперация = ксп_ИмпортСлужебный.НайтиПеречисление_ХозяйственнаяОперация(стрк.ХозяйственнаяОперация);

	//КонецЦикла;

	////------------------------------------------------------     ТЧ ДополнительныеРеквизиты



	//ОбъектДанных.ДополнительныеРеквизиты.Очистить();


	//Для счТовары = 0 По деф.ТЧДополнительныеРеквизиты.Количество()-1 Цикл
	//	стрк = деф.ТЧДополнительныеРеквизиты[счТовары];
	//	СтрокаТЧ = ОбъектДанных.ДополнительныеРеквизиты.Добавить();


	//	гуид="";
	//	ЕстьАтрибут = стрк.Значение.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Значение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Значение.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Значение = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Значение = ксп_ИмпортСлужебный.НайтиЗначение(стрк.Значение);

	//	гуид="";
	//	ЕстьАтрибут = стрк.Свойство.свойство("Ref",гуид);
	//	Если ЕстьАтрибут Тогда
	//		СтрокаТЧ.Свойство = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Свойство.Ref ) );
	//	Иначе
	//		СтрокаТЧ.Свойство = Неопределено;
	//	КонецЕсли;
	//	// на случай, если есть метод поиска ссылки:
	//	СтрокаТЧ.Свойство = ксп_ИмпортСлужебный.НайтиСвойство(стрк.Свойство);

	//	СтрокаТЧ.ТекстоваяСтрока = стрк.ТекстоваяСтрока;

	//КонецЦикла;




	//------------------------------------------------------ ФИНАЛ


	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	ОбъектДанных.Записать();


	// Созданный элемент добавляем в регистр мэппингов (если есть), т.к. это выглядит логичным для пользователя
	НаименованиеДляМэппинга = деф.Description + ", Код: "+id.code;
	РегистрыСведений.ксп_МэппингСправочникСтатьиДДС.ДобавитьЗапись(id.Ref, НаименованиеДляМэппинга, мВнешняяСистема, ОбъектДанных.Ссылка);


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

	
	
	Возврат ЗагрузитьОбъект(СтруктураОбъекта, json);
	
КонецФункции

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


#КонецОбласти 	


мВнешняяСистема = "erp";

