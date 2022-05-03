
#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ

Функция ПолучитьПустуюТаблицуНаборЗаписей() Экспорт
	
	НаборЗаписей 		= РегистрыСведений.ЖБИ_ГрадацияЦенПредварительныхСтавок.СоздатьНаборЗаписей();	
	Табл 				= НаборЗаписей.ВыгрузитьКолонки();
	
	Возврат Табл;
	
КонецФункции

Функция ЗаполнитьТаблицуНабораЗаписей(СтруктураПараметров) Экспорт 
	
	ТаблицаНабораЗаписей = ПолучитьПустуюТаблицуНаборЗаписей();
	НоваяСтр = ТаблицаНабораЗаписей.Добавить();
	ЗаполнитьЗначенияСвойств(НоваяСтр,СтруктураПараметров);
	
	Возврат ТаблицаНабораЗаписей;
	
КонецФункции

Функция СоздатьОбновитьЗаписиРегистраСведений(ТаблицаНабораЗаписей,СписокСвойствОбновления,СтруктураПоиска = Неопределено,СообщениеОбОшибке) Экспорт
	
	Для Каждого СтрокаНабораЗаписей Из ТаблицаНабораЗаписей Цикл	
		
		НаборЗаписей = РегистрыСведений.ЖБИ_ГрадацияЦенПредварительныхСтавок.СоздатьНаборЗаписей();
		
		Отбор = НаборЗаписей.Отбор; 
		Отбор.Партнер.Установить(СтрокаНабораЗаписей.Партнер);
		Отбор.РасстояниеОт.Установить(СтрокаНабораЗаписей.РасстояниеОт);
		Отбор.РасстояниеДо.Установить(СтрокаНабораЗаписей.РасстояниеДо);
		Если СтруктураПоиска<>Неопределено Тогда
			Для Каждого Ном Из СтруктураПоиска Цикл 
				Отбор[Ном.Ключ].Установить(Ном.Значение);	
			КонецЦикла;
		КонецЕсли;		
		НаборЗаписей.Прочитать();	
		Если НаборЗаписей.Количество() > 0 Тогда
			Для Каждого Запись Из НаборЗаписей Цикл				
				Если СписокСвойствОбновления = Неопределено Тогда 
					ЗаполнитьЗначенияСвойств(Запись, СтрокаНабораЗаписей);
				Иначе
					ЗаполнитьЗначенияСвойств(Запись, СтрокаНабораЗаписей, СписокСвойствОбновления);
				КонецЕсли;		
			КонецЦикла;		
			Попытка
				НаборЗаписей.Записать(Истина);
			Исключение
				СообщениеОбОшибке = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
				Прервать;
			КонецПопытки;;
		Иначе 
			МенеджерЗаписи = РегистрыСведений.ЖБИ_ГрадацияЦенПредварительныхСтавок.СоздатьМенеджерЗаписи();
			ЗаполнитьЗначенияСвойств(МенеджерЗаписи,СтрокаНабораЗаписей);			
			Попытка
				МенеджерЗаписи.Записать(Истина);
			Исключение
				СообщениеОбОшибке = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
				Прервать;
			КонецПопытки;
		КонецЕсли;
	КонецЦикла;	
								
	Возврат ?(ПустаяСтрока(СообщениеОбОшибке),Истина,Ложь);
	
КонецФункции

#КонецОбласти