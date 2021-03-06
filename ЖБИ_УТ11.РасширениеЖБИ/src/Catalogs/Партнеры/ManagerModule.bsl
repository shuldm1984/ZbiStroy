
&После("ОбработкаПолученияДанныхВыбора")
Процедура ЖБИ_ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	Если ДанныеВыбора = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	Если ДанныеВыбора.Количество()=0 Тогда
		Возврат;
	КонецЕсли;
	ИндексПоследнего = ДанныеВыбора.Количество() - 1;
	Для Индекс = 0 По ИндексПоследнего Цикл 
		Если ТипЗнч(ДанныеВыбора[ИндексПоследнего - Индекс].Значение) = Тип("Структура")
			И ДанныеВыбора[ИндексПоследнего - Индекс].Значение.Свойство("ПометкаУдаления") Тогда  
			ДанныеВыбора.Удалить(ИндексПоследнего - Индекс);	
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры
