﻿Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_ЕРП_Документ_ИзменениеАссортимента");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_ЕРП_Документ_ИзменениеАссортимента");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_ЕРП_Документ_ИзменениеАссортимента",
		"Форма_Плагин_RabbitMQ_импорт_из_ЕРП_Документ_ИзменениеАссортимента",
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
	Если НЕ НРег(СтруктураОбъекта.type) = НРег("документ.изменениеассортимента") Тогда
		Возврат Неопределено;
	КонецЕсли;
	id = СтруктураОбъекта.identification;
	деф = СтруктураОбъекта.definition;


	//------------------------------------- работа с GUID
	
	СуществующийОбъект = Документы.ИзменениеАссортимента.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
	Если ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
		СуществующийОбъект = Неопределено;
	Иначе 
		
		ОбъектДанных = Документы.ИзменениеАссортимента.СоздатьДокумент();
		СсылкаНового = Документы.ИзменениеАссортимента.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	КонецЕсли;
	
	//------------------------------------- Заполнение реквизитов
	
	ОбъектДанных.Номер = id.Number;
	ОбъектДанных.Дата = id.Date;
	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;



	ОбъектДанных.Комментарий = деф.Комментарий;

	ОбъектДанных.ОбъектПланирования = ксп_ИмпортСлужебный.НайтиФорматМагазина(деф.ОбъектПланирования, мВнешняяСистема);

	// вернуться
	//ОбъектДанных.Операция = НайтиПеречисление_ОперацииИзмененияАссортимента_ЕРП(деф.Операция, мВнешняяСистема);
	ОбъектДанных.Операция = Перечисления.ОперацииИзмененияАссортимента.ВводВАссортимент;
	

	ОбъектДанных.Ответственный = Пользователи.ТекущийПользователь();

	// вернуться
//	_знч = "";
//	ЕстьЗначение = деф.Стадия.свойство("Значение",_знч);
//	Если ЕстьЗначение Тогда
//		ОбъектДанных.Стадия = деф.Стадия.Значение;
//	Иначе
//		ОбъектДанных.Стадия = Неопределено;
//	КонецЕсли;
//	// на случай, если есть метод поиска ссылки:
	ОбъектДанных.Стадия = Перечисления.СтадииАссортимента.РазрешеныЗакупкиИПродажи;




//	//------------------------------------------------------     ТЧ Товары



	ОбъектДанных.Товары.Очистить();


	Для счТовары = 0 По деф.ТЧТовары.Количество()-1 Цикл
		стрк = деф.ТЧТовары[счТовары];
		СтрокаТЧ = ОбъектДанных.Товары.Добавить();

		СтрокаТЧ.ВидЦен = ксп_ИмпортСлужебный.НайтиВидЦен(стрк.ВидЦены, мВнешняяСистема);

		СтрокаТЧ.Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуру(стрк.Номенклатура);
			
		_знч = "";
		ЕстьЗначение = стрк.РольАссортимента.свойство("Значение",_знч);
		Если ЕстьЗначение Тогда
			СтрокаТЧ.РольАссортимента = ксп_ИмпортСлужебный.НайтиПеречисление_РолиАссортимента_ЕРП(_знч, мВнешняяСистема);
		Иначе
			СтрокаТЧ.РольАссортимента = Неопределено;
		КонецЕсли;
		
		
		

	КонецЦикла;

//	//------------------------------------------------------     ТЧ НаборыЗначенийДоступа



//	ОбъектДанных.НаборыЗначенийДоступа.Очистить();


//	Для счТовары = 0 По деф.ТЧНаборыЗначенийДоступа.Количество()-1 Цикл
//		стрк = деф.ТЧНаборыЗначенийДоступа[счТовары];
//		СтрокаТЧ = ОбъектДанных.НаборыЗначенийДоступа.Добавить();


//		_знч = "";
//		ЕстьЗначение = стрк.ЗначениеДоступа.свойство("Значение",_знч);
//		Если ЕстьЗначение Тогда
//			СтрокаТЧ.ЗначениеДоступа = стрк.ЗначениеДоступа.Значение;
//		Иначе
//			СтрокаТЧ.ЗначениеДоступа = Неопределено;
//		КонецЕсли;
//		// на случай, если есть метод поиска ссылки:
//		СтрокаТЧ.ЗначениеДоступа = ксп_ИмпортСлужебный.НайтиПеречисление_ЗначениеДоступа(стрк.ЗначениеДоступа);

//		СтрокаТЧ.Изменение = стрк.Изменение;

//		СтрокаТЧ.НомерНабора = стрк.НомерНабора;

//		гуид="";
//		ЕстьАтрибут = стрк.Уточнение.свойство("Ref",гуид);
//		Если ЕстьАтрибут Тогда
//			СтрокаТЧ.Уточнение = Справочники_Документы.КакойТоВидМД.ПолучитьСсылку( Новый УникальныйИдентификатор( стрк.Уточнение.Ref ) );
//		Иначе
//			СтрокаТЧ.Уточнение = Неопределено;
//		КонецЕсли;
//		// на случай, если есть метод поиска ссылки:
//		СтрокаТЧ.Уточнение = ксп_ИмпортСлужебный.НайтиУточнение(стрк.Уточнение);

//		СтрокаТЧ.Чтение = стрк.Чтение;

//	КонецЦикла;




	//------------------------------------------------------ ФИНАЛ


	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	ОбъектДанных.Записать();


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

