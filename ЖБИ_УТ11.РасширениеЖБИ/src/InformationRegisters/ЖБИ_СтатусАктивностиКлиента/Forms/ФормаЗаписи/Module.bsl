
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если ТипЗнч(Параметры) = Тип("ДанныеФормыСтруктура") Тогда
		Если Параметры.Свойство("Партнер")
			И ЗначениеЗаполнено(Параметры.Партнер) Тогда
			Запись.Партнер = Параметры.Партнер;
		КонецЕсли;
		Если Параметры.Свойство("СтатусКонтрагента")
			И ЗначениеЗаполнено(Параметры.СтатусКонтрагента) Тогда
			Запись.СтатусКонтрагента = Параметры.СтатусКонтрагента;
		КонецЕсли;
		Если Параметры.Свойство("Автор")
			И ЗначениеЗаполнено(Параметры.Автор) Тогда
			Запись.Автор = Параметры.Автор;
		КонецЕсли;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Запись.Партнер) Тогда 
		Запись.Автор = Пользователи.ТекущийПользователь();
	КонецЕсли;
	
КонецПроцедуры
