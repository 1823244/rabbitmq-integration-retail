﻿#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.1");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Плагин_RabbitMQ_импорт_из_ЕРП_Справочник_Номенклатура");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Плагин_RabbitMQ_импорт_из_ЕРП_Справочник_Номенклатура");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Плагин_RabbitMQ_импорт_из_ЕРП_Справочник_Номенклатура",
		"Форма_Плагин_RabbitMQ_импорт_из_ЕРП_Справочник_Номенклатура",
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


// Описание_метода
//
// Параметры:
//	СтруктураОбъекта	- структура - после метода тДанные = ПрочитатьJSON(мЧтениеJSON,,,,"ФункцияВосстановленияJSON",ЭтотОбъект);//структура
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция ЗагрузитьОбъект(СтруктураОбъекта, jsonText = "") Экспорт
	
	Если НЕ НРег(СтруктураОбъекта.type) = "справочник.номенклатура" Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	id = СтруктураОбъекта.identification;
	def = СтруктураОбъекта.definition;
	
	//------------------------------------- предопределенные - не грузим
	
	Если id.predefined Тогда
		возврат Неопределено;
	КонецЕсли;
	
	
	//------------------------------------- Поиск и создание
	
	СуществующийОбъект = Справочники.Номенклатура.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		
	Если НЕ ЗначениеЗаполнено(СуществующийОбъект.ВерсияДанных) Тогда
		Если id.isFolder Тогда
			ОбъектДанных = Справочники.Номенклатура.СоздатьГруппу();
		Иначе 
			ОбъектДанных = Справочники.Номенклатура.СоздатьЭлемент();
		КонецЕсли;
		СсылкаНового = Справочники.Номенклатура.ПолучитьСсылку(Новый УникальныйИдентификатор(id.Ref));
		ОбъектДанных.УстановитьСсылкуНового(СсылкаНового);
	Иначе 
		ОбъектДанных = СуществующийОбъект.ПолучитьОбъект();
	КонецЕсли;
	
	
	//------------------------------------- Реквизиты
	
	ОбъектДанных.Код = id.code;
	
	ОбъектДанных.Наименование = def.description;
	
	ParentRef = "";
	Если id.parent.Свойство("Ref", ParentRef) Тогда
		ОбъектДанных.Родитель = Справочники.Номенклатура.ПолучитьСсылку(Новый УникальныйИдентификатор(ParentRef));
	КонецЕсли;
	
	ОбъектДанных.ПометкаУдаления = def.DeletionMark;
	
	Если НЕ ОбъектДанных.ЭтоГруппа Тогда
		
		ЗаполнитьРеквизитыЭлемента(ОбъектДанных, def);
		
	КонецЕсли;
	
	ОбъектДанных.ОбменДанными.Загрузка = Истина;
	
	ОбъектДанных.Записать();
	
	// сохранить исходное сообщение
	
	РегистрыСведений.ксп_ИсходныеДанныеСообщений.ДобавитьЗапись(ОбъектДанных.Ссылка, jsonText);
	

	Возврат ОбъектДанных.Ссылка;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ЗаполнитьРеквизитыЭлемента(ОбъектДанных, def) Экспорт

	//ОбъектДанных.ВидНоменклатуры = Справочники.ВидыНоменклатуры.ПолучитьСсылку(Новый УникальныйИдентификатор(def.ВидНоменклатуры.ref));
	ОбъектДанных.ВидНоменклатуры = РегистрыСведений.ксп_МэппингВидыНоменклатуры.ПоМэппингу(def.ВидНоменклатуры.ref);
	ОбъектДанных.ТипНоменклатуры = ОбъектДанных.ВидНоменклатуры.ТипНоменклатуры;
	
	ОбъектДанных.ЕдиницаИзмерения = ксп_ИмпортСлужебныйПовтИсп.НайтиЕдиницуИзмерения(def.ЕдиницаИзмерения);
	
	ОбъектДанных.СтавкаНДС = ксп_ИмпортСлужебный.ОпределитьСтавкуНДСПоСправочникуЕРП(def.СтавкаНДС);
	
КонецПроцедуры



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