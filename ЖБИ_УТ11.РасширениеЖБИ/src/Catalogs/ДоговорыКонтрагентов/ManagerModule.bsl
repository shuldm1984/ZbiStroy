#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ

Функция ЗаполнитьНомерПоПорядку() Экспорт
	
	НомерПоПорядку  = 0;
	Запрос 			= Новый Запрос;
	Запрос.Текст 	= "ВЫБРАТЬ
	             	  |	ЕСТЬNULL(МАКСИМУМ(ЖБИ_НумераторПоДоговорам.НомерПоПорядку), 0) КАК НомерПоПорядку
	             	  |ИЗ
	             	  |	РегистрСведений.ЖБИ_НумераторПоДоговорам.СрезПоследних КАК ЖБИ_НумераторПоДоговорам";
	РезультатЗапроса = Запрос.Выполнить().Выбрать();
	Если РезультатЗапроса.Следующий() Тогда 
		НомерПоПорядку = РезультатЗапроса.НомерПоПорядку + 1;	
	КонецЕсли;
	Если НомерПоПорядку = 0 Тогда
		НомерПоПорядку = 1;
	КонецЕсли;
	
	Возврат НомерПоПорядку;
	
КонецФункции
	
#КонецОбласти

&Перед("ДобавитьКомандыПечати")
Процедура ЖБИ_ДобавитьКомандыПечати(КомандыПечати)
	
	// Договор
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Идентификатор = "ЖБИ_ДоговорПоставки";
	КомандаПечати.Представление = НСтр("ru = 'ЖБИ - Договор поставки'");
	КомандаПечати.ПроверкаПроведенияПередПечатью = Истина;
	
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Идентификатор = "ЖБИ_ДоговорЗакупки";
	КомандаПечати.Представление = НСтр("ru = 'ЖБИ - Договор закупки'");
	КомандаПечати.ПроверкаПроведенияПередПечатью = Ложь;
	
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Идентификатор = "ЖБИ_Транспортировки";
	КомандаПечати.Представление = НСтр("ru = 'ЖБИ - Договор транспортировки'");
	КомандаПечати.ПроверкаПроведенияПередПечатью = Ложь;
	
КонецПроцедуры

#Область Договор

// Сформировать печатные формы объектов
//
// ВХОДЯЩИЕ:
//   ИменаМакетов    - Строка    - Имена макетов, перечисленные через запятую
//   МассивОбъектов  - Массив    - Массив ссылок на объекты которые нужно распечатать
//   ПараметрыПечати - Структура - Структура дополнительных параметров печати.
//
// ИСХОДЯЩИЕ:
//   КоллекцияПечатныхФорм - Таблица значений - Сформированные табличные документы
//   ПараметрыВывода       - Структура        - Параметры сформированных табличных документов.
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	ПечататьКарточкуЭД = УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ЖБИ_ДоговорПоставки");
	Если ПечататьКарточкуЭД Тогда
		СинонимМакета = НСтр("ru = 'ЖБИ - Договор поставки'");
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
		КоллекцияПечатныхФорм,
		"ЖБИ_ДоговорПоставки",
		СинонимМакета,
		ЖБИ_ОбщийМодульПечать.ПечатьЖБИДоговорПоставки(МассивОбъектов, ОбъектыПечати));
	КонецЕсли;
	
	ПечататьКарточкуЭД = УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ЖБИ_ДоговорЗакупки");
	Если ПечататьКарточкуЭД Тогда
		СинонимМакета = НСтр("ru = 'ЖБИ - Договор закупки'");
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
		КоллекцияПечатныхФорм,
		"ЖБИ_ДоговорЗакупки",
		СинонимМакета,
		ЖБИ_ОбщийМодульПечать.ПечатьЖБИДоговорЗакупки(МассивОбъектов, ОбъектыПечати));
	КонецЕсли;
	
	ПечататьКарточкуЭД = УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ЖБИ_Транспортировки");
	Если ПечататьКарточкуЭД Тогда
		СинонимМакета = НСтр("ru = 'ЖБИ - Договор транспортировки'");
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
		КоллекцияПечатныхФорм,
		"ЖБИ_Транспортировки",
		СинонимМакета,
		ЖБИ_ОбщийМодульПечать.ПечатьЖБИДоговорТранспортировки(МассивОбъектов, ОбъектыПечати));
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#КонецЕсли
