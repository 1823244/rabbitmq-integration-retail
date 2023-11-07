﻿Перем мВнешняяСистема;

#Область ПодключениеОбработкиКБСП

Функция СведенияОВнешнейОбработке() Экспорт

	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();

	ПараметрыРегистрации.Вставить("Вид",ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка());
	ПараметрыРегистрации.Вставить("Версия","1.2");
	//ПараметрыРегистрации.Вставить("Назначение", Новый Массив);
	ПараметрыРегистрации.Вставить("Наименование","Импорт_из_ЕРП_Создание_Перемещений_по_ЗнП_и_РОнТ");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Информация","Импорт_из_ЕРП_Создание_Перемещений_по_ЗнП_и_РОнТ");
	ПараметрыРегистрации.Вставить("ВерсияБСП", "3.1.5.180");
	//ПараметрыРегистрации.Вставить("ОпределитьНастройкиФормы", Ложь);
	
	
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Открыть форму : Импорт_из_ЕРП_Создание_Перемещений_по_ЗнП_и_РОнТ",
		"Форма_Импорт_из_ЕРП_Создание_Перемещений_по_ЗнП_и_РОнТ",
		ТипКоманды, 
		Ложь) ;
		
	ТипКоманды = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыВызовСерверногоМетода();
	ДобавитьКоманду(ПараметрыРегистрации.Команды, 
		"Создание перемещений по данным Заказа на перемещение и Расходного ордера на товары",
		"СозданиеПеремещений",
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

// Интерфейс для запуска логики обработки.
Процедура ВыполнитьКоманду(ИмяКоманды, ПараметрыВыполнения) Экспорт
	
	Если ИмяКоманды = "СозданиеПеремещений" Тогда
		СоздатьПеремещения();
		
	КонецЕсли;
	
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
Функция СоздатьПеремещения() Экспорт
	
	// Выбрать строки, где есть ГУИД ЗаказаНаПерем и нет ПеремещенияТоваров
	// Колонка РасходныйОрдерГУИД заполнена по-определению, т.к. запись
	// сюда создается при импорте этого документа из ЕРП
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Рег.ЗаказНаПеремещениеГУИД КАК ЗаказНаПеремещениеГУИД,
		|	Рег.РасходныйОрдерГУИД КАК РасходныйОрдерГУИД,
		|	ПеремещениеТоваровРозница КАК ПеремещениеСсылка
		|ИЗ
		|	РегистрСведений.ксп_ИсточникДанныхДляПеремещенийТоваровИзЕРП КАК Рег
		|ГДЕ
		|	Рег.ВнешняяСистема = &ВнешняяСистема
		|	И НЕ Рег.ЗаказНаПеремещениеГУИД = &ПустойЗаказНаПеремещениеГУИД
		|";

		//|	И (Рег.ПеремещениеТоваровРозница = Значение(Документ.ПеремещениеТоваров.ПустаяСсылка)
		//|		ИЛИ Рег.ПеремещениеТоваровРозница = Неопределено)
	
	Запрос.УстановитьПараметр("ВнешняяСистема", мВнешняяСистема);
	Запрос.УстановитьПараметр("ПустойЗаказНаПеремещениеГУИД", "");
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		СоздатьПеремещениеТоваров(
			ВыборкаДетальныеЗаписи.ЗаказНаПеремещениеГУИД,
			ВыборкаДетальныеЗаписи.РасходныйОрдерГУИД,
			ВыборкаДетальныеЗаписи.ПеремещениеСсылка);
	КонецЦикла;
	
КонецФункции


// Описание_метода
//
// Параметры:
//	Параметр1 	- Тип1 - 
//
// Возвращаемое значение:
//	Тип: Тип_значения
//
Функция СоздатьПеремещениеТоваров(ЗаказНаПеремещениеГУИД,РасходныйОрдерГУИД, ПеремещениеСсылка)

	НачатьТранзакцию();
	
	ЕстьОшибки = Ложь;
	Попытка
		
		Если не ЗначениеЗаполнено(ПеремещениеСсылка) Тогда
			Обк = Документы.ПеремещениеТоваров.СоздатьДокумент();
		Иначе 
			Обк = ПеремещениеСсылка.ПолучитьОбъект();
		КонецЕсли;
		
		
		ДанныеРО = РегистрыСведений.ксп_РасходныйОрдерНаТовары_ЕРП.ДанныеДокумента(
			мВнешняяСистема, РасходныйОрдерГУИД);
			
		ДанныеЗнП = РегистрыСведений.ксп_ЗаказНаПеремещение_ЕРП.ДанныеДокумента(
			ЗаказНаПеремещениеГУИД, мВнешняяСистема);
		
		//-------------------- ЗАПОЛНЕНИЕ РЕКВИЗИТОВ
		
		Обк.Дата = ДанныеРО.ДатаДокумента;
		//Обк.Комментарий = ДанныеРО.ДатаДокумента;
		Обк.Организация = Справочники.Организации.ОрганизацияПоУмолчанию();
		Обк.ОрганизацияПолучатель = Справочники.Организации.ОрганизацияПоУмолчанию();
		
		Обк.Ответственный = ксп_ИмпортСлужебный.ОтветственныйПоУмолчанию();
		
		//Обк.ПредставлениеДокументаОснования = ДанныеРО.ДатаДокумента;
		Обк.СкладОтправитель = ксп_ИмпортСлужебный.НайтиСкладПоГУИД(ДанныеЗнП.СкладОтправитель, мВнешняяСистема);
		Обк.СкладПолучатель = ксп_ИмпортСлужебный.НайтиСкладПоГУИД(ДанныеЗнП.СкладПолучатель, мВнешняяСистема);

		Обк.МагазинОтправитель = РегистрыСведений.ксп_МэппингСкладМагазин.ПоМэппингу(Обк.СкладОтправитель, мВнешняяСистема);
		Обк.МагазинПолучатель = РегистрыСведений.ксп_МэппингСкладМагазин.ПоМэппингу(Обк.СкладПолучатель, мВнешняяСистема);
		
		Обк.СуммаДокумента = 0;
		//Обк.ФиксироватьНомераГТД = ДанныеРО.ДатаДокумента;
		
		
		//-------------------- ТЧ ТОВАРЫ
		
		Для каждого стрк Из ДанныеРО.ОтгружаемыеТовары Цикл
			
			НовСтр = Обк.Товары.Добавить();  
			
			
			НовСтр.Номенклатура = ксп_ИмпортСлужебный.НайтиНоменклатуруПоГУИД(стрк.Номенклатура);
			НовСтр.Характеристика = ксп_ИмпортСлужебный.НайтиХарактеристикуПоГУИД(стрк.Характеристика);
			НовСтр.Количество = стрк.Количество;
			НовСтр.Цена = 0;
			НовСтр.Сумма = 0;
			НовСтр.КлючСвязи = Обк.Товары.Количество()-1;

			////это для подарочных сертификаторв. пока не знаю, надо ли это вообще...
			//спрСсылка = Справочники.СерийныеНомера.НайтиПоКоду(ГдеВзятьКод или как это вообще работает);
			//Если ЗначениеЗаполнено(спрСсылка) Тогда
				//НовСтр.КлючСвязиСерийныхНомеров = Обк.Товары.Количество()-1;
				//НовСтрСерийныйНом = Обк.СерийныеНомера.Добавить();
				//НовСтрСерийныйНом.КлючСвязиСерийныхНомеров = Обк.Товары.Количество()-1;
				//НовСтрСерийныйНом.СерийныйНомер = СпрСсылка.Ссылка;
			//КонецЕсли;
			
			НовСтр.Упаковка = Неопределено;
			НовСтр.КоличествоУпаковок = стрк.КоличествоУпаковок;
			НовСтр.СтатусУказанияСерий = стрк.СтатусУказанияСерий;// todo доделать 
			// это я не знаю, как работает:
			//НовСтр.СтатусУказанияСерийОтправитель = 123;
			//НовСтр.СтатусУказанияСерийПолучатель = 123;
			//НовСтр.Справка2 = 123;//это ЕГАИС
			//НовСтр.НеобходимостьВводаАкцизнойМарки = 123;
			//НовСтр.Штрихкод = 123;//Характеристика.ТипыШтрихкодов //todo доделать (я пока не знаю, Как работает)
			//НовСтр.КоличествоПоРНПТ = 123;   //кол в единицах прослеживаемости. пока не знаю
			//НовСтр.НомерГТД = 123;
			
			
			//todo доделать поиск серии
			Серия = ксп_ИмпортСлужебный.НайтиСериюНоменклатурыПоГУИД(НовСтр.Номенклатура, стрк.Серия, мВнешняяСистема);
			
			Если ЗначениеЗаполнено(Серия) Тогда
				НовСтрСерия = Обк.Серии.Добавить();
				НовСтрСерия.Серия = Серия;
				НовСтрСерия.Количество = Стрк.количество;
				НовСтрСерия.Номенклатура = НовСтр.Номенклатура;
				НовСтрСерия.Характеристика = НовСтр.Характеристика;
			КонецЕсли;
			
		КонецЦикла;
		
		

		
		
		
		
		//-------------------- ФИНАЛ
		Обк.Записать(РежимЗаписиДокумента.Запись);
		
		РегистрыСведений.ксп_ИсточникДанныхДляПеремещенийТоваровИзЕРП
			.ЗафиксироватьСозданиеПеремещения(
				мВнешняяСистема, 
				ЗаказНаПеремещениеГУИД, 
				РасходныйОрдерГУИД, 
				Обк.Ссылка);
				
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		ОтменитьТранзакцию();

		т = ОписаниеОшибки();
		тдебаг = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		ЕстьОшибки = Истина;
		
	    ЗаписьЖурналаРегистрации("СозданиеПеремещенийТоваровЕРП",УровеньЖурналаРегистрации.Ошибка,,,
			"НЕ удалось создать перемещение: "+т);
	    ЗаписьЖурналаРегистрации("СозданиеПеремещенийТоваровЕРП",УровеньЖурналаРегистрации.Ошибка,,,
			"НЕ удалось создать перемещение. Подроности: "+тдебаг);
		
	    //Сообщить(НСтр("ru = '"+ОписаниеОшибки()+"'"), СтатусСообщения.Внимание);
	КонецПопытки;
	
	Если НЕ ЕстьОшибки Тогда
		
		ПредставлениеДокумента = Строка(Обк);
		Попытка
			Обк.Записать(РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Неоперативный);
		Исключение
		    ЗаписьЖурналаРегистрации("СозданиеПеремещенийТоваровЕРП",УровеньЖурналаРегистрации.Ошибка,,,
				"НЕ удалось провести вновь созданный документ: "+ПредставлениеДокумента);
		КонецПопытки;
		
		
	КонецЕсли;
	
		
КонецФункции



мВнешняяСистема = "erp";

