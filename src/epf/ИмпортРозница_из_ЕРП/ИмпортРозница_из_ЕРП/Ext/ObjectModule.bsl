﻿// https://infostart.ru/1c/articles/827126/
Перем мИДСессии;
Перем мЧтениеJSON;

Перем Плагины; // структура
Перем КэшОбъектовПлагинов; //ТЗ


#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Загрузить данные из ЕРП");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Загрузить данные из ЕРП");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180"); // ОБЯЗАТЕЛЬНО!!! //(https://forum.infostart.ru/forum9/topic179193/)
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, "Открыть форму : Загрузить данные из ЕРП","ЗагрузитьДанныеИзЕРПИнтерактивно",ТипКоманды, Ложь) ;
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыВызовСерверногоМетода();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, "Загрузить данные из ЕРП","ЗагрузитьДанныеИзЕРП",ТипКоманды, Ложь) ;
	
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

// Интерфейс для запуска логики обработки.
Процедура ВыполнитьКоманду(ИмяКоманды, ПараметрыВыполнения) Экспорт
	
	Если ИмяКоманды = "ЗагрузитьДанныеИзЕРП" Тогда
		ВыполнитьИмпорт();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти 	



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ВыполнитьИмпорт() Экспорт
	
	Плагины();
		
	ЗагрузитьДанныеИзЕРП_НСИ();
	ЗагрузитьДанныеИзЕРП_Документы();

КонецПроцедуры



Процедура ЗагрузитьДанныеИзЕРП_НСИ()

	Если мЧтениеJSON = Неопределено Тогда
		мЧтениеJSON = Новый ЧтениеJSON;
	КонецЕсли;
	
	ВыполнитьИмпорт_НСИ();
		
КонецПроцедуры	

Процедура ЗагрузитьДанныеИзЕРП_Документы()
	
	Если мЧтениеJSON = Неопределено Тогда
		мЧтениеJSON = Новый ЧтениеJSON;
	КонецЕсли;

	ВыполнитьИмпорт_Документы();
		
КонецПроцедуры	





#Область Плагины

