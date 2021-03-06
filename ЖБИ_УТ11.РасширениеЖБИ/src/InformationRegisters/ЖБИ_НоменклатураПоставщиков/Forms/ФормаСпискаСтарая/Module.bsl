
#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ

&НаСервере
Функция ПолучитьПустуюСтруктуруНаборЗаписейСервер()
	
	СтруктураНабораЗаписей = РегистрыСведений.ЖБИ_НоменклатураПоставщиков.ПолучитьПустуюСтруктуруНаборЗаписей();
	
	Возврат СтруктураНабораЗаписей;
	
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
	
	////Негабарит
	//ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	//ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Негабаритный");
	//ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	//ЭлементОтбора.ПравоеЗначение = Ложь;
	//ЭлементОтбора.Использование = Ложь;
	
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

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_ЭЛЕМЕНТОВ_УПРАВЛЕНИЯ_ФОРМЫ

&НаКлиенте
Процедура КомандаНастройкиОтборовПоУмолчанию(Команда)
	ЗаполнитьОтборыСпискаПоУмолчанию();
КонецПроцедуры

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Если Копирование Тогда 
		ТекДанные = ЖБИ_ОбщийМодульКлиентСервер.ПроверитьТекСтрокуНаДоступность(ЭтаФорма,"Список");
		Если ТекДанные = Неопределено Тогда 
			Возврат;
		КонецЕсли;
		
		СтруктураНабораЗаписей = ПолучитьПустуюСтруктуруНаборЗаписейСервер();
		ЗаполнитьЗначенияСвойств(СтруктураНабораЗаписей,ТекДанные); 
		
		Отказ = Истина;
		
		ОткрытьФорму("РегистрСведений.ЖБИ_НоменклатураПоставщиков.Форма.ФормаСозданияНоменклатуруПоставщика",
		СтруктураНабораЗаписей,
		ЭтаФорма,,,,
		Новый ОписаниеОповещения("Подключаемый_ОбработкаРезультатаОповещения", ЭтаФорма, "ДобавитьНоменклатуруПоставщикаКопированием"),РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОпределитьДоступностьКоманд()	
	Если НЕ ЖБИ_ОбщийМодульДокументыСервер.ОпределитьДоступностьРоли("ЖБИ_ОсновнаяРоль") Тогда
		Если ЖБИ_ОбщийМодульДокументыСервер.ОпределитьДоступностьРоли("ЖБИ_ОтделСбыта")
			ИЛИ ЖБИ_ОбщийМодульДокументыСервер.ОпределитьДоступностьРоли("ЖБИ_НачальникОтделаСбыта") Тогда			
			Элементы.Список.КонтекстноеМеню.ПодчиненныеЭлементы.СписокКонтекстноеМенюИзменить.Доступность 		= Ложь;
			//Элементы.Список.КонтекстноеМеню.ПодчиненныеЭлементы.СписокКонтекстноеМенюСкопировать.Доступность 	= Ложь;
			//Элементы.Список.КонтекстноеМеню.ПодчиненныеЭлементы.СписокКонтекстноеМенюУдалить.Доступность 		= Ложь;
		Иначе 
			//КоманднаяПанель.ПодчиненныеЭлементы.ФормаСкопировать.Доступность									= Ложь;
			КоманднаяПанель.ПодчиненныеЭлементы.ФормаИзменить.Доступность										= Ложь;
			КоманднаяПанель.ПодчиненныеЭлементы.ФормаУдалить.Доступность										= Ложь;
			КоманднаяПанель.ПодчиненныеЭлементы.ФормаВывестиСписок.Доступность									= Ложь;
			
			//Элементы.Список.КонтекстноеМеню.ПодчиненныеЭлементы.СписокКонтекстноеМенюСкопировать.Доступность 	= Ложь;
			Элементы.Список.КонтекстноеМеню.ПодчиненныеЭлементы.СписокКонтекстноеМенюИзменить.Доступность 		= Ложь;			
			Элементы.Список.КонтекстноеМеню.ПодчиненныеЭлементы.СписокКонтекстноеМенюУдалить.Доступность 		= Ложь;	
		КонецЕсли;
	КонецЕсли;		
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЭлементыФормыИнформацию()
	
	//Доступность команд
	ОпределитьДоступностьКоманд();
	
КонецПроцедуры

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_СОБЫТИЙ_ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)	
	ЗаполнитьОтборыСпискаПоУмолчанию();
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбновитьЭлементыФормыИнформацию();
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбработкаРезультатаОповещения(Результат, ДополнительныеПараметры) Экспорт
	
	Сообщение = Новый СообщениеПользователю;
	РезультатВыполнения = Новый Структура("СообщениеОбОшибке","");	
	Если Результат = КодВозвратаДиалога.Отмена Тогда 
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(ДополнительныеПараметры) = Тип("Структура") Тогда 
		Если ДополнительныеПараметры.Свойство("ИмяСобытия")
			И ЗначениеЗаполнено(ДополнительныеПараметры.ИмяСобытия) Тогда
		КонецЕсли;
	КонецЕсли;

	Если ДополнительныеПараметры = "ДобавитьНоменклатуруПоставщикаКопированием" Тогда
		Если Результат = Неопределено Тогда 
			Возврат;
		КонецЕсли;
		Если Результат.Свойство("СтруктураНабораЗаписей")
			И ЗначениеЗаполнено(Результат.СтруктураНабораЗаписей) Тогда
			
			СтруктураНабораЗаписей = ПолучитьПустуюСтруктуруНаборЗаписейСервер();
			ЗаполнитьЗначенияСвойств(СтруктураНабораЗаписей,Результат.СтруктураНабораЗаписей);
			СтруктураНабораЗаписей.Вставить("ЭтоКопирование", Истина);
			
			ОткрытьФорму("РегистрСведений.ЖБИ_НоменклатураПоставщиков.Форма.ФормаЗаписи",
			СтруктураНабораЗаписей,
			ЭтаФорма,,,,
			Новый ОписаниеОповещения("Подключаемый_ОбработкаРезультатаОповещения", ЭтаФорма, "ДобавитьНоменклатуруПоставщикаКопированиемЗавершение"),РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		ИначеЕсли ДополнительныеПараметры = "ДобавитьНоменклатуруПоставщикаКопированиемЗавершение" Тогда
			Элементы.Список.Обновить();	
		КонецЕсли;
	КонецЕсли;
			
КонецПроцедуры

#КонецОбласти
