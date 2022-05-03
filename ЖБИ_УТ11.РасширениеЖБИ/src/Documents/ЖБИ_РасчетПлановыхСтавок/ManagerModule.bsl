#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ

Функция РасчитатьСреднююСтавкуПоДопРасходам(ТаблицаДопЗатрат) Экспорт 
	СуммаДоп = 0;
	КолСтр = 0;
	Для Каждого НомСтр Из ТаблицаДопЗатрат Цикл 
		Если НомСтр.ДопРасходыНаРейс=0 Тогда
			Продолжить;
		КонецЕсли;
		КолСтр = КолСтр + 1;
		СуммаДоп = СуммаДоп + НомСтр.ДопРасходыНаРейс;
	КонецЦикла;
	
	ДопЗатраты = ?(КолСтр = 0,0,СуммаДоп/КолСтр);	
	Возврат ДопЗатраты;	
КонецФункции

Функция ВыполнитьКомандуРасчетПлановыхСтавок(Ссылка,СообщениеОбОшибке) Экспорт 
	
	Отказ = Ложь;
	
	//1 создать маршрут
	Маршрут = Справочники.ЖБИ_Маршрут.ПустаяСсылка();
	ПунктОтгрузки = Ссылка.ПунктОтгрузки;
	ПунктНазначения = Ссылка.ПунктНазначения;
	Отказ = Справочники.ЖБИ_Маршрут.СоздатьМаршрутДляРасчетаСтавки(ПунктОтгрузки,ПунктНазначения,Маршрут,СообщениеОбОшибке);
	Если Отказ Тогда 
		Возврат Отказ;
	КонецЕсли;
	
	//2 Делаем запись в регистре ЖБИ_РасчетСтавок 
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Регистратор",Ссылка);
	СтруктураПараметров.Вставить("Период",Ссылка.Дата);
	СтруктураПараметров.Вставить("Активность",Истина);
	СтруктураПараметров.Вставить("Маршрут",Маршрут);
	СтруктураПараметров.Вставить("ВидСтавки",Перечисления.ЖБИ_ВидыСтавок.Плановая);
	СтруктураПараметров.Вставить("СрокДействияС",ТекущаяДатаСеанса());
	СтруктураПараметров.Вставить("СрокДействияПо",Ссылка.СрокДействияДата);
	СтруктураПараметров.Вставить("Негабаритный",Ссылка.Негабаритный);
	СтруктураПараметров.Вставить("Расстояние",Ссылка.Расстояние);
	СтруктураПараметров.Вставить("Сумма",Ссылка.Сумма);
	СтруктураПараметров.Вставить("Автор",Пользователи.ТекущийПользователь());
	ТаблицаНабораЗаписей = РегистрыСведений.ЖБИ_РасчетСтавок.ЗаполнитьТаблицуНабораЗаписей(СтруктураПараметров);
	
	Результат = РегистрыСведений.ЖБИ_РасчетСтавок.СоздатьОбновитьЗаписиРегистраСведений(ТаблицаНабораЗаписей,,, СообщениеОбОшибке);
	Если Не Результат Тогда
		Отказ = Истина;	
	КонецЕсли;
	
	Возврат Отказ;
		
КонецФункции

