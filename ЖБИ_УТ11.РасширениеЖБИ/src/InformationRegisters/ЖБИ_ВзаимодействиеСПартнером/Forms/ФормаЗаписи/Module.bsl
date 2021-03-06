
#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ 

&НаСервереБезКонтекста
Функция ПроверитьСтатусНеВРаботе(Партнер,Отказ)
	
	Результат			= Ложь;
	СтатусКонтрагента 	= Перечисления.ЖБИ_СтатусКонтрагента.ПустаяСсылка();
	Запрос 				= Новый Запрос;
	Запрос.УстановитьПараметр("Партнер",Партнер);
	Запрос.Текст 		= "ВЫБРАТЬ
	             	  		|	ЖБИ_СтатусАктивностиКлиента.СтатусКонтрагента КАК СтатусКонтрагента
	             	  		|ИЗ
	             	  		|	РегистрСведений.ЖБИ_СтатусАктивностиКлиента КАК ЖБИ_СтатусАктивностиКлиента
	             	  		|ГДЕ
	             	  		|	ЖБИ_СтатусАктивностиКлиента.Партнер = &Партнер";
	РезультаЗапроса = Запрос.Выполнить().Выбрать();
	Если РезультаЗапроса.Следующий() Тогда 
		Если РезультаЗапроса.СтатусКонтрагента = Перечисления.ЖБИ_СтатусКонтрагента.НеВРаботе Тогда
			Результат = Истина;
		КонецЕсли;
	КонецЕсли; 
	
	Если Не Результат Тогда 
		Запрос.УстановитьПараметр("Партнер",Партнер);
		Запрос.Текст 		= "ВЫБРАТЬ
		             		  |	ЖБИ_ВзаимодействиеСПартнером.Период КАК Период,
		             		  |	ЖБИ_ВзаимодействиеСПартнером.Партнер КАК Партнер
		             		  |ИЗ
		             		  |	РегистрСведений.ЖБИ_ВзаимодействиеСПартнером КАК ЖБИ_ВзаимодействиеСПартнером
		             		  |ГДЕ
		             		  |	ЖБИ_ВзаимодействиеСПартнером.Партнер = &Партнер";
		Если Запрос.Выполнить().Выбрать().Количество()=0 Тогда
			Результат = Истина; //первая запись		
		КонецЕсли;
	КонецЕсли;
	
	Если Результат Тогда
		ТаблицаНабораЗаписей 		= РегистрыСведений.ЖБИ_СтатусАктивностиКлиента.ПолучитьПустуюТаблицуНаборЗаписей();
		НоваяСтр 					= ТаблицаНабораЗаписей.Добавить();	
		НоваяСтр.Партнер 			= Партнер;
		НоваяСтр.СтатусКонтрагента	= Перечисления.ЖБИ_СтатусКонтрагента.ВПроработке;
		СообщениеОбОшибке 			= "";
		РезультатЗаписи 			= РегистрыСведений.ЖБИ_СтатусАктивностиКлиента.СоздатьОбновитьЗаписиРегистраСведений(ТаблицаНабораЗаписей,,,СообщениеОбОшибке);
		Если НЕ РезультатЗаписи Тогда 
			Отказ = Истина;
		КонецЕсли;
	КонецЕсли;
		
	Возврат Результат;		
	
КонецФункции

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_ЭЛЕМЕНТОВ_УПРАВЛЕНИЯ_ФОРМЫ

&НаКлиенте
Процедура УстановитьДоступностьЭлементовФормы()
	Элементы.НеИспользуется.Доступность = ЖБИ_ОбщийМодульДокументыСервер.ОпределитьДоступностьРоли("ЖБИ_НачальникОтделаСбыта")
												ИЛИ ЖБИ_ОбщийМодульДокументыСервер.ОпределитьДоступностьРоли("ЖБИ_НачальникОтделаЛогистики")
												ИЛИ ЖБИ_ОбщийМодульДокументыСервер.ОпределитьДоступностьРоли("ЖБИ_ОсновнаяРоль");	 
											
	ТолькоПросмотрПоля = ЗначениеЗаполнено(Запись.КонтактноеЛицо); 
	Элементы.Период.ТолькоПросмотр 					= ТолькоПросмотрПоля; 
	Элементы.Партнер.ТолькоПросмотр 				= ТолькоПросмотрПоля;
	Элементы.КонтактноеЛицо.ТолькоПросмотр 			= ТолькоПросмотрПоля;
	Элементы.Исполнитель.ТолькоПросмотр 			= ТолькоПросмотрПоля; 
	Элементы.ДатаСледующегоКонтакта.ТолькоПросмотр 	= ТолькоПросмотрПоля;
КонецПроцедуры


#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_СОБЫТИЙ_ФОРМЫ

&НаКлиенте
Процедура ПриОткрытии(Отказ)	
	УстановитьДоступностьЭлементовФормы();	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи) 	
	Если НЕ ЗначениеЗаполнено(Запись.Важность) Тогда
		Если ПроверитьСтатусНеВРаботе(Запись.Партнер, Отказ) Тогда 
			Запись.Важность = ПредопределенноеЗначение("Перечисление.ЖБИ_Важность.Высокая");
		Иначе 
			Запись.Важность = ПредопределенноеЗначение("Перечисление.ЖБИ_Важность.Низкая");
		КонецЕсли;
	КонецЕсли;  	
КонецПроцедуры

#КонецОбласти
