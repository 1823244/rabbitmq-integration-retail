﻿&НаКлиенте
Перем КонтекстЯдра;
&НаКлиенте
Перем Ожидаем;
&НаКлиенте
Перем РегулярныеВыражения;
&НаКлиенте
Перем СтроковыеУтилиты;

&НаКлиенте
Перем АдресСервера;

&НаКлиенте
Перем Язык,
		Формат,
		  ПропускатьСловаСЦифрами,
		  ПропускатьУРЛ,
		  ПропускатьДублированиеСлов,
		  ПропускатьПрописные;

&НаКлиенте
Перем СловарьИсключений;
&НаКлиенте
Перем ПроверкаПоШаблону;
		  


// { Plugin interface

&НаКлиенте
Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	
	КонтекстЯдра = КонтекстЯдраПараметр;
	Ожидаем             = КонтекстЯдра.Плагин("УтвержденияBDD");
	РегулярныеВыражения = КонтекстЯдра.Плагин("РегулярныеВыражения");
	СтроковыеУтилиты    = КонтекстЯдра.Плагин("СтроковыеУтилиты");
	
	// Инициализация параметров
	
	АдресСервера = "speller.yandex.net";
	Язык         = "ru, en";
	Формат       = "plain";
	
	ПропускатьСловаСЦифрами    = Ложь;
	ПропускатьУРЛ              = Ложь;
	ПропускатьДублированиеСлов = Истина;
	ПропускатьПрописные        = Ложь;
	СловарьИсключений          = Новый Массив;
	ПроверкаПоШаблону          = Ложь;
	
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

#Область Настройки_плагина

&НаКлиенте
// Переключает режим проверки: пропускать слова с цифрами
// Например, авп17х4534
//
// Параметры:
//  Флаг - Булево - включить или выключить проверку
//
Процедура ПропускатьСловаСЦифрами(Флаг = Ложь) Экспорт

	Ожидаем.Что(Флаг, "Флаги должны быть булевыми").ИмеетТип("Булево");
	Лог("Устанавливаем значение Проверять слова с цифрами на " + Формат(Флаг, "БЛ=Нет; БИ=Да"));
	ПропускатьСловаСЦифрами = Флаг;

КонецПроцедуры // ПропускатьСловаСЦифрами()

&НаКлиенте
// Переключает режим проверки: пропускать слова интернет-адреса, почтовые адреса и имена файлов.
// Например: yandex.ru
//
// Параметры:
//  Флаг - Булево - включить или выключить проверку
//
Процедура ПропускатьУРЛ(Флаг = Ложь) Экспорт

	Ожидаем.Что(Флаг, "Флаги должны быть булевыми").ИмеетТип("Булево");
	Лог("Устанавливаем значение Пропускать интернет-адреса, почтовые адреса и имена файлов на " + Формат(Флаг, "БЛ=Нет; БИ=Да"));
	ПропускатьУРЛ = Флаг;

КонецПроцедуры // ПропускатьУРЛ()

&НаКлиенте
// Переключает режим проверки: пропускать дублирование слов в предложении
// Например: я полетел на >на< Кипр"
//
// Параметры:
//  Флаг - Булево - включить или выключить проверку
//
Процедура ПропускатьДублированиеСлов(Флаг = Ложь) Экспорт

	Ожидаем.Что(Флаг, "Флаги должны быть булевыми").ИмеетТип("Булево");
	Лог("Устанавливаем значение Подсвечивать повторы слов, идущие подряд на " + Формат(Флаг, "БЛ=Нет; БИ=Да"));
	ПропускатьДублированиеСлов = Флаг;

КонецПроцедуры // ПропускатьДублированиеСлов()

&НаКлиенте
// Переключает режим проверки: Игнорировать неверное употребление ПРОПИСНЫХ/строчных букв
// Например: москва
//
// Параметры:
//  Флаг - Булево - включить или выключить проверку
//
Процедура ПропускатьПрописные(Флаг = Ложь) Экспорт

	Ожидаем.Что(Флаг, "Флаги должны быть булевыми").ИмеетТип("Булево");
	Лог("Устанавливаем значение Игнорировать неверное употребление ПРОПИСНЫХ/строчных букв на " + Формат(Флаг, "БЛ=Нет; БИ=Да"));
	ПропускатьПрописные = Флаг;

КонецПроцедуры // ПропускатьПрописные()

&НаКлиенте
// Меняем адрес сервиса проверки орфографии
//
// Параметры:
//  НовыйАдрес  - Строка - адрес сервиса
//
Процедура УстановитьАдресСервиса(НовыйАдрес) Экспорт

	Лог("Меняем адрес сервиса с " + АдресСервера + " на " + НовыйАдрес, Истина);
	
	АдресСервера = НовыйАдрес;

