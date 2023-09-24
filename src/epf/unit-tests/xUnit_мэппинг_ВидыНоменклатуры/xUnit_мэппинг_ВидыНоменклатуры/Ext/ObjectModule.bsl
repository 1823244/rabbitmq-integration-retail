﻿Перем КонтекстЯдра;
Перем Ожидаем;

Перем ЭтоЗначениеЗаполняетсяПередЗапускомТеста;
Перем ЭтоЗначениеЗаполняетсяПослеЗапускаТеста;
Перем ТекстИсключенияПадающегоТеста;

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
	Ожидаем = КонтекстЯдра.Плагин("УтвержденияBDD");
КонецПроцедуры

Процедура ЗаполнитьНаборТестов(НаборТестов) Экспорт
	
	НаборТестов.Добавить("ПоМэппингу");
	НаборТестов.Добавить("ЕстьГУИД");
	НаборТестов.Добавить("ДобавитьГУИД");
	//НаборТестов.Добавить("ТестДолжен_ПроверитьРезультатТестированияОтсутствующегоМетода");
	//НаборТестов.Добавить("ТестДолжен_ПроверитьВызов_ПослеЗапускаТеста");
	//НаборТестов.Добавить("ТестДолжен_ПроверитьВызов_ПослеЗапускаТеста_УПадающегоТеста");
	//НаборТестов.Добавить("ТестДолжен_ПроверитьРезультатТеста_Когда_ПередЗапускаТеста_СОшибкой");
	//НаборТестов.Добавить("ТестДолжен_ПроверитьРезультатТеста_Когда_ПослеЗапускаТеста_СОшибкой");
	
КонецПроцедуры

Процедура ПередЗапускомТеста() Экспорт
	ЭтоЗначениеЗаполняетсяПередЗапускомТеста = Истина;
	ЭтоЗначениеЗаполняетсяПослеЗапускаТеста = Неопределено;
	
	НачатьТранзакцию();
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	ЭтоЗначениеЗаполняетсяПослеЗапускаТеста = Истина;
	
	ОтменитьТранзакцию();
КонецПроцедуры

Процедура ПередЗапускомТеста_СОшибкой() Экспорт
	ВызватьИсключение "ПередЗапускомТеста_СОшибкой";
КонецПроцедуры

Процедура ПослеЗапускаТеста_СОшибкой() Экспорт
	ВызватьИсключение "ПослеЗапускаТеста_СОшибкой";
КонецПроцедуры





// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
Процедура ПоМэппингу() Экспорт
	
	ГУИД = "123";
	ВнешняяСистема = "ЕРП";
	РегистрыСведений.ксп_МэппингВидыНоменклатуры.ПоМэппингу(ГУИД, ВнешняяСистема);

	РегистрыСведений.ксп_МэппингВидыНоменклатуры.ДобавитьГУИД(ГУИД, "ТЕст", ВнешняяСистема);	
	
	Рез = РегистрыСведений.ксп_МэппингВидыНоменклатуры.ПоМэппингу(ГУИД, ВнешняяСистема);
	
	Ожидаем.Что(Рез).НЕ_().Заполнено();
	
КонецПроцедуры

Процедура ЕстьГУИД() Экспорт
	
	ГУИД = "123";
	ВнешняяСистема = "ЕРП";
	РегистрыСведений.ксп_МэппингВидыНоменклатуры.ЕстьГУИД(ГУИД, ВнешняяСистема);

	РегистрыСведений.ксп_МэппингВидыНоменклатуры.ДобавитьГУИД(ГУИД, "ТЕст", ВнешняяСистема);	
	
	Рез = РегистрыСведений.ксп_МэппингВидыНоменклатуры.ЕстьГУИД(ГУИД, ВнешняяСистема);
	
	Ожидаем.Что(Рез).Равно(Истина);
	
КонецПроцедуры

Процедура ДобавитьГУИД() Экспорт
	
	ГУИД = "123";
	ВнешняяСистема = "ЕРП";

	РегистрыСведений.ксп_МэппингВидыНоменклатуры.ДобавитьГУИД(ГУИД, "ТЕст", ВнешняяСистема);	
	
	Рез = РегистрыСведений.ксп_МэппингВидыНоменклатуры.ЕстьГУИД(ГУИД, ВнешняяСистема);
	
	Ожидаем.Что(Рез).Равно(Истина);
	
КонецПроцедуры



