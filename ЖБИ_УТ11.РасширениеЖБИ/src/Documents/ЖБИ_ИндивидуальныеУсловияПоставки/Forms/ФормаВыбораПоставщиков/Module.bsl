
#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ

&НаСервере
Процедура ЗаполнитьТаблицуПоставщиков()
	
	Запрос 			= Новый Запрос;
	Запрос.УстановитьПараметр("Сегмент", ОтборСегмент);
	Запрос.Текст	= "ВЫБРАТЬ
						|	ПартнерыСегмента.Партнер КАК Поставщик,
						|	Контрагенты.ИНН КАК ИНН,
						|	КонтактныеЛицаПартнеровПочта.Ссылка КАК КонтактноеЛицоПоставщика,
						|	КонтактныеЛицаПартнеровПочта.Представление КАК Почта, 						
						|	КонтактныеЛицаПартнеровПочта.Ссылка.ЖБИ_Главный КАК Основной
						|ИЗ
						|	РегистрСведений.ПартнерыСегмента КАК ПартнерыСегмента
						|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Контрагенты КАК Контрагенты
						|		ПО ПартнерыСегмента.Партнер = Контрагенты.Партнер	
						|	ЛЕВОЕ СОЕДИНЕНИЕ Справочник.КонтактныеЛицаПартнеров.КонтактнаяИнформация КАК КонтактныеЛицаПартнеровПочта
						|		ПО ПартнерыСегмента.Партнер = КонтактныеЛицаПартнеровПочта.Ссылка.Владелец
						|			И КонтактныеЛицаПартнеровПочта.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыКонтактнойИнформации.АдресЭлектроннойПочты)
						|			И КонтактныеЛицаПартнеровПочта.Вид = ЗНАЧЕНИЕ(Справочник.ВидыКонтактнойИнформации.EmailКонтактногоЛица)
						|ГДЕ
						|	ПартнерыСегмента.Сегмент = &Сегмент";
	РезультатЗапроса = Запрос.Выполнить().Выгрузить();
	Для Каждого НомСтр Из РезультатЗапроса Цикл
		НоваяСтр = ТаблицаПоставщиков.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтр,НомСтр);
	КонецЦикла;	
	
КонецПроцедуры

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_ЭЛЕМЕНТОВ_УПРАВЛЕНИЯ_ФОРМЫ

#Область Отборы

#КонецОбласти

#Область Команды

&НаКлиенте
Процедура КомандаВыборПоставщиков(Команда)
	МассивВыбора = Новый Массив;
	Для Каждого НомСтр Из ТаблицаПоставщиков Цикл
		Если НЕ НомСтр.Выбор Тогда
			Продолжить;
		КонецЕсли;
		МассивВыбора.Добавить(Новый Структура("Партнер,Почта",НомСтр.Поставщик,НомСтр.Почта));	
	КонецЦикла;
	ОповеститьОВыборе(Новый Структура("ФормаВыбораПоставщиков", МассивВыбора));	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_СОБЫТИЙ_ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если НЕ Параметры.Свойство("Сегмент") Тогда 
		Возврат;
	КонецЕсли;
	
	ОтборСегмент = Параметры.Сегмент;
	ЗаполнитьТаблицуПоставщиков();
	
КонецПроцедуры

#КонецОбласти