КонецПроцедуры // УстановитьАдресСервиса()

&НаКлиенте
// Сравнивать слова из словаря через регулярные выражения
// Может сказаться на производительности
//
// Параметры:
// Флаг  - Булево - включить или выключить использование шаблонов
//
Процедура ИспользоватьШаблонДляСловаря(Флаг = Ложь) Экспорт

	Если ЗначениеЗаполнено(СловарьИсключений) Тогда
		
		ВызватьИсключение "Надо сначала установить признак использования шаблона, а потом заполнять словарь.
							|Шаблоны могут быть обработаны неверно";
		
	КонецЕсли;
	
	Лог("Устанавливаем значение Проверять слова из словаря по шаблону на " + Формат(Флаг, "БЛ=Нет; БИ=Да"), Истина);
	ПроверкаПоШаблону = Флаг;

КонецПроцедуры // ИспользоватьШаблонДляСловаря()

&НаКлиенте
// Задает список слов, которые не считать ошибками
//
// Параметры:
//  Словарь  - Строка,ТекстовыеДокумент - словарь исключений
//
Процедура ИспользоватьСловарьИсключений(Словарь) Экспорт

	Если ТипЗнч(Словарь) = Тип("Строка") Тогда
		
		ТекстСловаря = Словарь;
		
	ИначеЕсли Тип(Словарь) = Тип("ТекстовыйДокумент") Тогда
		
		Текст = Словарь.ПолучитьТекст();
		
	Иначе
		
		ВызватьИсключение "Неожиданный тип словаря " + ТипЗнч(Словарь);
		
	КонецЕсли;
	
	СловарьИсключений = СтроковыеУтилиты.РазложитьСтрокуВМассивПодстрок(ТекстСловаря, Символы.ПС);
	
	Если Не ПроверкаПоШаблону Тогда
	
		Для Сч = 0 по СловарьИсключений.Количество() - 1 Цикл
		
			СловарьИсключений[Сч] = НРег(СловарьИсключений[Сч]);
		
		КонецЦикла;
		
	КонецЕсли;

КонецПроцедуры // ИспользоватьСловарьИсключений()


#КонецОбласти

#Область Обработка_результатов

&НаКлиенте
Функция ИнициализироватьСтрукутуруРезультатПроверки()
	
	Результат = Новый Структура;
	Результат.Вставить("КодОшибки");
	Результат.Вставить("Ошибка");
	Результат.Вставить("Позиция");
	Результат.Вставить("Строка");
	Результат.Вставить("Столбец");
	Результат.Вставить("Длина");
	Результат.Вставить("ИсходноеСлово");
	Результат.Вставить("Варианты");
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция РезультатПроверкиПравописания(Данные = Неопределено)
	
	Результат = ИнициализироватьСтрукутуруРезультатПроверки();
	
	Если Данные = Неопределено Тогда
		
		Возврат Результат;

	КонецЕсли;
	
	Результат.КодОшибки		= Данные["code"];
	Результат.Ошибка		= ПредставлениеОшибкиПравописания(Данные["code"]);
	Результат.Позиция		= Данные["pos"];
	Результат.Строка		= Данные["row"];
	Результат.Столбец		= Данные["col"];
	Результат.Длина 		= Данные["len"];
	Результат.ИсходноеСлово = Данные["word"];
	Подсказки 				= Новый Массив;
	
	Для Каждого Подсказка из Данные["s"] Цикл
		
		Подсказки.Добавить(Подсказка);
		
	КонецЦикла;
	
	Результат.Варианты = Подсказки;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция СловоВСловареИсключений(Слово)
	
	Результат = Ложь;
	
	Если ПроверкаПоШаблону Тогда
		
		Для Каждого ШаблонИсключение Из СловарьИсключений Цикл
			
			Если РегулярныеВыражения.СтрокаСоответствуетШаблону(Слово, ШаблонИсключение) Тогда
				
				Отладка("Слово " + Слово + " соответствет шаблону исключения " + ШаблонИсключение);
				
				Результат = Истина;
				Прервать;
				
			КонецЕсли;
			
		КонецЦикла;
		
	Иначе
		
		Результат = (СловарьИсключений.Найти(НРег(Слово)) <> Неопределено);
		
	КонецЕсли;
	
	Возврат Результат;

КонецФункции

&НаКлиенте
Функция РазобратьРезультатПроверки(ОтветСервиса)
	
	Результат = Новый Массив;

	Для Каждого СтрокаДанных Из ОтветСервиса Цикл
		
		Ошибка = РезультатПроверкиПравописания(СтрокаДанных);
		Если НЕ СловоВСловареИсключений(Ошибка.ИсходноеСлово) Тогда
			
			Результат.Добавить(Ошибка);
			
		КонецЕсли;
		
	КонецЦикла;	
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область Представление_результата_проверки

