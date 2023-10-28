﻿

&НаСервере
Функция ЗагрузитьИзJsonНаСервере()
	Ссылка = РеквизитФормыВЗначение("Объект").ЗагрузитьИзJsonНаСервере(JsonText);
	СсылочныйТип = ссылка;
    Возврат Ссылка;
КонецФункции

&НаКлиенте
Процедура ЗагрузитьИзJson(Команда)
	Ссылка = ЗагрузитьИзJsonНаСервере();
	//Сообщить(НСтр("ru = '"+строка(ссылка)+КодНом(Ссылка)+"'"), СтатусСообщения.БезСтатуса);
КонецПроцедуры

&НаСервереБезКонтекста
// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция КодНом(Ном)
		
	Возврат Ном.Код;
	
КонецФункции

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	JsonText = РеквизитФормыВЗначение("Объект").ПолучитьМакет("Пример").ПолучитьТекст();
КонецПроцедуры
