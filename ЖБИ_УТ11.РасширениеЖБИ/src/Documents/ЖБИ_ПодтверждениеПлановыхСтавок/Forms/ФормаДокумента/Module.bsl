
#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ

&НаСервере
Процедура ПроверитьСтатусВРаботе()
	Если Объект.Статус = Перечисления.ЖБИ_СтатусРасчетаСтавки.Расчет Тогда
		Объект.Статус = Перечисления.ЖБИ_СтатусРасчетаСтавки.ВРаботе;
		Записать();	
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформлениеТЧ(ИмяТаблицы,Свойство,ЗначениеСвойства,СписокКолонокИсключение)

	//УсловноеОформление.Элементы.Очистить();
	ЭлементУсловногоОформления = УсловноеОформление.Элементы.Добавить();
	ЭлементУсловногоОформления.Использование = Истина;
	ОформлениеУО        = ЭлементУсловногоОформления.Оформление;
	ОтборУО             = ЭлементУсловногоОформления.Отбор;
	ОформляемыеПоляУО   = ЭлементУсловногоОформления.Поля;
	Если ИмяТаблицы = "ТаблицаТовары" Тогда 		
		ОформлениеУО.УстановитьЗначениеПараметра(Свойство, ЗначениеСвойства);
		Для Каждого НомСтр Из Элементы[ИмяТаблицы].ПодчиненныеЭлементы Цикл
			ИмяКолонки = НомСтр.Имя;
			ОформляемоеПоле      = ОформляемыеПоляУО.Элементы.Добавить();
			ОформляемоеПоле.Поле = Новый ПолеКомпоновкиДанных(ИмяКолонки);
		КонецЦикла;		
	КонецЕсли;
	
	ОформляемоеПоле.Использование = Истина;
    
КонецПроцедуры

&НаКлиенте
Процедура ОпределитьДоступностьСтраницыПоСтатусу()

	Если Объект.Статус = ПредопределенноеЗначение("Перечисление.ЖБИ_СтатусРасчетаСтавки.Рассчитан")
		ИЛИ Объект.Статус = ПредопределенноеЗначение("Перечисление.ЖБИ_СтатусРасчетаСтавки.НеСогласован") Тогда  
		ЭтаФорма.ТолькоПросмотр = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОпределитьДоступностьКомандПоСтатусу()
	
	Если Объект.Статус = ПредопределенноеЗначение("Перечисление.ЖБИ_СтатусРасчетаСтавки.Рассчитан")
		ИЛИ Объект.Статус = ПредопределенноеЗначение("Перечисление.ЖБИ_СтатусРасчетаСтавки.НеСогласован") Тогда 
		Элементы.ФормаКомандаПлановаяСтавкаРассчитана.Доступность = Ложь;
		Элементы.ФормаКомандаОтклонить.Доступность = Ложь;
	Иначе 
		Элементы.ФормаКомандаПлановаяСтавкаРассчитана.Доступность = Истина;
		Элементы.ФормаКомандаОтклонить.Доступность = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОпределитьДоступностьЭлементовФормы()
	
	УстановитьУсловноеОформлениеТЧ("ТаблицаТовары","ТолькоПросмотр",Ложь,Новый СписокЗначений);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЭлементыФормыИнформацию()
	
	//Доступность страницы
	ОпределитьДоступностьСтраницыПоСтатусу();
	
	//Доступность команд
	ОпределитьДоступностьКомандПоСтатусу();
	
	//Доступность элементов формы
	ОпределитьДоступностьЭлементовФормы();
	
КонецПроцедуры

#КонецОбласти
	

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_ЭЛЕМЕНТОВ_УПРАВЛЕНИЯ_ФОРМЫ

#Область Команды

&НаКлиенте
Процедура КомандаЗаписатьДокумент(Команда)	
	Если Не ПроверитьЗаполнение() Тогда 
		Возврат;
	КонецЕсли;
	ОбщегоНазначенияУТКлиент.Записать(ЭтаФорма, Истина);	
КонецПроцедуры

&НаКлиенте
Функция ПроверитьИзменениеСтатуса(СообщениеОбОшибки)
	
	Отказ = Ложь;	
	Если ПустаяСтрока(Объект.ПримечаниеСогласования) Тогда 
		Отказ = Истина;
		СообщениеОбОшибки = "Не заполнено поле <Примечание согласования>";
		Возврат Отказ;
	КонецЕсли;
	
	Возврат Отказ;
	
КонецФункции

&НаСервере
Функция ИзменитьСтатусЗаявкиПокупателяПодтверждениеЛогистами(ЗаявкаСсылка,СсылкаПодтверждение,Согласование,СообщениеОбОшибки)
	
	НачатьТранзакцию();	
	Отказ = Документы.ЖБИ_ПодтверждениеПлановыхСтавок.ИзменитьСтатусЗаявкиПодтверждениеЛогистами(ЗаявкаСсылка,СсылкаПодтверждение,Согласование,СообщениеОбОшибки);
	ЗафиксироватьТранзакцию();
	
	Возврат Отказ;
	
КонецФункции

&НаКлиенте
Процедура ВыполнитьСогласование(Согласование)
	
	СообщениеОбОшибки = "";
	Сообщение = Новый СообщениеПользователю;
	Отказ = ПроверитьИзменениеСтатуса(СообщениеОбОшибки);
	Если Отказ Тогда
		Сообщение.Текст = СообщениеОбОшибки;
		Сообщение.Сообщить();
		Возврат;
	КонецЕсли;

	Отказ = ИзменитьСтатусЗаявкиПокупателяПодтверждениеЛогистами(Объект.ДокументОснование,Объект.Ссылка,Согласование,СообщениеОбОшибки);
	Если Не Отказ Тогда 
		Объект.Статус = ПредопределенноеЗначение("Перечисление.ЖБИ_СтатусРасчетаСтавки.Рассчитан");
	КонецЕсли;
	
	Если Согласование Тогда
		Объект.Согласовано = Согласование;
	КонецЕсли;
	
	Записать();
	Сообщение.Текст = "Документ "+?(Согласование,"согласован","не согласован");;
	Сообщение.Сообщить();
	
	ОбновитьЭлементыФормыИнформацию();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьВопросСогласования(Команда)	
	
	Согласование = Ложь;
	Если Команда.Имя = "КомандаСогласовать" Тогда 
		Согласование = Истина;
	КонецЕсли;
	
	Текст = ?(Согласование, "Согласовать ставку?","Отклонить ставку?");
	СтруктураСобытия = Новый Структура("ИмяСобытия,Согласование","ВопросВыполнитьСогласование",Согласование);
	ОписаниеОповещения = Новый ОписаниеОповещения("Подключаемый_ОбработкаРезультатаОповещения", ЭтаФорма, СтруктураСобытия);
	ПоказатьВопрос(ОписаниеОповещения,Текст,РежимДиалогаВопрос.ДаНет,15);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаСогласовать(Команда)	
	ПоказатьВопросСогласования(Команда);	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтклонить(Команда)	
	ПоказатьВопросСогласования(Команда);	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьЧат(Команда)	
	ЖБИ_ОбщийМодульДокументы.ПоказатьДиалогДобавленияКомментарияВЧат(ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЧат(Команда)		
	ЖБИ_ОбщийМодульДокументы.ОбновитьЧат(ЭтаФорма);	
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура РасчитатьСтоимостьДопРасходыВсего()	
	Объект.СуммаЗатратНаПеревозку = (Объект.УкрупненнаяСтавка*Объект.КоличествоТранспорта)+Объект.ДопЗатратыНаХвост+Объект.ДопЗатратыНаМатериалы;	
КонецПроцедуры

&НаКлиенте
Процедура РасчитатьСтоимостьДопРасходовНаХвост()	
	Объект.ДопЗатратыНаХвост = Объект.ДопРасходы*Объект.КоличествоТранспорта;
КонецПроцедуры

&НаКлиенте
Процедура ДопРасходыПриИзменении(Элемент)	
	//РасчитатьСтоимостьДопРасходовНаХвост();
	//РасчитатьСтоимостьДопРасходыВсего();
КонецПроцедуры

&НаКлиенте
Процедура РасчитатьСтоимостьДопРасходов()	
	Объект.ДопРасходы = ?(Объект.КоличествоТранспорта=0,0,Объект.ДопЗатратыНаХвост/Объект.КоличествоТранспорта);
КонецПроцедуры

&НаКлиенте
Процедура ДопРасходыНаХвостПриИзменении(Элемент)	
	//РасчитатьСтоимостьДопРасходов();
	РасчитатьСтоимостьДопРасходыВсего();
КонецПроцедуры

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_СОБЫТИЙ_ФОРМЫ

&НаСервере
Процедура УстановитьПараметрыДинамическогоСписка()
	
	ОбщегоНазначенияКлиентСервер.УстановитьПараметрДинамическогоСписка(ТаблицаТовары,
	"Ссылка",
	Объект.Ссылка);
		
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ТипЗнч(ЭтаФорма.Параметры) = Тип("ДанныеФормыСтруктура") Тогда
		Для Каждого Реквизит Из ЭтаФорма.ПолучитьРеквизиты() Цикл
			Если ЭтаФорма.Параметры.Свойство(Реквизит.Имя) Тогда
				ЭтаФорма[Реквизит.Имя] = ЭтаФорма.Параметры[Реквизит.Имя];
			КонецЕсли;	
		КонецЦикла;	
	Иначе
		Возврат;
	КонецЕсли;
	
	// Обработчик подсистемы "Свойства"
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Объект", Объект);
	ДополнительныеПараметры.Вставить("ПроизвольныйОбъект", Истина);
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтаФорма, ДополнительныеПараметры);
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	УстановитьПараметрыДинамическогоСписка();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьЭлементыФормыИнформацию();
	ПроверитьСтатусВРаботе();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)	
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбработкаРезультатаОповещения(Результат, ДополнительныеПараметры) Экспорт
	
	РезультатВыполнения = Новый Структура("СообщениеОбОшибке","");	
	Если Результат = КодВозвратаДиалога.Отмена Тогда 
		Возврат;
	КонецЕсли;
		
	Если ТипЗнч(ДополнительныеПараметры) = Тип("Структура") Тогда 
		Если ДополнительныеПараметры.Свойство("ИмяСобытия")
			И ЗначениеЗаполнено(ДополнительныеПараметры.ИмяСобытия) Тогда
			Если ДополнительныеПараметры.ИмяСобытия = "ВопросВыполнитьСогласование" Тогда
				Если Результат = КодВозвратаДиалога.Нет ИЛИ Результат = КодВозвратаДиалога.Отмена Тогда
					Возврат;
				КонецЕсли;				
				ВыполнитьСогласование(ДополнительныеПараметры.Согласование);
			ИначеЕсли ДополнительныеПараметры.ИмяСобытия = "ДобавитьКомментарийВЧат" Тогда
				Если Результат = Неопределено Тогда
					Возврат;
				КонецЕсли;
				ЖБИ_ОбщийМодульДокументы.ДобавитьКомментарийВЧат(ЭтаФорма, Результат);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
