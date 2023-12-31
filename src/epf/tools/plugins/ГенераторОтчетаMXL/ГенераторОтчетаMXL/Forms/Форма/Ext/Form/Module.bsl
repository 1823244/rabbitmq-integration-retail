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
	Если Отчет <> Неопределено Тогда
		ЗаголовокОкнаОтчета = НСтр("ru = 'Отчет об автоматическом тестировании'");
		Отчет.Показать(ЗаголовокОкнаОтчета);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Экспортировать(Отчет, ПолныйПутьФайла) Экспорт
	ФайлОтчета = Новый Файл(ПолныйПутьФайла);
	Если Отчет <> Неопределено Тогда
		Отчет.Записать(ПолныйПутьФайла, ПолучитьТипФайлаПоРасширению(ФайлОтчета.Расширение));
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура НачатьЭкспорт(ОбработкаОповещения, Отчет, ПолныйПутьФайла) Экспорт
	ВызватьИсключение "Метод не реализован";
КонецПроцедуры

// } Report generator interface

// { Helpers
&НаСервере
Функция ЭтотОбъектНаСервере()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции

Функция ПолучитьТипФайлаПоРасширению(Знач РасширениеФайла)
	РасширениеФайла = ВРег(РасширениеФайла);
	Если РасширениеФайла = ".MXL" Тогда
		ТипФайла = ТипФайлаТабличногоДокумента.MXL;
	ИначеЕсли РасширениеФайла = ".ODS" Тогда
		ТипФайла = ТипФайлаТабличногоДокумента.ODS;
	ИначеЕсли РасширениеФайла = ".DOCX" Тогда
		ТипФайла = ТипФайлаТабличногоДокумента.DOCX;
	ИначеЕсли РасширениеФайла = ".HTML" Или РасширениеФайла = ".HTM" Тогда
		ТипФайла = ТипФайлаТабличногоДокумента.HTML;
	ИначеЕсли РасширениеФайла = ".XLS" Тогда
		ТипФайла = ТипФайлаТабличногоДокумента.XLS;
	ИначеЕсли РасширениеФайла = ".XLSX" Тогда
		ТипФайла = ТипФайлаТабличногоДокумента.XLSX;
	ИначеЕсли РасширениеФайла = ".TXT" Тогда
		ТипФайла = ТипФайлаТабличногоДокумента.TXT;
	Иначе
		ВызватьИсключение "Неизвестное расширение файла отчета: " + РасширениеФайла;
	КонецЕсли;
	Возврат ТипФайла;
КонецФункции
// } Helpers
