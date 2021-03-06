
#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ 

&НаСервереБезКонтекста
Функция ОбновитьНаименованиеПоставщика(НоменклатураПоставщика,НаименованиеТовраПоставщика, ИнформацияОбОшибки = "")
	
	Результат 				= Истина;
	СпрОбъект 				= НоменклатураПоставщика.ПолучитьОбъект();
	СпрОбъект.Наименование 	= НаименованиеТовраПоставщика;
	Попытка
		СпрОбъект.Записать();
	Исключение
		Результат		   = Ложь;
		ИнформацияОбОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
	КонецПопытки; 
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьОтборыСпискаПоУмолчанию()
	
	Список.Отбор.Элементы.Очистить();
	//Поставщик
	ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Партнер");
	ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементОтбора.ПравоеЗначение = Справочники.Партнеры.ПустаяСсылка();
	ЭлементОтбора.Использование = Ложь;
	
	//Артикул
	ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Артикул");
	ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Содержит;
	ЭлементОтбора.ПравоеЗначение = "";
	ЭлементОтбора.Использование = Ложь;
	
	//МаркировкаОбщепринятая
	ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("МаркировкаОбщепринятая");
	ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Содержит;
	ЭлементОтбора.ПравоеЗначение = "";
	ЭлементОтбора.Использование = Ложь;
	
	//Номенклатура
	ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Номенклатура");
	ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементОтбора.ПравоеЗначение = Справочники.Номенклатура.ПустаяСсылка();
	ЭлементОтбора.Использование = Ложь;
	
	//НоменклатураПоставщика
	ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("НоменклатураПоставщика");
	ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементОтбора.ПравоеЗначение = Справочники.НоменклатураПоставщиков.ПустаяСсылка();
	ЭлементОтбора.Использование = Ложь;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьТаблицуТоваров()
	
	//Получаем схема компановки данных (здесь хранится текст запроса)
	Схема = Элементы.Список.ПолучитьИсполняемуюСхемуКомпоновкиДанных();
	
	//Получаем настройки пользователя (отборы, сортировки и т.п.)
	Настройки = Элементы.Список.ПолучитьИсполняемыеНастройкиКомпоновкиДанных();
	
	//Выводим динамический список в таблицу значений
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных();
	МакетКомпоновки = КомпоновщикМакета.Выполнить(Схема, Настройки, , ,Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки);
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
	ТЗРезультат = ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
	Возврат ТЗРезультат;
	
КонецФункции

&НаСервере
Функция ЗаполнитьНастройкиМакета(ТабличныйДок, ЕстьОтбор)
	
	ТабличныйДок.Очистить();
	Если НЕ ЕстьОтбор Тогда
		Возврат ТабличныйДок;
	КонецЕсли;
		
	ТаблТоваров			= ПолучитьТаблицуТоваров();	
	Макет 				= Обработки.ЖБИ_ЗагрузкаСвойствНоменклатурыПоставщика.ПолучитьМакет("СвойстваНоменклатурыПоставщика");	
	ОбластьШапка 		= Макет.ПолучитьОбласть("Шапка");
	ТабличныйДок.Вывести(ОбластьШапка);
	ОбластьТовар 		= Макет.ПолучитьОбласть("Товар");  
	Для Каждого НомСтр Из ТаблТоваров Цикл 
		ОбластьТовар.Параметры.Поставщик 					= НомСтр.Партнер;
		ОбластьТовар.Параметры.Партнер 						= НомСтр.Партнер;
		ОбластьТовар.Параметры.НоменклатураПоставщика 		= НомСтр.НоменклатураПоставщика;
		ОбластьТовар.Параметры.Артикул 						= НомСтр.НоменклатураПоставщика.Артикул;
		ОбластьТовар.Параметры.МаркировкаОбщепринятая 		= НомСтр.НоменклатураПоставщика.Номенклатура.Артикул;
		ОбластьТовар.Параметры.НормативныйДокумент 			= НомСтр.НормативныйДокумент;
		ОбластьТовар.Параметры.ПунктОтгрузки 				= НомСтр.ПунктОтгрузки;
		ОбластьТовар.Параметры.Автор 						= НомСтр.Автор;
		
		ЗаполнитьЗначенияСвойств(ОбластьТовар.Параметры,НомСтр);		
		ТабличныйДок.Вывести(ОбластьТовар);	
	КонецЦикла;
	
	ТабличныйДок.ФиксацияСверху = 1;
	ТабличныйДок.ФиксацияСлева 	= 1;
	
	Возврат ТабличныйДок;
	
