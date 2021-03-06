
#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ

&НаСервере
Процедура ЗаполнитьКомплектыПоНомеклатуре(Комплект, ТаблицаНабораЗаписей, ТаблицаКомплектов)
	
	Для Каждого НомСтр Из ТаблицаКомплектов Цикл
		НоваяСтр = ТаблицаНабораЗаписей.Добавить();
		Если Комплект = НомСтр.Комплект Тогда 
			НоваяСтр.Номенклатура 	= НомСтр.Комплект;
			НоваяСтр.Комплект 		= Запись.Номенклатура;
			НоваяСтр.Количество 	= НомСтр.Количество;
			НоваяСтр.Автор			= НомСтр.Автор;
			Продолжить;
		КонецЕсли;
		НоваяСтр.Номенклатура 	= Комплект;
		НоваяСтр.Комплект 		= НомСтр.Комплект;
		НоваяСтр.Количество 	= НомСтр.Количество;
		НоваяСтр.Автор			= НомСтр.Автор;	
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьКомплектующиеСервер()
	
	//Продублируем запись для комплекта
	ТаблицаНабораЗаписей = РегистрыСведений.ЖБИ_Комплектующие.ПолучитьПустуюТаблицуНаборЗаписей();
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Номенклатура",Запись.Номенклатура);
	Запрос.Текст = "ВЫБРАТЬ
	               |	ЖБИ_Комплектующие.Комплект КАК Комплект,
	               |	ЖБИ_Комплектующие.Количество КАК Количество,
	               |	ЖБИ_Комплектующие.Автор КАК Автор
	               |ИЗ
	               |	РегистрСведений.ЖБИ_Комплектующие КАК ЖБИ_Комплектующие
	               |ГДЕ
	               |	ЖБИ_Комплектующие.Номенклатура = &Номенклатура";
	
	ТаблицаКомплектов 	= Запрос.Выполнить().Выгрузить();
	РезультатЗапроса 	= Запрос.Выполнить().Выбрать();
	Пока РезультатЗапроса.Следующий() Цикл 		
		СообщениеОбОшибки = "";
		ЗаполнитьКомплектыПоНомеклатуре(РезультатЗапроса.Комплект, ТаблицаНабораЗаписей, ТаблицаКомплектов);		
	КонецЦикла;
	
	Результат = РегистрыСведений.ЖБИ_Комплектующие.СоздатьОбновитьЗаписиРегистраСведений(ТаблицаНабораЗаписей,,,СообщениеОбОшибки);
	Если Не Результат Тогда
		Отказ = Истина;	
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СообщениеОбОшибки);
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_СОБЫТИЙ_ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Запись.Количество 	= 1;
	Запись.Автор 		= Пользователи.ТекущийПользователь();	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	ЗаписатьКомплектующиеСервер();
КонецПроцедуры

#КонецОбласти

