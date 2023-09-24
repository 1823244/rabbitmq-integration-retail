﻿&НаКлиенте
Перем КонтекстЯдра;

// { Plugin interface

&НаКлиенте
Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
КонецПроцедуры

&НаКлиенте
Функция ОписаниеПлагина(КонтекстЯдра, ВозможныеТипыПлагинов) Экспорт
	Возврат ОписаниеПлагинаНаСервере(ВозможныеТипыПлагинов);
КонецФункции

&НаСервере
Функция ОписаниеПлагинаНаСервере(ВозможныеТипыПлагинов)
	КонтекстЯдраНаСервере = ВнешниеОбработки.Создать("xddTestRunner");
	Возврат ЭтотОбъектНаСервере().ОписаниеПлагина(КонтекстЯдраНаСервере, ВозможныеТипыПлагинов);
КонецФункции
// } Plugin interface

// { Report generator interface
&НаКлиенте
Функция СоздатьОтчет(КонтекстЯдра, РезультатыТестирования) Экспорт
	Объект.ТипыУзловДереваТестов = КонтекстЯдра.Плагин("ПостроительДереваТестов").Объект.ТипыУзловДереваТестов;
	Объект.ИконкиУзловДереваТестов = КонтекстЯдра.Плагин("ПостроительДереваТестов").Объект.ИконкиУзловДереваТестов;
	Объект.СостоянияТестов = КонтекстЯдра.Объект.СостоянияТестов;
	Возврат СоздатьОтчетНаСервере(РезультатыТестирования);
КонецФункции

&НаСервере
Функция СоздатьОтчетНаСервере(РезультатыТестирования)
	Возврат ЭтотОбъектНаСервере().СоздатьОтчетНаСервере(РезультатыТестирования);
КонецФункции

&НаКлиенте
Процедура Показать(Отчет) Экспорт
	Отчет.Показать();
КонецПроцедуры

&НаКлиенте
Процедура Экспортировать(Отчет, ПолныйПутьФайла) Экспорт
	Отчет.Записать(ПолныйПутьФайла);
КонецПроцедуры
// } Report generator interface

// { Helpers
&НаСервере
Функция ЭтотОбъектНаСервере()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции
// } Helpers

