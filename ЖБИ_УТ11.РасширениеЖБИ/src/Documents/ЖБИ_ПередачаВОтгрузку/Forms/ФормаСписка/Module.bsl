

#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ

&НаКлиенте
Функция ПолучитьИмяОперации()
	
	ИмяОперации = "";
	ИмяСтраницы = Элементы.СтраницыОсновнаяФорма.ТекущаяСтраница.Имя;	
	Если ИмяСтраницы = "СтраницаДокументов" Тогда
		ИмяОперации = "СтраницаДокументов";
		Элементы.КомандаДокументы.Пометка = Истина;
	КонецЕсли;
	
	Возврат ИмяОперации;
	
КонецФункции

&НаКлиенте
Процедура УстановитьПараметрыДинамическогоСписка()

	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборПоУмолчаниюДинамическогоСписка()
	
	//ОтборМенеджер = ТекущийПользователь;
	//УстановитьОтборДинамическогоСпискаПоЭлементу(Элементы.ОтборМенеджер, "Менеджер",Неопределено);	
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборДинамическогоСпискаПоЭлементу(Элемент,ИмяОтбора,ВидСравнения)
	
	Если ЗначениеЗаполнено(ЭтотОбъект[Элемент.Имя]) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список, ИмяОтбора, ЭтотОбъект[Элемент.Имя], ВидСравнения, , );
	Иначе
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбораДинамическогоСписка(Список,ИмяОтбора);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_ЭЛЕМЕНТОВ_УПРАВЛЕНИЯ_ФОРМЫ

#Область Отборы

&НаКлиенте
Процедура ОтборМенеджерЛогистПриИзменении(Элемент)
	УстановитьОтборДинамическогоСпискаПоЭлементу(Элемент, "Менеджер",Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура ОтборСтатусПриИзменении(Элемент)
	УстановитьОтборДинамическогоСпискаПоЭлементу(Элемент, "Статус",Неопределено);
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_СОБЫТИЙ_ФОРМЫ

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступностьЭлементовФормы()
	
	
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
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
		
	УстановитьДоступностьЭлементовФормы();
	Элементы.СтраницыОсновнаяФорма.ТекущаяСтраница = Элементы.СтраницаДокументов;
	ИмяОперации = ПолучитьИмяОперации();
	
	УстановитьПараметрыДинамическогоСписка();
	УстановитьОтборПоУмолчаниюДинамическогоСписка();
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбработкаРезультатаОповещения(Результат, ДополнительныеПараметры) Экспорт
	
	РезультатВыполнения = Новый Структура("СообщениеОбОшибке","");	
	Если Результат = КодВозвратаДиалога.Отмена Тогда 
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(ДополнительныеПараметры) = Тип("Структура") Тогда 
			
	КонецЕсли;		
	
КонецПроцедуры


#КонецОбласти