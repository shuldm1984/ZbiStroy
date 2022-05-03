
Процедура РассчитатьСуммуВсего()
	
	СуммаДокумента = 0;
	Если ОкончательныйРасчет.Количество()>0 Тогда 
		Для Каждого НомСтр Из ОкончательныйРасчет Цикл 
			Если Не НомСтр.Пометка Тогда 
				Продолжить;
			КонецЕсли;
			СуммаДокумента = СуммаДокумента + НомСтр.Сумма;	
		КонецЦикла
	Иначе 
		Для Каждого НомСтр Из ПредварительныйРасчет Цикл 
			Если Не НомСтр.Пометка Тогда 
				Продолжить;
			КонецЕсли;
			СуммаДокумента = СуммаДокумента + НомСтр.Сумма;	
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка = Истина Тогда 
		Возврат;
	КонецЕсли;
	
	Если РежимЗаписи=РежимЗаписиДокумента.Запись И НЕ ПометкаУдаления Тогда	
		РежимЗаписи = РежимЗаписиДокумента.Проведение;
	КонецЕсли;
	
	РассчитатьСуммуВсего();
	Если Статус = Перечисления.ЖБИ_СтатусЗаявкиПокупателя.ОкончательныйРасчет Тогда
		ТаблРасчет 		= ОкончательныйРасчет.Выгрузить();
		ТаблицаКонтроль = КонтрольТранспорта.Выгрузить();
		ЖБИ_ОбщийМодульДокументы.РасчитатьСтоимость(Ссылка,ТаблРасчет,ТаблицаКонтроль);
		ОкончательныйРасчет.Загрузить(ТаблРасчет);
	КонецЕсли;
	
	Если Ссылка.Статус <> ЭтотОбъект.Статус Тогда 
		Результат = РегистрыСведений.ЖБИ_ЖурналСостоянийДокументов.ЗаполнитьЖурналСостоянийОбъектов(Ссылка,ЭтотОбъект.Статус);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.ЖБИ_ЗаявкиПокупателей") Тогда
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, ДанныеЗаполнения);
		ЭтотОбъект.УстановитьНовыйНомер();
		ЭтотОбъект.Дата = ТекущаяДатаСеанса();
		ЭтотОбъект.ДокументОснование = ДанныеЗаполнения.Ссылка;
		Товары.Загрузить(ДанныеЗаполнения.Товары.Выгрузить());
		Для Каждого НомСтр Из Товары Цикл 
			НомСтр.Выбрано 						= Ложь;
		КонецЦикла;

		ПредварительныйРасчет.Загрузить(ДанныеЗаполнения.ПредварительныйРасчет.Выгрузить());
		Для Каждого НомСтр Из ПредварительныйРасчет Цикл
			НомСтр.Пометка 						= Ложь;
			НомСтр.ИндивидуальнаяЦена 			= Ложь;
			НомСтр.Цена 						= 0;
			НомСтр.ЦенаПоставщика 				= 0;
			НомСтр.Сумма 						= 0;
			НомСтр.ПредварительнаяСтавка		= 0;
			НомСтр.УкрупненнаяСтавка			= 0;
			НомСтр.ДопЗатратыНаМатериалы		= 0;
			НомСтр.ЗатратыНаТранспортировку 	= 0;
			НомСтр.СогласнованноеКоличествоАМ 	= 0;
			НомСтр.ДопЗатрНаХвост 				= 0;
			
			СтруктураПараметров = Новый Структура("КодСтроки,Поставщик,Номенклатура,Негабаритный,ПунктНазначения",НомСтр.КодСтроки,НомСтр.Поставщик,НомСтр.Номенклатура,НомСтр.Негабаритный,ПунктНазначения);
			ЖБИ_ОбщийМодульДокументы.РасчитатьСтавкиТЧЗаявки(ПредварительныйРасчет,СтруктураПараметров);
			ЖБИ_ОбщийМодульДокументы.РасчитатьПредварительныеСтавкиТЧЗаявки(ПредварительныйРасчет,СтруктураПараметров);
			ЖБИ_ОбщийМодульДокументы.РасчитатьЦенуПоставщикаСервер(НомСтр);
		КонецЦикла;
		ТаблРасчет 		= ПредварительныйРасчет.Выгрузить();
		ТаблицаКонтроль = КонтрольТранспорта.Выгрузить();
		ЖБИ_ОбщийМодульДокументы.РасчитатьСтоимость(ЭтотОбъект,ТаблРасчет,ТаблицаКонтроль);
		ПредварительныйРасчет.Загрузить(ТаблРасчет);
		ОкончательныйРасчет.Очистить();
		КонтрольТранспорта.Очистить();
		Документы.Очистить();
		Статус = Перечисления.ЖБИ_СтатусЗаявкиПокупателя.Новый;	
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Партнеры") Тогда 		
		ЭтотОбъект.Партнер = ДанныеЗаполнения;		
	КонецЕсли;
	
КонецПроцедуры