Функция ИзменитьСтатусЗаявкиПокупателяОкончательныйРасчет(ЗаявкаСсылка,ПредварРасчетСсылка,СообщениеОбОшибке) Экспорт
	
	Отказ = Ложь;	
	ОбъекЗаявка = ЗаявкаСсылка.ПолучитьОбъект();		
	
	//заполнение ставки	
	Для Каждого НомСтр Из ПредварРасчетСсылка.ДопЗатраты Цикл
		СтруктураПараметров = Новый Структура("Пометка,Поставщик,КодСтроки,Номенклатура,ПунктНазначения,ПунктОтгрузки,Негабаритный",Истина,ПредварРасчетСсылка.Партнер,НомСтр.КодСтроки,НомСтр.Номенклатура,ПредварРасчетСсылка.ПунктНазначения,ПредварРасчетСсылка.ПунктОтгрузки,НомСтр.Негабаритный);
		ЖБИ_ОбщийМодульДокументы.РасчитатьСтавкиТЧЗаявки(ОбъекЗаявка.ПредварительныйРасчет,СтруктураПараметров);
	КонецЦикла;
			
	//расчет стоимости
	ТаблРасчет = ОбъекЗаявка.ПредварительныйРасчет.Выгрузить();
	ТаблицаКонтроль = ОбъекЗаявка.КонтрольТранспорта.Выгрузить();
	//ЖБИ_ОбщийМодульДокументы.РасчитатьСтоимость(ЗаявкаСсылка,ТаблРасчет,ТаблицаКонтроль);
	//ОбъекЗаявка.ПредварительныйРасчет.Загрузить(ТаблРасчет);
	
	СтатусЗавершен = Документы.ЖБИ_ЗаявкиПокупателей.МожноПереводитьДокументНаОкончательныйРасчет(ЗаявкаСсылка, ПредварРасчетСсылка);
	Если СтатусЗавершен 
		И ЗаявкаСсылка.Статус = Перечисления.ЖБИ_СтатусЗаявкиПокупателя.ОтправленНаРасчетПлановыхСтавок Тогда 
		ОбъекЗаявка.Статус = Перечисления.ЖБИ_СтатусЗаявкиПокупателя.ОкончательныйРасчет;
		Документы.ЖБИ_ЗаявкиПокупателей.ЗаполнитьТаблицуОкончательныйРасчет(ОбъекЗаявка,ОбъекЗаявка.ПредварительныйРасчет.Выгрузить(Новый Структура("Пометка",Истина)));
	КонецЕсли;
		
	Попытка
		ОбъекЗаявка.Записать();
	Исключение
		СообщениеОбОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		Отказ = Истина;
		Возврат Отказ;
	КонецПопытки;
	
	Возврат Отказ;
	
КонецФункции

Функция ИзменитьСтатусЗаявкиПокупателяПредварительныйРасчет(ЗаявкаСсылка,ПредварРасчетСсылка,СообщениеОбОшибке) Экспорт
	
	Отказ = ЖБИ_ОбщийМодульДокументы.ОтклонитьДокументыОснованияЗаявкиПокупателя(ЗаявкаСсылка,ПредварРасчетСсылка,СообщениеОбОшибке);
	Если Отказ Тогда 
		Возврат Отказ;
	КонецЕсли;
	
	Отказ = ЖБИ_ОбщийМодульДокументы.ПеревестиЗаявкуНаПредварительныйРасчет(ЗаявкаСсылка,СообщениеОбОшибке);
	Если Отказ Тогда 
		Возврат Отказ;
	КонецЕсли;
	
	Возврат Отказ;
	
КонецФункции

Процедура ИзменитьСтатусЗаявкиПокупателяОкончательныйРасчетБезДокумента(ОбъекЗаявка) Экспорт 
	
	//расчет стоимости
	ТаблицаРасчет 		= ОбъекЗаявка.ПредварительныйРасчет.Выгрузить();
	ТаблицаКонтроль 	= ОбъекЗаявка.КонтрольТранспорта.Выгрузить();
	ЖБИ_ОбщийМодульДокументы.РасчитатьСтоимость(ОбъекЗаявка.Ссылка,ТаблицаРасчет,ТаблицаКонтроль);
	ОбъекЗаявка.Статус 	= Перечисления.ЖБИ_СтатусЗаявкиПокупателя.ОкончательныйРасчет;
	Документы.ЖБИ_ЗаявкиПокупателей.ЗаполнитьТаблицуОкончательныйРасчет(ОбъекЗаявка,ОбъекЗаявка.ПредварительныйРасчет.Выгрузить());	
	
КонецПроцедуры

#КонецОбласти

#Область Отчеты

// Определяет список команд отчетов.
//
// Параметры:
//   КомандыОтчетов - ТаблицаЗначений - Таблица с командами отчетов. Для изменения.
//       См. описание 1 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//   Параметры - Структура - Вспомогательные параметры. Для чтения.
//       См. описание 2 параметра процедуры ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов().
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
	ВводОстатковЛокализация.ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры);

КонецПроцедуры

#КонецОбласти

#КонецЕсли