// Собирает плагины из спр Доп. обработки в ТЗ
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиПлагиныВДопОбработках()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	спр.Ссылка КАК Ссылка,
		|	спр.ИмяОбъекта КАК ИмяОбъекта
		|ИЗ
		|	Справочник.ДополнительныеОтчетыИОбработки КАК спр
		|ГДЕ
		|	спр.ИмяОбъекта ПОДОБНО ""Плагин_RabbitMQ_импорт_из_ЕРП%""";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса.Выгрузить();
	
КонецФункции

// Подключает плагины - обработки, формирующие json-тексты из объектов базы данных
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура Плагины() Экспорт
	
	Если ТипЗнч(Плагины) <> Тип("Структура") Тогда
		Плагины = Новый Структура;
	Иначе 
		Плагины.Очистить();
	КонецЕсли;
	
	
	// универсальный код подключения плагина
	
	ТЗ = НайтиПлагиныВДопОбработках();
	Для каждого стрк Из ТЗ Цикл

		ИмяОбработки = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(стрк.ИмяОбъекта, ".");//разделим на имя расширени
		
		массивСлов = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ИмяОбработки[0], "_");
		
		//Плагин_RabbitMQ_импорт_из_ЕРП_Справочник_Номенклатура.epf	
		//ключ - тип объекта МД (напр. Справочник_Номенклатура), значение - ссылка в Доп обработках
		Ключ = массивСлов[5] + "_" + массивСлов[6];

		Плагины.Вставить(Ключ, стрк.Ссылка);
		
	КонецЦикла;	
	
	
	// теперь создание объектов обработок
	
	КэшОбъектовПлагинов = Новый ТаблицаЗначений;
	КэшОбъектовПлагинов.Колонки.Добавить("ТипОбъекта");//строка в формате "Справочник_Номенклатура"
	КэшОбъектовПлагинов.Колонки.Добавить("ПлагинСсылка");//спр ссылка Доп. обработки
	КэшОбъектовПлагинов.Колонки.Добавить("ОбъектПлагина");//объект обработки
	//индексы
	КэшОбъектовПлагинов.Индексы.Добавить("ТипОбъекта");
	КэшОбъектовПлагинов.Индексы.Добавить("ПлагинСсылка");
	
	Для каждого стрк Из Плагины Цикл
		НовСтр = КэшОбъектовПлагинов.Добавить();
		НовСтр.ТипОбъекта 		= стрк.Ключ;
		НовСтр.ПлагинСсылка 	= стрк.Значение;
		НовСтр.ОбъектПлагина 	= ДополнительныеОтчетыИОбработки.ОбъектВнешнейОбработки(стрк.Значение);
	КонецЦикла;
	
		
КонецПроцедуры

// Ищет плагин для указанного типа объекта в кэше - ТЗ "КэшОбъектовПлагинов"
// Параметры:
//	ТипОбъекта 	- строка - это не ТипЗнч()! а вот так: Объект.Метаданные().ПолноеИмя();
//	Плагин - объект обработки - возвращаемый параметр
//
// Возвращаемое значение:
//	Тип: Булево. Истина в случае успеха
//
Функция НайтиПлагин(Знач ТипОбъекта, Плагин = Неопределено)
	
	ТипОбъекта = СтрЗаменить(ТипОбъекта, ".", "_");
	
	Рез = КэшОбъектовПлагинов.Найти(ТипОбъекта, "ТипОбъекта");
	Если НЕ Рез = Неопределено Тогда
		Плагин = Рез.ОбъектПлагина;
		Возврат Истина;
	КонецЕсли;
	Возврат Ложь;
	
КонецФункции


#КонецОбласти 	


//--------------------------------------------------------------------------------

Процедура ВыполнитьИмпорт_НСИ() Экспорт

	ИДСессии = Строка(Новый УникальныйИдентификатор);
	мИДСессии = ИДСессии;
	ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Информация,,,"Сессия запущена.ИД "+ИДСессии);
	
	ИмяОчереди	 			= "to-retail-from-erp-static";

	ПолучаемоеСообщение 	= "";
	ТегСообщения			= 0;
	
	Клиент = PinkRabbit.ПолучитьКлиента();
		
	КоличествоПолученных = 0;
		
	Попытка
		Потребитель = Клиент.BasicConsume(ИмяОчереди, "", Ложь, Ложь, 0);
	Исключение
		т = Клиент.GetLastError();
		Клиент = Неопределено;
		ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Ошибка,,,
		"Ошибка получения сообщений. Сессия ИД "+ИДСессии+". Подробности: "+т);
		
		ВызватьИсключение т;
	КонецПопытки; 
	
	
	Пока Клиент.BasicConsumeMessage("", ПолучаемоеСообщение, ТегСообщения, 5000) Цикл
		
		мЧтениеJSON.УстановитьСтроку(ПолучаемоеСообщение);
			
		тДанные = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
		
		ПолучаемоеСообщение = ""; // Обнуляем, чтобы избежать утечку памяти

		обк = тДанные.identification;
		
		ТипОбъекта = тДанные.type;
		
		ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Информация,,,
			"Тип объекта = "+Строка(ТипОбъекта)+". Сессия ИД "+мИДСессии);
		
		// найти плагин
		Плагин = Неопределено;
		Успешно = НайтиПлагин(ТипОбъекта, Плагин);
		Если НЕ Успешно Тогда
			// а если объектов будет миллион?
			ЗаписьЖурналаРегистрации("ЕНС", УровеньЖурналаРегистрации.Предупреждение, ,, 
				"Для типа данных <"+Строка(ТипОбъекта)+"> нет плагина импорта json из RabbitMQ!");
			
			
			Попытка
				Клиент.BasicAck(ТегСообщения);
				ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Информация,,,
				"Проигнорировано (удалено из очереди) сообщение с тэгом <"+Строка(ТегСообщения)+">. Сессия ИД "+ИДСессии);
			Исключение           
				т = Клиент.GetLastError();
				ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Ошибка,,,
				"Ошибка RabbitMQ при обработке сообщения с тэгом <"+Строка(ТегСообщения)+">. Сессия ИД "+ИДСессии+". Подробности: "+т);
				ТегСообщения = 0; // Обнуляем, чтобы избежать утечку памяти
			КонецПопытки;			
			
			
			Продолжить;
		КонецЕсли;
		
		НачатьТранзакцию();
		Попытка
			Плагин.ЗагрузитьОбъект(тДанные, ПолучаемоеСообщение);
			Клиент.BasicAck(ТегСообщения);
			ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Информация,,,
			"Получено сообщение с тэгом <"+Строка(ТегСообщения)+">. Сессия ИД "+ИДСессии);
			
			ЗафиксироватьТранзакцию();
			
		Исключение           
			ОтменитьТранзакцию();
			
			т = Клиент.GetLastError();
			Если НЕ ЗначениеЗаполнено(т) Тогда
				т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
				ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Ошибка,,,
				"Ошибка обработки сообщения с тэгом <"+Строка(ТегСообщения)+">. Сессия ИД "+ИДСессии+". Подробности: "+т);
				ТегСообщения = 0; // Обнуляем, чтобы избежать утечку памяти
			Иначе 
				ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Ошибка,,,
				"Ошибка RabbitMQ при обработке сообщения с тэгом <"+Строка(ТегСообщения)+">. Сессия ИД "+ИДСессии+". Подробности: "+т);
				ТегСообщения = 0; // Обнуляем, чтобы избежать утечку памяти
			КонецЕсли;
			
			ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Ошибка,,,
				"Ошибка импорта json для объекта с типом: <"+ТипОбъекта+">. Подробности: "+т);
			
		КонецПопытки;
		
		ТегСообщения = 0; // Обнуляем, чтобы избежать утечку памяти	
		
	КонецЦикла;
	Клиент.BasicCancel("");
	
	Клиент = Неопределено;
	
	ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Информация,,,"Получено сообщений "+строка(КоличествоПолученных)+". Сессия ИД "+ИДСессии);
	ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Информация,,,"Сессия Завершена.ИД "+ИДСессии);

КонецПроцедуры

// ЕНС 2023-08-16 Это из УТ, я пока не трогал. Сначала надо сделать НСИ
// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ВыполнитьИмпорт_Документы() Экспорт
	
	ИДСессии = Строка(Новый УникальныйИдентификатор);
	мИДСессии = ИДСессии;
	ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Информация,,,"Сессия запущена.ИД "+ИДСессии);
	
	ИмяОчереди	 			= "to-retail-from-erp-doc";

	ПолучаемоеСообщение 	= "";
	ТегСообщения			= 0;
	
	Клиент = PinkRabbit.ПолучитьКлиента();
		
	КоличествоПолученных = 0;
	
	ОшибкаУжеОбработана = Ложь;
	
	Попытка
		Потребитель = Клиент.BasicConsume(ИмяОчереди, "", Ложь, Ложь, 0);
		Пока Клиент.BasicConsumeMessage("", ПолучаемоеСообщение, ТегСообщения, 5000) Цикл
			
			КоличествоПолученных = КоличествоПолученных + 1;
			
			Попытка
				
				ИмпортДокумента(ПолучаемоеСообщение);
				
				
				Клиент.BasicAck(ТегСообщения);
				
				
				ПолучаемоеСообщение = ""; // Обнуляем, чтобы избежать утечку памяти
				
				
				ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Информация,,,
				"Получено сообщение с тэгом <"+Строка(ТегСообщения)+">. Сессия ИД "+ИДСессии);
				
				ТегСообщения = 0; // Обнуляем, чтобы избежать утечку памяти
				
			Исключение
				
				т = Клиент.GetLastError();
				Если не ЗначениеЗаполнено(т) Тогда
					т = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
					ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Ошибка,,,
					"Ошибка обработки сообщения с тэгом <"+Строка(ТегСообщения)+">. Сессия ИД "+ИДСессии+". Подробности: "+т);
				Иначе 
					ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Ошибка,,,
					"Ошибка RabbitMQ при обработке сообщения с тэгом <"+Строка(ТегСообщения)+">. Сессия ИД "+ИДСессии+". Подробности: "+т);
					Клиент = Неопределено;
				КонецЕсли;
				
				ТегСообщения = 0; // Обнуляем, чтобы избежать утечку памяти
				
				ОшибкаУжеОбработана = Истина;
				
				Прервать;
				
			КонецПопытки;
			
		КонецЦикла;
		Клиент.BasicCancel("");
		
		Клиент = Неопределено;
		
	Исключение
		
		Если НЕ ОшибкаУжеОбработана Тогда
			т = Клиент.GetLastError();
			Клиент = Неопределено;
			ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Ошибка,,,
			"Ошибка получения сообщений. Сессия ИД "+ИДСессии+". Подробности: "+т);
		КонецЕсли;
	КонецПопытки;	
	
	ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Информация,,,"Получено сообщений "+строка(КоличествоПолученных)+". Сессия ИД "+ИДСессии);
	ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Информация,,,"Сессия Завершена.ИД "+ИДСессии);

	
КонецПроцедуры


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ИмпортДокумента(ПолучаемоеСообщение) Экспорт
	
	Если мЧтениеJSON = Неопределено Тогда
		мЧтениеJSON = Новый ЧтениеJSON;
	КонецЕсли;
	
	мЧтениеJSON.УстановитьСтроку(ПолучаемоеСообщение);
		
	тДанные = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура

	обк = тДанные.identification;
	
	ТипОбъекта = тДанные.type;
	
	ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Информация,,,
		"Тип объекта = "+Строка(ТипОбъекта)+". Сессия ИД "+мИДСессии);
	
	// найти плагин
	Плагин = Неопределено;
	Успешно = НайтиПлагин(ТипОбъекта, Плагин);
	Если НЕ Успешно Тогда
		
		// а если объектов будет миллион?
		ЗаписьЖурналаРегистрации("ЕНС", УровеньЖурналаРегистрации.Предупреждение, ,, 
			"Для типа данных <"+Строка(ТипОбъекта)+"> нет доп. обработки импорта json из RabbitMQ!");
		
		Возврат;
	КонецЕсли;
	
	Попытка
		json = Плагин.ЗагрузитьОбъект(тДанные);
	Исключение
		т=ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Ошибка,,,
			"Ошибка импорта json для объекта <"+ТипОбъекта+">. Подробности: "+т);
		Возврат;
	КонецПопытки;
	
		
	//Если тДанные.type = "Документ.РеализацияТоваровУслуг" Тогда
	//	
	// 	GUID = Новый УникальныйИдентификатор(обк.Ref);
	//	СуществующийДокумент = Документы.РеализацияТоваровУслуг.ПолучитьСсылку(GUID);
	//	
	//	Если НЕ ЗначениеЗаполнено(СуществующийДокумент.ВерсияДанных) Тогда
	//		ОбъектДанных = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
	//		СсылкаНового = Документы.РеализацияТоваровУслуг.ПолучитьСсылку(Новый УникальныйИдентификатор(обк.Ref));
	//		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	//	Иначе 
	//		ОбъектДанных = СуществующийДокумент.ПолучитьОбъект();
	//	КонецЕсли;
	//	
	//	деф = тДанные.definition;
	//	
	//	ОбъектДанных.Дата = обк.Date;
	//	ОбъектДанных.Номер = обк.Number;
	//	
	//	ОбъектДанных.СуммаДокумента = деф.СуммаДокумента;
	//	ОбъектДанных.Валюта = деф.Валюта;
	//	
	//	ОбъектДанных.ПометкаУдаления = деф.DeletionMark;
	//	
	//	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	//	
	//	ОбъектДанных.Записать();
	//	
	//	
	//КонецЕсли;
	//
	//ЗаписьЖурналаРегистрации("ИмпортИзЕРП",УровеньЖурналаРегистрации.Информация,,ОбъектДанных.Ссылка,
	//"Объект записан. Сессия ИД "+мИДСессии);

КонецПроцедуры


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
	// в 1С:Розница нет спр. Валюты!
	//Если Свойство = "Валюта" Тогда
	//	Возврат Справочники.Валюты.НайтиПоКоду(Значение);
	//КонецЕсли;
	
КонецФункции



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ТЕСТ() Экспорт


	ИмяТочкиОбмена = "data";
	ИмяОчереди = "testroute";
	ОтправляемоеСообщение = "Test message";
	ОтветноеСообщение = ""; 
	ТегСообщения = 0;

	
	Если НЕ ПодключитьВнешнююКомпоненту("ОбщийМакет.PinkRabbitMQ64", "BITERP", ТипВнешнейКомпоненты.Native) Тогда
		ВызватьИсключение "Ошибка подключения PinkRabbitMQ.dll";
	КонецЕсли;
	
	Клиент  = Новый("AddIn.BITERP.PinkRabbitMQ3");

    Коннект = Константы.ксп_АктивныйСерверRabbitMQ.Получить();
	
	server = Коннект.server;                                                              
	port = Коннект.port;
	username = Коннект.username;
	password = Коннект.password;
	vhost = Коннект.vhost;
	
	Попытка
		Клиент.Connect(server, port, username, password, vhost);
		Клиент.DeclareExchange(ИмяТочкиОбмена, "topic", Ложь, Истина, Ложь);
		Клиент.DeclareQueue(ИмяОчереди, Ложь, Ложь, Ложь, Ложь);
		Клиент.BindQueue(ИмяОчереди, ИмяТочкиОбмена, "#" + ИмяОчереди + "#");
	Исключение
        т = Клиент.GetLastError();
		Клиент = Неопределено;
		ВызватьИсключение т;
	КонецПопытки;
	
	Попытка
	  	Клиент.BasicPublish(ИмяТочкиОбмена, "#" + ИмяОчереди + "#", ОтправляемоеСообщение, 0, Ложь);
	Исключение
        т = Клиент.GetLastError();
		Клиент = Неопределено;
		ВызватьИсключение т;
	КонецПопытки;
	
	Попытка
	    Потребитель = Клиент.BasicConsume(ИмяОчереди, "", Истина, Ложь, 0);
	    Пока Клиент.BasicConsumeMessage("", ОтветноеСообщение, ТегСообщения, 5000) Цикл
	        Клиент.BasicAck(ТегСообщения);
	        //Сообщить("Успешно! Из очереди прочитано сообщение " + ОтветноеСообщение);
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = НСтр("ru = 'Успешно! Из очереди прочитано message: "+ОтветноеСообщение+"'");
			Сообщение.Поле = "";
			//Сообщение.УстановитьДанные();
			Сообщение.Сообщить();
	        ОтветноеСообщение = ""; // Обнуляем, чтобы избежать утечку памяти
	        ТегСообщения = 0; // Обнуляем, чтобы избежать утечку памяти
	    КонецЦикла;
	    Клиент.BasicCancel(Потребитель);
		Клиент = Неопределено;
	Исключение
	    Сообщить(Клиент.GetLastError());
		Клиент = Неопределено;
	КонецПопытки;	
КонецПроцедуры



                              