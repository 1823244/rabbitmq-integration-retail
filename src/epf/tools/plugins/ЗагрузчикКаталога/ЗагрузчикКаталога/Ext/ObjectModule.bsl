﻿// { Plugin interface
Функция ОписаниеПлагина(КонтекстЯдра, ВозможныеТипыПлагинов) Экспорт
	Результат = Новый Структура;
	Результат.Вставить("Тип", ВозможныеТипыПлагинов.Загрузчик);
	Результат.Вставить("Идентификатор", "ЗагрузчикКаталога");
	Результат.Вставить("Представление", "Загрузить тесты из каталога файловой системы");
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
КонецФункции

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
КонецПроцедуры
// } Plugin interface

// { Loader interface
#Если ТолстыйКлиентОбычноеПриложение Тогда
Функция ВыбратьПутьИнтерактивно(КонтекстЯдра, ТекущийПуть = "") Экспорт
	ДиалогВыбораКаталога = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ДиалогВыбораКаталога.Каталог = ТекущийПуть;
	
	Результат = "";
	Если ДиалогВыбораКаталога.Выбрать() Тогда
		Результат = ДиалогВыбораКаталога.Каталог;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции
#КонецЕсли

Функция Загрузить(КонтекстЯдра, Путь) Экспорт
	КаталогДляЗагрузки = Новый Файл(Путь);
	Если Не (КаталогДляЗагрузки.Существует() И КаталогДляЗагрузки.ЭтоКаталог()) Тогда
		ВызватьИсключение "Для загрузки передан не каталог файловой системы <" + КаталогДляЗагрузки.ПолноеИмя + ">";
	КонецЕсли;
	ДеревоТестов = ЗагрузитьКаталог(КонтекстЯдра, КаталогДляЗагрузки);
	ДеревоТестов.Имя = КаталогДляЗагрузки.ПолноеИмя;
	
	Возврат ДеревоТестов;
КонецФункции

Функция ПолучитьКонтекстПоПути(КонтекстЯдра, Путь) Экспорт
	ЗагрузчикФайла = КонтекстЯдра.Плагин("ЗагрузчикФайла");
	Обработка = ЗагрузчикФайла.ПолучитьКонтекстПоПути(КонтекстЯдра, Путь);
	
	Возврат Обработка;
КонецФункции
// } Loader interface

Функция ЗагрузитьКаталог(КонтекстЯдра, КаталогДляЗагрузки)
	КонтейнерКаталога = КонтекстЯдра.Плагин("ПостроительДереваТестов").СоздатьКонтейнер(КаталогДляЗагрузки.Имя);
	НайденныеФайлы = НайтиФайлы(КаталогДляЗагрузки.ПолноеИмя, "*", Ложь);
	Для каждого Файл из НайденныеФайлы Цикл
		#Если Клиент Тогда
			ОбработкаПрерыванияПользователя();
		#КонецЕсли 
		Если Файл.ЭтоКаталог() Тогда
			КонтейнерДочернегоКаталога = ЗагрузитьКаталог(КонтекстЯдра, Файл);
			Если КонтейнерДочернегоКаталога.Строки.Количество() > 0 Тогда
				КонтейнерКаталога.Строки.Добавить(КонтейнерДочернегоКаталога);
			КонецЕсли;
		ИначеЕсли НРег(Файл.Расширение) = ".epf"
			ИЛИ НРег(Файл.Расширение) = ".erf" Тогда
			КонтейнерФайла = ЗагрузитьФайл(КонтекстЯдра, Файл);
			Если ЗначениеЗаполнено(КонтейнерФайла) И КонтейнерФайла.Строки.Количество() > 0 Тогда
				КонтейнерКаталога.Строки.Добавить(КонтейнерФайла);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Возврат КонтейнерКаталога;
КонецФункции

Функция ЗагрузитьФайл(КонтекстЯдра, ФайлОбработки)
	ЗагрузчикФайла = КонтекстЯдра.Плагин("ЗагрузчикФайла");
	Попытка
		ДеревоТестовФайла = ЗагрузчикФайла.Загрузить(КонтекстЯдра, ФайлОбработки.ПолноеИмя);
		Результат = ДеревоТестовФайла;
		Если ДеревоТестовФайла.Строки.Количество() > 0 Тогда
			Результат = ДеревоТестовФайла.Строки[0];
		КонецЕсли;
		
	Исключение
		Сообщить("Не удалось загрузить файл " + ФайлОбработки.ПолноеИмя + Символы.ПС + ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		Результат = Неопределено;
	КонецПопытки;
	
	Возврат Результат;
КонецФункции
