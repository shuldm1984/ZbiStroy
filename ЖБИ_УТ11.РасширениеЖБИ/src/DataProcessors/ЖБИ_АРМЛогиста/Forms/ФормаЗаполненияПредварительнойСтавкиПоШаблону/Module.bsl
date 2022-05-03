
#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ

&НаСервереБезКонтекста
Функция ЗаполнитьРегионПоШаблонуСервер(ДопПараметры, СообщениеОбОшибке)	
	
	ТаблицаНабораЗаписей = РегистрыСведений.ЖБИ_РасчетПредварительныхСтавок.ПолучитьПустуюТаблицуНаборЗаписей();	
	МакетРегион = Обработки.ЖБИ_АРМЛогиста.ПолучитьМакет("МакетПредварительныхСтавокПоРегионамИГородам");	
	Для Счетчик = 2 По МакетРегион.ВысотаТаблицы Цикл
		
		Регион 	= СокрЛП(МакетРегион.Область(Счетчик, 1, Счетчик, 1).Текст);
		Город 	= СокрЛП(МакетРегион.Область(Счетчик, 2, Счетчик, 2).Текст); 
		
		НоваяСтр = ТаблицаНабораЗаписей.Добавить();
		НоваяСтр.ПунктОтгрузки 		= ДопПараметры.ПунктОтгрузки;
		НоваяСтр.Регион 			= Регион;
		НоваяСтр.Город 				= Город;
		НоваяСтр.Расстояние 		= 0;
		НоваяСтр.Ставка 			= 0;
		НоваяСтр.Автор 				= Пользователи.ТекущийПользователь();
		НоваяСтр.ДатаОбновления 	= ТекущаяДатаСеанса();		
	КонецЦикла;
	
	РезультатЗаписи = РегистрыСведений.ЖБИ_РасчетПредварительныхСтавок.СоздатьОбновитьЗаписиРегистраСведений(ТаблицаНабораЗаписей,,, СообщениеОбОшибке);
	
	Возврат РезультатЗаписи;
	
КонецФункции

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_ЭЛЕМЕНТОВ_УПРАВЛЕНИЯ_ФОРМЫ

&НаКлиенте
Процедура КомандаЗаполнитьРегионПоШаблону(Команда)
	
	Текст = "Заполнить для поставщика "+Партнер+" регионы по шаблону?";
	СтруктураПраметров = Новый Структура("ПунктОтгрузки",ПунктОтгрузки);
	СтруктураСобытия = Новый Структура("ИмяСобытия, ДопПараметры","ЗаполнитьРегионПоШаблону",СтруктураПраметров);
	ОписаниеОповещения = Новый ОписаниеОповещения("Подключаемый_ОбработкаРезультатаОповещения", ЭтаФорма, СтруктураСобытия);
	ПоказатьВопрос(ОписаниеОповещения,Текст,РежимДиалогаВопрос.ДаНет,15);
	
КонецПроцедуры

&НаКлиенте
Процедура ПунктОтгрузкиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОткрытьФорму("РегистрСведений.ЖБИ_ПунктыНазначенияОтгрузки.Форма.ФормаВыбора",
	Новый Структура("Партнер",Партнер),
	ЭтаФорма,,,,
	Новый ОписаниеОповещения("Подключаемый_ОбработкаРезультатаОповещения", ЭтаФорма, "ФормаВыбораПунктОтгрузки"));
	
КонецПроцедуры

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_СОБЫТИЙ_ФОРМЫ

&НаКлиенте
Процедура Подключаемый_ОбработкаРезультатаОповещения(Результат, ДополнительныеПараметры) Экспорт
	
	РезультатВыполнения = Новый Структура("СообщениеОбОшибке","");	
	Если Результат = КодВозвратаДиалога.Отмена Тогда 
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(ДополнительныеПараметры) = Тип("Структура") Тогда 
		Если ДополнительныеПараметры.Свойство("ИмяСобытия")
			И ЗначениеЗаполнено(ДополнительныеПараметры.ИмяСобытия) Тогда
			Если ДополнительныеПараметры.ИмяСобытия = "ЗаполнитьРегионПоШаблону" Тогда			
				Если Результат = КодВозвратаДиалога.Нет ИЛИ Результат = КодВозвратаДиалога.Отмена Тогда
					Возврат;
				КонецЕсли;	
				ДопПараметры 		= ДополнительныеПараметры.ДопПараметры;
				СообщениеОбОшибки 	= "";
				РезультатЗаписи 	= ЗаполнитьРегионПоШаблонуСервер(ДопПараметры, СообщениеОбОшибки);
				Если Не РезультатЗаписи Тогда 
					ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибки);
				Иначе 
					ОбщегоНазначенияКлиент.СообщитьПользователю("Регионы для поставщика "+Партнер+" обновлены");
				КонецЕсли;			
			КонецЕсли;	
		КонецЕсли;
	КонецЕсли;
	
	Если ДополнительныеПараметры = "ФормаВыбораПунктОтгрузки" Тогда
		ПунктОтгрузки = Результат;		
	КонецЕсли;
			
КонецПроцедуры

#КонецОбласти