&НаКлиенте
Функция ПредставлениеОшибкиПравописания(КодОшибки)
	
	Результат = "";
	
	Если КодОшибки = 1 Тогда 
		
		Результат = "Возможно, ошибочное написание.";

	ИначеЕсли КодОшибки = 2 Тогда
		
		Результат = "Повтор слова.";
		
	ИначеЕсли КодОшибки = 3 Тогда
		
		Результат = "Неверное употребление прописных и строчных букв.";
		
	ИначеЕсли КодОшибки = 4 Тогда
		
		Результат = "Текст содержит слишком много ошибок. Разбейте текст на части";
		
	Иначе
		
		ВызватьИсключение "Неизвестный код ошибки YASpeller: " + КодОшибки;
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция ПредставлениеПодсказок(МассивПодскахок)
	
	Результат = "Варианты: ";
	Разделитель = "";
	Для Каждого Вариант Из МассивПодскахок Цикл
		
		Результат = Результат + Разделитель + Вариант;
		Разделитель = ", ";
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
// Формирует строковое представление результата проверки
//
// Параметры:
//  МассивРезультатов  - Массив - результат функции ПроверитьТекст
//
// Возвращаемое значение:
//   Строка   - читабельное представление ошибок
//
Функция ОписаниеРезультатаПроверкиПравописания(МассивРезультатов)
	
	//{1,1}: Возможно, ошибочное написание. (Варианты:..) 
	Шаблон = "{%1, %2} ""%3"": %4 %5";
	Результат = "";
	Разделитель = "";
	
	Для Каждого Ошибка Из МассивРезультатов Цикл
		
		Результат = Результат + Разделитель +
						СтроковыеУтилиты.ПодставитьПараметрыВСтроку(Шаблон,
									Ошибка.Строка,
									Ошибка.Столбец,
									Ошибка.ИсходноеСлово,
									ПредставлениеОшибкиПравописания(Ошибка.КодОшибки),
									ПредставлениеПодсказок(Ошибка.Варианты));
									
		Разделитель = Символы.ПС;
									
	КонецЦикла;

	Возврат Результат
	
КонецФункции // ОписаниеРезультатаПроверкиПравописания()

#КонецОбласти

#Область Выполнение_проверок

&НаКлиенте
// Подготовка параметра настройка правописания
//
// Параметры:
//   ПропускатьСловаСЦифрами	- Булево - Пропускать слова с цифрами, например, "авп17х4534".
//   ПропускатьУРЛ				- Булево - Пропускать интернет-адреса, почтовые адреса и имена файлов.
//   ПропускатьДублированияСлов	- Булево - Пропускать повторы слов, идущие подряд. Например, "я полетел на на Кипр".
//   ПропускатьПрописные		- Булево - Игнорировать неверное употребление ПРОПИСНЫХ/строчных букв, например, в слове "москва".
//
// Возвращаемое значение:
//   Число   - значение настрйоки
//
Функция НастройкиПроверкиПравописания()
										
	Результат = 0;
	
	Если ПропускатьСловаСЦифрами Тогда
		
		Результат = Результат + 2;
		
	КонецЕсли;

	Если ПропускатьУРЛ Тогда
		
		Результат = Результат + 4;
		
	КонецЕсли;
	
	Если Не ПропускатьДублированиеСлов Тогда //ВАЖНО! Здесь НЕ. Потому что настройка вообще звучит как Проверять повторение слов
												// Но ради единообразия параметров это настройка Пропускать дублирование слов
		
		Результат = Результат + 8;
		
	КонецЕсли;
	
	Если ПропускатьПрописные Тогда
		
		Результат = Результат + 512;

	КонецЕсли;
	
	Возврат Результат;
КонецФункции // НастройкиПроверкиПравописания()

&НаКлиенте
Функция ПараметрыЗапроса()
	
	Возврат СтроковыеУтилиты.ПодставитьПараметрыВСтроку("?options=%1&lang=%2&format=%3",
						НастройкиПроверкиПравописания(),
						Язык,
						Формат);
	
КонецФункции

&НаКлиенте
Функция ПолучитьHTTPСоединение()
	
	ТаймаутСоединения = 15; 
	ПортЗащищенногоСоединения = 443;
	
	Соединение = Новый HTTPСоединение(АдресСервера, ПортЗащищенногоСоединения
										,
										,
										,
										,
										ТаймаутСоединения, 
										Новый ЗащищенноеСоединениеOpenSSL);	
	Возврат Соединение
	
