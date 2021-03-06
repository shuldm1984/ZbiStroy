#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ

&НаКлиенте
Процедура ОбновитьЭлементыФормыИнформацию()
	
	//ВидимостьНомерОтгрузки 				= ?(ЭтоПоставщик,Истина,Ложь);
	//Элементы.НомерОтгрузки.Видимость 	= ВидимостьНомерОтгрузки;
		
КонецПроцедуры

&НаКлиенте
Процедура РазобратьXmlАдресныйКлассификатор()
	
	ЧтениеXML = Новый ЧтениеXML;
	Попытка
		ЧтениеXML.УстановитьСтроку(Объект.АдресЗначенияПолей);
		
		РезультатРазборки 			= Новый Массив;
		ТипКонтактнаяИнформацияXDTO = ФабрикаXDTO.Тип("http://www.v8.1c.ru/ssl/contactinfo","КонтактнаяИнформация");
		КонтактнаяИнформация 		= ФабрикаXDTO.ПрочитатьXML(ЧтениеXML,ТипКонтактнаяИнформацияXDTO);
		
		Объект.Регион 		= КонтактнаяИнформация.Состав.Состав.СубъектРФ;
		Объект.Город 		= КонтактнаяИнформация.Состав.Состав.Город;
		Объект.Город 		= КонтактнаяИнформация.Состав.Состав.Город;
		Объект.НаселПункт 	= КонтактнаяИнформация.Состав.Состав.НаселПункт;
		Объект.Территория 	= КонтактнаяИнформация.Состав.Состав.Территория;
	Исключение
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти	

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_ЭЛЕМЕНТОВ_УПРАВЛЕНИЯ_ФОРМЫ

&НаКлиенте
Процедура АдресНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
		ДоставкаТоваровКлиент.ОткрытьФормуВыбораАдресаИОбработатьРезультат(
	    Элемент,
		Объект,
		"Адрес",
		СтандартнаяОбработка);
		
КонецПроцедуры

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_СОБЫТИЙ_ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ЭтоДокумент") Тогда 
		ЭтоДокумент = Параметры.ЭтоДокумент;
	КонецЕсли;
	
	//ЭтоПоставщик = Объект.Владелец.Поставщик;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьЭлементыФормыИнформацию();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	СтруктураРезультат 	= ЖБИ_ОбщийМодульКлиентСервер.РазобратьXmlАдресныйКлассификатор(Объект.АдресЗначенияПолей);
	Объект.Регион 		= СтруктураРезультат.Регион;
	Объект.Город 		= СтруктураРезультат.Город;	
	Объект.НаселПункт 	= СтруктураРезультат.НаселПункт;
	Объект.Территория 	= СтруктураРезультат.Территория;
	Если ПустаяСтрока(Объект.Регион) Тогда 
		ОбщегоНазначенияКлиент.СообщитьПользователю("Укажите обязательное поле Регион в адресе");
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	Если ЭтоДокумент Тогда
	Иначе 
		Если ПустаяСтрока(Объект.Город) Тогда
			Если ПустаяСтрока(Объект.НаселПункт) Тогда
				ОбщегоНазначенияКлиент.СообщитьПользователю("Укажите обязательное поле Город в адресе или Населенный пункт");
				Отказ = Истина;	
				Возврат;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если ЭтоДокумент Тогда 
		ОповеститьОВыборе(Новый Структура("ИмяСобытия, РезультатВыбора", "ПунктНазначенияСоздание", Объект.Ссылка));
	КонецЕсли;
	
КонецПроцедуры


#КонецОбласти

