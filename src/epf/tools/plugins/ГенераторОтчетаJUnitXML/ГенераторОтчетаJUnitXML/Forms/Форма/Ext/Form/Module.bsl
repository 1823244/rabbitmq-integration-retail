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

&НаКлиенте
Процедура ЗаписатьРезультатТеста(Знач КонтекстЯдра, Знач РезультатТеста, Знач ПолныйПутьФайла) Экспорт
	Объект.СостоянияТестов = КонтекстЯдра.Объект.СостоянияТестов;
	// ЗаписатьРезультатТестаНаСервере(РезультатТеста, ПолныйПутьФайла);
	Отчет = ПолучитьРезультатТестаНаСервере(РезультатТеста);
	ИмяФайла = ПолучитьУникальноеИмяФайла(ПолныйПутьФайла);
	Экспортировать(Отчет, ИмяФайла);
КонецПроцедуры

&НаСервере
Функция ПолучитьРезультатТестаНаСервере(Знач РезультатТеста) Экспорт
	Возврат ЭтотОбъектНаСервере().ПолучитьРезультатТестаНаСервере(РезультатТеста);
КонецФункции

// } Report generator interface

&НаКлиенте
Процедура НачатьЭкспорт(ОбработкаОповещения, Отчет, ПолныйПутьФайла) Экспорт

	Если ТребуетсяАсинхроннаяЗаписьДокумента() Тогда
		Отчет.НачатьЗапись(ОбработкаОповещения, ПолныйПутьФайла);
	Иначе
		Отчет.Записать(ПолныйПутьФайла);
		ВыполнитьОбработкуОповещения(ОбработкаОповещения);
	КонецЕсли;

КонецПроцедуры

// До 8.3.9 не контролируется метод Записать, а в 8.3.6 вообще нет метода НачатьЗапись
//
&НаКлиенте
Функция ТребуетсяАсинхроннаяЗаписьДокумента()

	СИ = Новый СистемнаяИнформация;
	Версия = Сред(СИ.ВерсияПриложения,3); // сразу уберем 8.
	Поз = Найти(Версия, ".");
	Минор = Число(Лев(Версия, Поз-1));
	Если Минор > 3 Тогда
		Возврат Истина;
	КонецЕсли;

	Версия = Сред(Версия, Поз+1);
	Релиз = Число(Лев(Версия, Найти(Версия, ".")-1));

	Если Релиз > 8 Тогда
		Возврат Истина;
	КонецЕсли;

	Возврат Ложь;

КонецФункции

// { Helpers
&НаСервере
Функция ЭтотОбъектНаСервере()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции

&НаКлиенте
Функция ПолучитьУникальноеИмяФайла(Знач ИмяФайла)
	Файл = Новый Файл(ИмяФайла);
	ГУИД = Новый УникальныйИдентификатор;
	ИмяФайла = КонтекстЯдра.СтрШаблон_("%1-result.xml", ГУИД);
	ИмяФайла = КонтекстЯдра.СтрШаблон_("%1/%2", Файл.Путь, ИмяФайла);
	Возврат ИмяФайла;
КонецФункции

// } Helpers