КонецФункции

&НаСервереБезКонтекста
Функция ОбновитьДанныеНоменклатурыПоставщика(ТаблицаНабораЗаписей, СообщениеОбОшибке)
	
	Отказ = Истина;
	Результат = РегистрыСведений.ЖБИ_НоменклатураПоставщиков.СоздатьОбновитьЗаписиРегистраСведений(ТаблицаНабораЗаписей,,, СообщениеОбОшибке);
	Если Не Результат Тогда
		Отказ = Ложь;	
	КонецЕсли;
	
	Возврат Отказ;
		
КонецФункции

&НаСервереБезКонтекста
Процедура фСформироватьДанныеНаСервере(ТабличныйДок, СообщениеОбОшибке)
		
	УстановитьПривилегированныйРежим(Истина);
	НачатьТранзакцию();
	
	НомерСтрокиЗагрузки	= 2;
	ТаблицаСвойств 		= РегистрыСведений.ЖБИ_НоменклатураПоставщиков.ПолучитьПустуюТаблицуНаборЗаписей();		
	Для НомерСтрокиОбласти = НомерСтрокиЗагрузки По ТабличныйДок.ВысотаТаблицы Цикл

		Партнер = ТабличныйДок.Область(НомерСтрокиОбласти,2).Расшифровка;
		Если ПустаяСтрока(Партнер) Тогда
			СообщениеОбОшибке = "Не удалось сопоставить Поставщика";
			Прервать;
		КонецЕсли;
		
		НоменклатураПоставщика = ТабличныйДок.Область(НомерСтрокиОбласти,4).Расшифровка;
		Если ПустаяСтрока(НоменклатураПоставщика) Тогда
			СообщениеОбОшибке = "Не удалось сопоставить Номенклатуру поставщика";
			Прервать;
		КонецЕсли;
		
		НормативныйДокумент = ТабличныйДок.Область(НомерСтрокиОбласти,6).Расшифровка;
		Если ПустаяСтрока(НормативныйДокумент) Тогда
			СообщениеОбОшибке = "Не удалось сопоставить Нормативный документ";
			Прервать;
		КонецЕсли;
		
		ПунктОтгрузки = ТабличныйДок.Область(НомерСтрокиОбласти,7).Расшифровка;
		Если ПустаяСтрока(НормативныйДокумент) Тогда
			СообщениеОбОшибке = "Не удалось сопоставить Пункут отгрузки";
			Прервать;
		КонецЕсли;
		
		Автор = ТабличныйДок.Область(НомерСтрокиОбласти,8).Расшифровка;
		Если ПустаяСтрока(Автор) Тогда
			СообщениеОбОшибке = "Не удалось сопоставить Автора";
			Прервать;
		КонецЕсли;
		 		
		НоваяСтр 										= ТаблицаСвойств.Добавить();				
		НоваяСтр.Партнер								= Партнер; 
		
		НаименованиеТовраПоставщика 					= ТабличныйДок.Область(НомерСтрокиОбласти,5).Текст;
		Если Не ПустаяСтрока(НаименованиеТовраПоставщика) Тогда 
			Результат = ОбновитьНаименованиеПоставщика(НоменклатураПоставщика,НаименованиеТовраПоставщика,СообщениеОбОшибке);
			Если Не Результат Тогда 
				Возврат;
			КонецЕсли;
		КонецЕсли;
		НоваяСтр.НоменклатураПоставщика					= НоменклатураПоставщика;	
		НоваяСтр.НормативныйДокумент					= НормативныйДокумент;
		НоваяСтр.ПунктОтгрузки							= ПунктОтгрузки;
		НоваяСтр.Автор									= Автор;

		НоваяСтр.ДатаОбновления 						= ТабличныйДок.Область(НомерСтрокиОбласти,2).Текст;
		НоваяСтр.СтатусОсторожно 						= ТабличныйДок.Область(НомерСтрокиОбласти,3).Текст;		
		НоваяСтр.МаркировкаОбщепринятая 				= ТабличныйДок.Область(НомерСтрокиОбласти,6).Текст;		
		НоваяСтр.НормаАвто 								= ТабличныйДок.Область(НомерСтрокиОбласти,7).Текст;
		НоваяСтр.Качество 								= ТабличныйДок.Область(НомерСтрокиОбласти,8).Текст;
		НоваяСтр.Вес 									= ТабличныйДок.Область(НомерСтрокиОбласти,9).Текст;
		НоваяСтр.Объем 									= ТабличныйДок.Область(НомерСтрокиОбласти,10).Текст;
		НоваяСтр.Мощность 								= ТабличныйДок.Область(НомерСтрокиОбласти,11).Текст;
		//НоваяСтр.ДиаметрММ 								= ТабличныйДок.Область(НомерСтрокиОбласти,10).Текст;
		//НоваяСтр.ДиаметрВх 								= ТабличныйДок.Область(НомерСтрокиОбласти,11).Текст;
		//НоваяСтр.ДиаметрВых 							= ТабличныйДок.Область(НомерСтрокиОбласти,12).Текст;
		//НоваяСтр.РабочаяДлина 							= ТабличныйДок.Область(НомерСтрокиОбласти,13).Текст;
		//НоваяСтр.ТолщинаСтенки 							= ТабличныйДок.Область(НомерСтрокиОбласти,14).Текст;
		//НоваяСтр.Глубина 								= ТабличныйДок.Область(НомерСтрокиОбласти,15).Текст;
		//НоваяСтр.ШиринаМакс 							= ТабличныйДок.Область(НомерСтрокиОбласти,16).Текст;
		//НоваяСтр.ШиринаМин 								= ТабличныйДок.Область(НомерСтрокиОбласти,17).Текст;
		//НоваяСтр.ВысотаМакс 							= ТабличныйДок.Область(НомерСтрокиОбласти,18).Текст;
		//НоваяСтр.ВысотаМин 								= ТабличныйДок.Область(НомерСтрокиОбласти,19).Текст;
		//НоваяСтр.Армирование 							= ТабличныйДок.Область(НомерСтрокиОбласти,20).Текст;
		//НоваяСтр.БетонВ 								= ТабличныйДок.Область(НомерСтрокиОбласти,21).Текст;
		//НоваяСтр.ВодонепрW 								= ТабличныйДок.Область(НомерСтрокиОбласти,22).Текст;
		//НоваяСтр.МорозF 								= ТабличныйДок.Область(НомерСтрокиОбласти,23).Текст;
		НоваяСтр.СертифицированДо 						= ТабличныйДок.Область(НомерСтрокиОбласти,12).Текст;
		НоваяСтр.Негабаритный 							= ТабличныйДок.Область(НомерСтрокиОбласти,13).Текст;
		НоваяСтр.КолВУпаковке 							= ТабличныйДок.Область(НомерСтрокиОбласти,14).Текст;
		Если ЗначениеЗаполнено(ТабличныйДок.Область(НомерСтрокиОбласти,13).Текст) Тогда 
			НоваяСтр.ВесАвто 							= ТабличныйДок.Область(НомерСтрокиОбласти,15).Текст; 
		Иначе
			НоваяСтр.ВесАвто							= НоваяСтр.Вес * НоваяСтр.НормаАвто;
		КонецЕсли;
		НоваяСтр.Направление 							= ТабличныйДок.Область(НомерСтрокиОбласти,16).Текст;
		НоваяСтр.Комментарий 							= ТабличныйДок.Область(НомерСтрокиОбласти,17).Текст;
	КонецЦикла;
	
	РезультатОбновления = ОбновитьДанныеНоменклатурыПоставщика(ТаблицаСвойств,СообщениеОбОшибке);
	ЗафиксироватьТранзакцию();
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_ЭЛЕМЕНТОВ_УПРАВЛЕНИЯ_ФОРМЫ

&НаКлиенте
Процедура ОтборПриИзменении(Элемент)
	
	ЕстьОтбор = Ложь;
	Для Каждого НомОтбор Из Список.Отбор.Элементы Цикл
		Если НомОтбор.Использование Тогда
			ЕстьОтбор = Истина;
			Прервать;
		КонецЕсли;
	КонецЦикла;
		 
	ЗаполнитьНастройкиМакета(ТабДокумент, ЕстьОтбор); 
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаЗаписать(Команда)	
	СообщениеОбОшибке = "";
	фСформироватьДанныеНаСервере(ТабДокумент, СообщениеОбОшибке);
	Если НЕ ПустаяСтрока(СообщениеОбОшибке) Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибке);
	Иначе 
		ОбщегоНазначенияКлиент.СообщитьПользователю("Загрузка свойств выполнена");
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_СОБЫТИЙ_ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ЗаполнитьОтборыСпискаПоУмолчанию();
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)	
КонецПроцедуры

#КонецОбласти