
#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_ЭЛЕМЕНТОВ_УПРАВЛЕНИЯ_ФОРМЫ

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_СОБЫТИЙ_ФОРМЫ

&НаКлиенте
Процедура ЖБИ_ПередЗакрытиемПосле(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если ТипЗнч(ЭтаФорма.ВладелецФормы) = Тип("ФормаКлиентскогоПриложения") Тогда 
		Если СтрНайти(ЭтаФорма.ВладелецФормы.ИмяФормы,"ЖБИ") Тогда 
			Оповестить("ФормаСозданияДоговора",Объект.Ссылка);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти