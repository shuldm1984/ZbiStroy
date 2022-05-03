#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ

Функция ПроверитьЗаполнениеДокумента(ФактическиеОтгрузкиСсылка, СообщениеОбОшибки) Экспорт 
	
	Отказ = Ложь;	
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.Организация) Тогда 
		СообщениеОбОшибки = "Не указана Организация";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;	
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.Подразделение) Тогда 
		СообщениеОбОшибки = "Не указано Подразделение";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.Перевозчик) Тогда 
		СообщениеОбОшибки = "Не указан Перевозчик";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.Контрагент) Тогда 
		СообщениеОбОшибки = "Не указан Контрагент";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.Договор) Тогда 
		СообщениеОбОшибки = "Не указан Договор";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.Договор.Номер) Тогда 
		СообщениеОбОшибки = "Не указан № договора";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.Договор.Дата) Тогда 
		СообщениеОбОшибки = "Не указана Дата договора";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.БанковскийСчетПеревозка) Тогда 
		СообщениеОбОшибки = "Не указан Банковский счет перевозчика";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.БанковскийСчетПлательщика) Тогда 
		СообщениеОбОшибки = "Не указан Банковский счет плательщика";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.Водитель) Тогда 
		СообщениеОбОшибки = "Не указан Водитель";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.ДолжностьВодителя) Тогда 
		СообщениеОбОшибки = "Не указана должность водителя";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.ТелефонВодителя) Тогда 
		СообщениеОбОшибки = "Не указан телефон водителя";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.ПодписантПеревозчик) Тогда 
		СообщениеОбОшибки = "Не указан Подписант перевозчик";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.ПодписантЗаказчик) Тогда 
		СообщениеОбОшибки = "Не указан Подписант заказчик";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.ТранспортноеСредство) Тогда 
		СообщениеОбОшибки = "Не указано Транспортное средство";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.АвтомобильГосударственныйНомер) Тогда 
		СообщениеОбОшибки = "Не указан гос. номер";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.АвтомобильМарка) Тогда 
		СообщениеОбОшибки = "Не указана марка";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	//Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.НомерПрицепа) Тогда 
	//	СообщениеОбОшибки = "Не указан номер прицепа";
	//	Отказ = Истина;	
	//	Возврат Отказ;
	//КонецЕсли;
	//Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.МаркаПрицепа) Тогда 
	//	СообщениеОбОшибки = "Не указан марка прицепа";
	//	Отказ = Истина;	
	//	Возврат Отказ;
	//КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.СпособЗагрузки) Тогда 
		СообщениеОбОшибки = "Не указан Способ загрузки";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.ДатаЗагрузки) Тогда 
		СообщениеОбОшибки = "Не указана Дата загрузки";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.ДатаВыгрузки) Тогда 
		СообщениеОбОшибки = "Не указан Дата выгрузки";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.СтавкаФрахта) Тогда 
		СообщениеОбОшибки = "Не указана Ставка фрахта";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ФактическиеОтгрузкиСсылка.СтавкаНДС) Тогда 
		СообщениеОбОшибки = "Не указана Ставка НДС";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	
	ДокументУдостоверяющийЛичностьФизлица = ЖБИ_ОбщийМодульПечать.ДокументУдостоверяющийЛичностьФизлица(ФактическиеОтгрузкиСсылка.Водитель.Водитель, ТекущаяДатаСеанса());
	Если ДокументУдостоверяющийЛичностьФизлица.Количество()=0 Тогда 
		СообщениеОбОшибки = "Не указаны документы удостоверяющие личность Водителя";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;
	
	Если ФактическиеОтгрузкиСсылка.Товары.Количество() = 0 Тогда 
		СообщениеОбОшибки = "Не заполнены товары к отгрузке";
		Отказ = Истина;	
		Возврат Отказ;
	КонецЕсли;	
	Для Каждого НомСтр Из ФактическиеОтгрузкиСсылка.Товары Цикл
		Если НомСтр.КоличествоКОтгрузке = 0 Тогда 
			СообщениеОбОшибки = "Не указано Кол-во к отгрузке";
			Отказ = Истина;
			Возврат Отказ;
		КонецЕсли;
		Если НЕ ЗначениеЗаполнено(НомСтр.Поставщик) Тогда 
			СообщениеОбОшибки = "Не указан Поставщик";
			Отказ = Истина;
			Возврат Отказ;
		КонецЕсли;
		Если НЕ ЗначениеЗаполнено(НомСтр.Покупатель) Тогда 
			СообщениеОбОшибки = "Не указан Покупатель";
			Отказ = Истина;
			Возврат Отказ;
		КонецЕсли;
		Если НЕ ЗначениеЗаполнено(НомСтр.КонтактныеЛицаПоставщика) Тогда 
			СообщениеОбОшибки = "Не указано Контактное лицо поставщика";
			Отказ = Истина;
			Возврат Отказ;
		КонецЕсли;
		Если НЕ ЗначениеЗаполнено(НомСтр.КонтактныеЛицаПокупателя) Тогда 
			СообщениеОбОшибки = "Не указано Контактное лицо покупателя";
			Отказ = Истина;
			Возврат Отказ;
		КонецЕсли;
		Если НЕ ЗначениеЗаполнено(НомСтр.ПунктОтгрузки) Тогда 
			СообщениеОбОшибки = "Не указан Пункт отгрузки";
			Отказ = Истина;
			Возврат Отказ;
		КонецЕсли;
		Если НЕ ЗначениеЗаполнено(НомСтр.ПунктНазначения) Тогда 
			СообщениеОбОшибки = "Не указан Пункт назначения";
			Отказ = Истина;
			Возврат Отказ;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Отказ;
	
КонецФункции

Функция ЗаполнитьНомерПоПорядку(Перевозчик,ДоговорПеревозки) Экспорт
	
	НомерПоПорядку  = 0;
	//Запрос 			= Новый Запрос;
	//Запрос.УстановитьПараметр("ДокументОснование",ФактическиеОтгрузки);
	//Запрос.Текст 	= "ВЫБРАТЬ
	//             	  |	ЕСТЬNULL(МАКСИМУМ(ЖБИ_ДоговорЗаявка.НомерЗаявки),0) КАК НомерПоПорядку
	//             	  |ИЗ
	//             	  |	Документ.ЖБИ_ДоговорЗаявка КАК ЖБИ_ДоговорЗаявка
	//             	  |ГДЕ
	//             	  //|	ЖБИ_ДоговорЗаявка.ДокументОснование = &ДокументОснование
	//             	  |	НЕ ЖБИ_ДоговорЗаявка.ПометкаУдаления";
	//РезультатЗапроса = Запрос.Выполнить().Выбрать();
	//Если РезультатЗапроса.Следующий() Тогда 
	//	НомерПоПорядку = РезультатЗапроса.НомерПоПорядку;	
	//КонецЕсли;
	
	Запрос 		 = Новый Запрос;
	Запрос.УстановитьПараметр("Перевозчик",Перевозчик);	
	Запрос.УстановитьПараметр("ДоговорПеревозки",ДоговорПеревозки);
	Запрос.Текст = "ВЫБРАТЬ
					|	ЕСТЬNULL(МАКСИМУМ(ЖБИ_НумераторПоПеревозчикамСрезПоследних.НомерПоПорядку), 0) КАК НомерПоПорядку
					|ИЗ
					|	РегистрСведений.ЖБИ_НумераторПоПеревозчикам.СрезПоследних(,Партнер = &Перевозчик И ДоговорПеревозки = &ДоговорПеревозки) КАК ЖБИ_НумераторПоПеревозчикамСрезПоследних";		
	РезультатЗапроса = Запрос.Выполнить().Выбрать();
	Если РезультатЗапроса.Следующий() Тогда 
		НомерПоПорядку = РезультатЗапроса.НомерПоПорядку
	КонецЕсли;
	
	Возврат НомерПоПорядку;
	
КонецФункции

#КонецОбласти

#Область Печать

//&Перед("Печать")
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода, МассивПечатныхФорм = Неопределено) Экспорт
	
	//Печатать = УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ЖБИ_ДоговорЗаявка");	
	//Если Печатать Тогда
	//	СтруктураТипов = ОбщегоНазначенияУТ.СоответствиеМассивовПоТипамОбъектов(МассивОбъектов);
	//	СинонимМакета = НСтр("ru = 'ЖБИ - Договор заявка'");
	//	УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
	//	КоллекцияПечатныхФорм,
	//	"ЖБИ_ДоговорЗаявка",
	//	СинонимМакета,
	//	СформироватьПечатныеФормыДоговорЗаявка(МассивПечатныхФорм,ПараметрыПечати,КоллекцияПечатныхФорм, МассивОбъектов));
	//	
	//	Если МассивПечатныхФорм <> Неопределено Тогда 
	//		СформироватьПечатныеФормыДоговорЗаявка(МассивПечатныхФорм,ПараметрыПечати,КоллекцияПечатныхФорм, МассивОбъектов);	
	//	КонецЕсли;	
	//КонецЕсли;
	
КонецПроцедуры

Функция ПолучитьСписокПечатныхФорм() Экспорт
	
	СтруктураПечатныхФорм = Новый Структура;	
	СтруктураПечатныхФорм.Вставить("ЖБИ_ДоговорЗаявка", "ЖБИ - Договор заявка");
	СтруктураПечатныхФорм.Вставить("ЖБИ_Доверенность", "ЖБИ - Доверенность");
	СтруктураПечатныхФорм.Вставить("ЖБИ_ТТН", "ЖБИ - ТТН");
	
	Возврат СтруктураПечатныхФорм;
	
КонецФункции

Функция ЗаполнитьТаблицуПечатныхФорм(ДокументСсылка, ТаблицаРассылки) Экспорт 
	
	СписокПечатныхФорм 		= ПолучитьСписокПечатныхФорм();	
	АдресРассылкиПеревозчик = ЖБИ_ОбщийМодульПечать.ПолучитьЭлектроннуюПочтуИзКонтактнойИнформации(ДокументСсылка.Перевозчик);
	
	ТаблПоставщики 			= ДокументСсылка.ДокументыОтгрузки.Выгрузить(,"Поставщик,ДокументОтгрузки");
	ТаблПоставщики.Свернуть("Поставщик,ДокументОтгрузки");
	
	ДокументПечати = Документы.ЖБИ_ДоговорЗаявка.ПустаяСсылка();	
	Для Каждого НомСтр Из СписокПечатныхФорм Цикл		
		Если НомСтр.Ключ = "ЖБИ_ДоговорЗаявка" Тогда
			Для Каждого Ном Из ТаблПоставщики Цикл
				Если ТипЗнч(Ном.ДокументОтгрузки) = Тип("ДокументСсылка.ЖБИ_ДоговорЗаявка") Тогда 
					ДокументПечати 			= Ном.ДокументОтгрузки;
					ДокументПредставление 	= ДокументПечати.Договор.Номер + " - " + ДокументПечати.НомерЗаявки + "-" + ДокументПечати.Перевозчик + " " + ДокументПечати.Дата;
				КонецЕсли;
			КонецЦикла;
			Если ЗначениеЗаполнено(ДокументПечати) Тогда 
				НоваяСтр 							= ТаблицаРассылки.Добавить();
				НоваяСтр.АдресРассылки				= ЖБИ_ОбщийМодульПечать.ПолучитьЭлектроннуюПочтуИзКонтактнойИнформации(ДокументПечати.Перевозчик);
				НоваяСтр.ИмяПечатнойФормы			= НомСтр.Значение;
				НоваяСтр.ИмяПечатнойФормыСлужебное	= НомСтр.Ключ;
				НоваяСтр.Пометка					= Истина;
				НоваяСтр.Факсимиле					= Истина;
				НоваяСтр.ДокументПечати             = ДокументПечати;
				НоваяСтр.ДопИнфо					= ДокументПредставление;
			КонецЕсли;
		Иначе 
			Для Каждого Ном Из ТаблПоставщики Цикл
				Если ТипЗнч(Ном.ДокументОтгрузки) = Тип("ДокументСсылка.ЖБИ_ДоговорЗаявка") Тогда 
					Продолжить;
				КонецЕсли;
				НайденныеСтроки = ТаблицаРассылки.НайтиСтроки(Новый Структура("ДокументПечати",Ном.ДокументОтгрузки));
				Если НайденныеСтроки.Количество()>0 Тогда 
					Продолжить;
				КонецЕсли;
				НоваяСтр 							= ТаблицаРассылки.Добавить();
				НоваяСтр.АдресРассылки 				= ЖБИ_ОбщийМодульПечать.ПолучитьЭлектроннуюПочтуИзКонтактнойИнформации(Ном.Поставщик);
				НоваяСтр.ИмяПечатнойФормы			= НомСтр.Значение;
				НоваяСтр.ИмяПечатнойФормыСлужебное	= НомСтр.Ключ;
				НоваяСтр.Пометка					= Истина;
				НоваяСтр.Факсимиле					= Истина;
				НоваяСтр.ДокументПечати             = Ном.ДокументОтгрузки;
				ДокументПредставление 				= ДокументПечати.Договор.Номер + " - " + ДокументПечати.НомерЗаявки + "-" + Ном.Поставщик + " " + ДокументПечати.Дата;
				НоваяСтр.ДопИнфо					= ДокументПредставление;
				Прервать;
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;
	
	Возврат ТаблицаРассылки;
		
КонецФункции

#КонецОбласти

#Область Проведение

Процедура ИнициализироватьДанныеДокумента(ДокументСсылка, ДополнительныеСвойства, Регистры = Неопределено) Экспорт
	
	////////////////////////////////////////////////////////////////////////////
	// Создадим запрос инициализации движений
	
	Запрос = Новый Запрос;
	ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка);
	
	////////////////////////////////////////////////////////////////////////////
	// Сформируем текст запроса
	
	ТекстыЗапроса = Новый СписокЗначений;
	ТекстЗапросаПередачаВОтгрузку(Запрос, ТекстыЗапроса, Регистры);
	ПроведениеСерверУТ.ИнициализироватьТаблицыДляДвижений(Запрос, ТекстыЗапроса, ДополнительныеСвойства.ТаблицыДляДвижений, Истина);
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыИнициализации(Запрос, ДокументСсылка)
	
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ЖБИ_ФактическиеОтгрузкиТовары.Ссылка.Дата                    КАК Период,
	|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)                       КАК ВидДвижения,
	|	ЖБИ_ФактическиеОтгрузкиТовары.Ссылка.Организация             КАК Организация,
	|	ЖБИ_ФактическиеОтгрузкиТовары.Ссылка.Подразделение           КАК Подразделение,
	|	ЖБИ_ФактическиеОтгрузкиТовары.ЗаявкаПокупателя       		 КАК ЗаявкаПокупателя,
	|	ЖБИ_ФактическиеОтгрузкиТовары.ПередачаВОтгрузку         	 КАК ПередачаВОтгрузку,
	|	ЖБИ_ФактическиеОтгрузкиТовары.Номенклатура           		 КАК Номенклатура,
	|	ЖБИ_ФактическиеОтгрузкиТовары.КоличествоКОтгрузке            КАК Грузится,
	|	ЖБИ_ФактическиеОтгрузкиТовары.КоличествоОтгружено            КАК Отгружено,
	|	ЖБИ_ФактическиеОтгрузкиТовары.КодСтроки                 	 КАК КодСтроки
	|ИЗ
	|	Документ.ЖБИ_ФактическиеОтгрузки.Товары КАК ЖБИ_ФактическиеОтгрузкиТовары
	|ГДЕ
	|	ЖБИ_ФактическиеОтгрузкиТовары.Ссылка = &Ссылка
	|	И ЖБИ_ФактическиеОтгрузкиТовары.КоличествоКОтгрузке>0
	|";
	Реквизиты = Запрос.Выполнить().Выбрать();
	Реквизиты.Следующий();
	Запрос.УстановитьПараметр("Период", Реквизиты.Период);
	
КонецПроцедуры

Функция ТекстЗапросаПередачаВОтгрузку(Запрос, ТекстыЗапроса, Регистры)
	ИмяРегистра = "ЖБИ_ПередачаВОтгрузку";
	
	Если НЕ ПроведениеСерверУТ.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли; 
	
	ТекстЗапроса =
		"ВЫБРАТЬ
		|	&Период КАК Период,
		|	ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход) КАК ВидДвижения,
		|	ЖБИ_ФактическиеОтгрузкиТовары.Ссылка.Организация КАК Организация,
		|	ЖБИ_ФактическиеОтгрузкиТовары.Ссылка.Подразделение КАК Подразделение,
		|	ЖБИ_ФактическиеОтгрузкиТовары.ЗаявкаПокупателя КАК ЗаявкаПокупателя,
		|	ЖБИ_ФактическиеОтгрузкиТовары.ПередачаВОтгрузку КАК ПередачаВОтгрузку,
		|	ЖБИ_ФактическиеОтгрузкиТовары.Поставщик КАК Поставщик,
		|	ЖБИ_ФактическиеОтгрузкиТовары.Номенклатура КАК Номенклатура,
		|	ЖБИ_ФактическиеОтгрузкиТовары.НоменклатураПоставщика КАК НоменклатураПоставщика,
		|	ЖБИ_ФактическиеОтгрузкиТовары.КодСтроки КАК КодСтроки,
		|	ВЫБОР
		|		КОГДА ЖБИ_ФактическиеОтгрузкиТовары.Ссылка.Отгружено
		|			ТОГДА 0
		|		ИНАЧЕ ЖБИ_ФактическиеОтгрузкиТовары.КоличествоКОтгрузке
		|	КОНЕЦ КАК Грузится,
		|	ЖБИ_ФактическиеОтгрузкиТовары.КоличествоОтгружено КАК Отгружено
		|ИЗ
		|	Документ.ЖБИ_ФактическиеОтгрузки.Товары КАК ЖБИ_ФактическиеОтгрузкиТовары
		|ГДЕ
		|	ЖБИ_ФактическиеОтгрузкиТовары.Ссылка = &Ссылка
		|	И ЖБИ_ФактическиеОтгрузкиТовары.КоличествоКОтгрузке > 0";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	Возврат ТекстЗапроса;
	
КонецФункции

#КонецОбласти

#КонецЕсли
