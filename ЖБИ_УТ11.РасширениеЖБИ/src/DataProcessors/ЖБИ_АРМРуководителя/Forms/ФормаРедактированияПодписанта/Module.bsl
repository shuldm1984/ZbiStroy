  
 #Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ
 
 &НаСервереБезКонтекста
Функция СоздатьОбновитьЗаписиРегистраПраваНастройки(Организация,ПравоПодписи,ОтветственныйСотрудник,СообщениеОбОшибке)
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Объект",Организация);
	СтруктураПараметров.Вставить("ПравоНастройка",ПравоПодписи);
	СтруктураПараметров.Вставить("Значение",ОтветственныйСотрудник);
	СтруктураПараметров.Вставить("Автор",Пользователи.ТекущийПользователь());
	ТаблицаНабораЗаписей = РегистрыСведений.ЖБИ_ПраваНастройки.ЗаполнитьТаблицуНабораЗаписей(СтруктураПараметров);
	
	Результат = РегистрыСведений.ЖБИ_ПраваНастройки.СоздатьОбновитьЗаписиРегистраСведений(ТаблицаНабораЗаписей,,, СообщениеОбОшибке);
	Если Не Результат Тогда 
		Возврат Результат;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура ПравоПодписиНачалоВыбораСервер(ДанныеВыбора) 
	
	ДанныеВыбора = Новый СписокЗначений; 	
	Запрос 		 = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ЖБИ_ПраваНастройки.Ссылка КАК Ссылка
	               |ИЗ
	               |	ПланВидовХарактеристик.ЖБИ_ПраваНастройки КАК ЖБИ_ПраваНастройки
	               |ГДЕ
	               |	ЖБИ_ПраваНастройки.СлужебныйКод = 100";
	РезультатЗапроса = Запрос.Выполнить().Выбрать();
	Пока РезультатЗапроса.Следующий() Цикл 
		ДанныеВыбора.Добавить(РезультатЗапроса.Ссылка);	
	КонецЦикла;

КонецПроцедуры
 
 #КонецОбласти
 
 #Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_ЭЛЕМЕНТОВ_УПРАВЛЕНИЯ_ФОРМЫ
 
&НаКлиенте
Процедура ПравоПодписиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка) 
		
	СтандартнаяОбработка = Ложь;
	ПравоПодписиНачалоВыбораСервер(ДанныеВыбора);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаЗаписатьИЗакрыть(Команда) 
	
	Если Не ЗначениеЗаполнено(Организация) Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю("Не заполнено поле Организация");
		Возврат;
	КонецЕсли; 
	Если Не ЗначениеЗаполнено(ПравоПодписи) Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю("Не заполнено поле Право подписи");
		Возврат;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ОтветственныйСотрудник) Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю("Ответственный сотрудник");
		Возврат;
	КонецЕсли;
	
	СообщениеОбОшибке = "";
	Результат = СоздатьОбновитьЗаписиРегистраПраваНастройки(Организация,ПравоПодписи,ОтветственныйСотрудник,СообщениеОбОшибке);
	Если Не Результат Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибке);	
	КонецЕсли;	
	
	ОповеститьОВыборе(Результат);

КонецПроцедуры

 #КонецОбласти


#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_СОБЫТИЙ_ФОРМЫ

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
	КонецЕсли  
	
КонецПроцедуры 

#КонецОбласти
