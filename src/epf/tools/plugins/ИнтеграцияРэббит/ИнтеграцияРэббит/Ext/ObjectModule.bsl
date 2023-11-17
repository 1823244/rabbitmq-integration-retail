﻿Перем КэшОбъектовПлагинов;
Перем Плагины;

Функция ОписаниеПлагина(КонтекстЯдра, ВозможныеТипыПлагинов) Экспорт
	Результат = Новый Структура;
	Результат.Вставить("Тип", ВозможныеТипыПлагинов.Утилита);
	Результат.Вставить("Идентификатор", Метаданные().Имя);//"БазовыеУтверждения");
	Результат.Вставить("Представление", "Хэлперы для тестирования интеграций с RabbitMQ");
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
КонецФункции

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
КонецПроцедуры



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиСоздатьЛюбойОбъект(Тип = "Справочник", Вид = "ВидыНоменклатуры")
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ  первые 1
		|	Таблица.Ссылка КАК Ссылка
		|ИЗ
		|	"+Тип+"."+Вид+" КАК Таблица";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Объект= ВыборкаДетальныеЗаписи.Ссылка;
	КонецЦикла;
	
	Если НЕ ЗначениеЗаполнено(Объект) Тогда
		Если НРег(Тип) = НРег ("Справочник") Тогда
			Объект = Справочники[Вид].СоздатьЭлемент();
			Объект.Наименование = "тест Спр";
		ИначеЕсли НРег(Тип) = НРег ("Документ") Тогда
			Объект = Документы[Вид].СоздатьДокумент();
			Объект.Дата = ТекущаяДата();
		ИначеЕсли НРег(Тип) = НРег ("ПланВидовХарактеристик") Тогда
			Объект = ПланыВидовХарактеристик[Вид].СоздатьЭлемент();
			Объект.Наименование = "тест ПВХ";
		КонецЕсли;
		Объект.ОбменДанными.Загрузка = Истина;                 
		Объект.Записать();
	КонецЕсли;

		
	Возврат Объект.Ссылка;
	
КонецФункции


// проверяет лишь факт выполнения метода плагина
// Параметры
//	ТипОбъекта - строка - пример: "Справочник.ВидыНоменклатуры";
//
Функция ПолучитьСтруктуруИзJson(ТипОбъекта) Экспорт
	
	Плагины();
	
	
	поля = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ТипОбъекта, ".");
	Вид = поля[0];//"Справочник"
	Тип = поля[1];//"ВидыЦен"
	
	Плагин = Неопределено;
	Успешно = НайтиПлагин(ТипОбъекта, Плагин);
	
	Объект = НайтиСоздатьЛюбойОбъект(Вид, Тип);
	
	json = Плагин.ВыгрузитьОбъект(Объект);
	
	мЧтениеJSON = Новый ЧтениеJSON;
	мЧтениеJSON.УстановитьСтроку(json);
	тДанные = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
	
	Ответ = Новый Структура("ДанныеСтруктура, Объект",тДанные,Объект);
	
	Возврат Ответ;
	
КонецФункции


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
		|	спр.ИмяОбъекта ПОДОБНО ""Плагин_RabbitMQ_экспорт%""  И спр.ПометкаУдаления = ЛОЖЬ";
	
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

		//ключ - тип объекта МД, значение - ссылка в Доп обработках
		Ключ = Сред(стрк.ИмяОбъекта, 25);
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
//	ТипОбъекта 	- строка - это не ТипЗнч()! а вот так: Объект.Метаданные().ПолноеИмя() - "Справочник.ВидыЦен"
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


///////////// ИМПОРТ



// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция Импорт_ПолучитьСтруктуруИзJson(json) Экспорт
	
	Плагины_Импорт();
	
	мЧтениеJSON = Новый ЧтениеJSON;
	мЧтениеJSON.УстановитьСтроку(json);
	тДанные = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура

	
	Плагин = Неопределено;
	Успешно = НайтиПлагин(тДанные.type, Плагин);
	
	
	ДанныеСсылка = Плагин.ЗагрузитьОбъект(тДанные, json = "");
	
	
	Ответ = Новый Структура("ДанныеСтруктура, Объект",тДанные,ДанныеСсылка);
	
	Возврат Ответ;
	
КонецФункции






#Область ПлагиныИмпорт

// Собирает плагины из спр Доп. обработки в ТЗ
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция НайтиПлагиныВДопОбработках_Импорт()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	спр.Ссылка КАК Ссылка,
		|	спр.ИмяОбъекта КАК ИмяОбъекта
		|ИЗ
		|	Справочник.ДополнительныеОтчетыИОбработки КАК спр
		|ГДЕ
		|	спр.ИмяОбъекта ПОДОБНО ""Плагин_RabbitMQ_импорт_из_Розницы%""  И спр.ПометкаУдаления = ЛОЖЬ";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса.Выгрузить();
	
КонецФункции

// Подключает плагины - обработки, формирующие json-тексты из объектов базы данных
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура Плагины_Импорт() Экспорт
	
	Плагины = Новый Структура;
	
	
	// универсальный код подключения плагина
	
	ТЗ = НайтиПлагиныВДопОбработках_Импорт();
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


#КонецОбласти 	