КонецФункции

&НаКлиенте
Функция ПолучитьHTTPЗапрос(Текст)
	
	Заголовки  = Новый Соответствие;
    Заголовки.Вставить("Content-Type", "application/x-www-form-urlencoded"); 
	
	Запрос     = Новый HTTPЗапрос("/services/spellservice.json/checkText" + ПараметрыЗапроса(), Заголовки);
	Запрос.УстановитьТелоИзСтроки("text="+Текст);
	
	Возврат Запрос;
	
КонецФункции

&НаКлиенте
// Выполняет проверку орфографии и возвращает результат в виде массива
//
// Параметры:
//  ТекстНаПроверку  - Строка - текст, который надо проверить на ошибки
//
// Возвращаемое значение:
//   Массив   - массив ошибок, содержит тип ошибки, ошибочное слово и варианты исправления
//
Функция ВыполнитьПроверкуТекста(ТекстНаПроверку) Экспорт

	Ожидаем.Что(ТекстНаПроверку, "Передан некорректный текст на проверку").ИмеетТип("Строка").Заполнено();
	
	Соединение = ПолучитьHTTPСоединение();
	Запрос     = ПолучитьHTTPЗапрос(ТекстНаПроверку);
	
	Результат = Неопределено;
	
	Попытка
		
		Ответ = Соединение.ОтправитьДляОбработки(Запрос);
		
	Исключение
		
		Лог("Не удалось выполнить HTTP запрос: " + ОписаниеОшибки(), Истина);
		
		Возврат Результат;
		
	КонецПопытки;
	
	КодКорректноВыполненногоЗапроса = 200;
	
	Если Ответ.КодСостояния = КодКорректноВыполненногоЗапроса Тогда 
		
		ТелоОтвета = Ответ.ПолучитьТелоКакСтроку();
		Отладка(ТелоОтвета);
		
		ДанныеОтвета = РазобратьJSON(ТелоОтвета);
		
		Если ДанныеОтвета = Неопределено Тогда
			
			Лог("Не удалось разобать ответ: " + ТелоОтвета);
			
		Иначе
			
			Результат = РазобратьРезультатПроверки(ДанныеОтвета);
			
		КонецЕсли;
		
	Иначе
		
		Лог("Код ответа сервиса: " + Ответ.Код, Истина);
		Лог("Тело ответа сервиса: " + Ответ.ПолучитьТелоКакСтроку(), Истина);
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции // ВыполнитьПроверкуТекста()

&НаКлиенте
// Выполнение теста что в переданном тексте нет ошибок
//
// Параметры:
// Параметры:
//  ТекстНаПроверку  - Строка - текст, который надо проверить на ошибки
//
Процедура ОжидаемЧтоНетОшибок(ТекстНаПроверку) Экспорт

	РезультатПроверки = ВыполнитьПроверкуТекста(ТекстНаПроверку);
	
	Если РезультатПроверки = Неопределено Тогда
		
		ВызватьИсключение "[Pending] Не удалось выполнить проверку текста. См. лог";
		
	ИначеЕсли РезультатПроверки.Количество() > 0 Тогда
		
		ВызватьИсключение "Ожидали, что в тексте не будет орфографических ошибок" + Символы.ПС + 
							ТекстНаПроверку + 
							Символы.ПС + ОписаниеРезультатаПроверкиПравописания(РезультатПроверки);
							
	КонецЕсли;

КонецПроцедуры // ОжидаемЧтоНетОшибок()


	
#КонецОбласти

&НаКлиенте
Функция РазобратьJSON(ТекстJSON)
	
	ЧтениеJSON = Новый ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(ТекстJSON);
	
	Результат = ПрочитатьJSON(ЧтениеJSON, Истина);
	
	Возврат Результат;
	
КонецФункции

// { Helpers
&НаСервере
Функция ЭтотОбъектНаСервере()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции

&НаКлиенте
Процедура Отладка(ТекстСообщения)
	
	КонтекстЯдра.Отладка(ТекстСообщения);
	
КонецПроцедуры

&НаКлиенте
Процедура Лог(ТекстСообщения, Важное = Ложь)
	
	Если Важное Тогда
		
		КонтекстЯдра.ВывестиСообщение(ТекстСообщения, СтатусСообщения.Важное);
		
	Иначе
		
		КонтекстЯдра.ВывестиСообщение(ТекстСообщения);
		
	КонецЕсли;		
	
КонецПроцедуры
// } Helpers

&НаКлиенте
Процедура ЯндексНажатие(Элемент)
	ЗапуститьПриложение("http://api.yandex.ru/speller/");
КонецПроцедуры
