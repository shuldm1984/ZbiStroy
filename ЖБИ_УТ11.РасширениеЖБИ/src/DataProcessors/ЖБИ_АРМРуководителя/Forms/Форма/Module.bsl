
#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ

&НаКлиенте
Функция ПолучитьИмяОперации()
	
	ИмяОперации = "";
	ИмяСтраницы = Элементы.СтраницыОсновнаяФорма.ТекущаяСтраница.Имя;	
	Если ИмяСтраницы = "СтраницаПоставщиков" Тогда
		ИмяОперации = "КомандаТаблицаПоставщиков";
		Элементы.КомандаТаблицаПоставщиков.Пометка = Истина;
		Элементы.КомандаНастройкаЦеннобразованияПоРегионам.Пометка = Ложь;
		Элементы.КомандаНастройкаПодписантов.Пометка = Ложь;
	ИначеЕсли ИмяСтраницы = "СтраницаЦеннобразованиеПоРегионам" Тогда
		ИмяОперации = "КомандаНастройкаЦеннобразованияПоРегионам";
		Элементы.КомандаТаблицаПоставщиков.Пометка = Ложь;
		Элементы.КомандаНастройкаЦеннобразованияПоРегионам.Пометка = Истина; 
		Элементы.КомандаНастройкаПодписантов.Пометка = Ложь;
	ИначеЕсли ИмяСтраницы = "СтраницаПодписантов" Тогда
		ИмяОперации = "СтраницаПодписантов";
		Элементы.КомандаТаблицаПоставщиков.Пометка = Ложь;
		Элементы.КомандаНастройкаЦеннобразованияПоРегионам.Пометка = Ложь; 
		Элементы.КомандаНастройкаПодписантов.Пометка = Истина;
	КонецЕсли;
	
	Возврат ИмяОперации;
	
КонецФункции

&НаСервереБезКонтекста
Функция ЗаполнитьДопустимуюСкидкуСервер(Поставщик,ПроцентСкидки,СообщениеОбОшибки)	
	РезультатЗаписи = Обработки.ЖБИ_АРМЛогиста.ЗаполнитьДопустимуюСкидкуПоПоставщику(Поставщик,ПроцентСкидки,СообщениеОбОшибки);	
	Возврат РезультатЗаписи;	
КонецФункции

&НаСервереБезКонтекста
Функция ЗаполнитьПроцентНаценкиСервер(Поставщик,ПроцентНаценки,СообщениеОбОшибки)	
	РезультатЗаписи = Обработки.ЖБИ_АРМЛогиста.ЗаполнитьЗаполнитьПроцентНаценкиПоПоставщику(Поставщик,ПроцентНаценки,СообщениеОбОшибки);	
	Возврат РезультатЗаписи;	
КонецФункции

&НаСервереБезКонтекста
Функция ЗаполнитьТранспортныйПроцентСервер(Поставщик,ТранспортныйПроцент,СообщениеОбОшибки)	
	РезультатЗаписи = Обработки.ЖБИ_АРМЛогиста.ЗаполнитьТранспортныйПроцент(Поставщик,ТранспортныйПроцент,СообщениеОбОшибки);	
	Возврат РезультатЗаписи;	
КонецФункции

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_ЭЛЕМЕНТОВ_УПРАВЛЕНИЯ_ФОРМЫ

&НаКлиенте
Процедура ОтборПартнерПриИзменении(Элемент)	
	ЖБИ_ОбщийМодульОтчетыИОбработки.УстановитьОтборДинамическогоСпискаПоЭлементу(Элемент,ТаблицаПоставщиков,ЭтотОбъект,"Поставщик",Неопределено);
	УстановитьДоступностьЭлементовФормы();
КонецПроцедуры

#Область Команды

&НаКлиенте
Процедура КомандаТаблицаПоставщиков(Команда)	
	Элементы.СтраницыОсновнаяФорма.ТекущаяСтраница = Элементы.СтраницаПоставщиков;
	ИмяОперации = ПолучитьИмяОперации();
	УстановитьДоступностьЭлементовФормы();
КонецПроцедуры

&НаКлиенте
Процедура КомандаНастройкаЦеннобразованияПоРегионам(Команда)
	Элементы.СтраницыОсновнаяФорма.ТекущаяСтраница = Элементы.СтраницаЦеннобразованиеПоРегионам;
	ИмяОперации = ПолучитьИмяОперации();
	УстановитьДоступностьЭлементовФормы();
КонецПроцедуры

&НаКлиенте
Процедура КомандаНастройкаПодписантов(Команда)
	Элементы.СтраницыОсновнаяФорма.ТекущаяСтраница = Элементы.СтраницаПодписантов;
	ИмяОперации = ПолучитьИмяОперации();
	УстановитьДоступностьЭлементовФормы();
КонецПроцедуры

&НаКлиенте
Процедура КомандаИзменитьПоставщика(Команда)
	
	ТекДанные = ЖБИ_ОбщийМодульКлиентСервер.ПроверитьТекСтрокуНаДоступность(ЭтаФорма,"ТаблицаПоставщиков");
	Если ТекДанные = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	
	ОткрытьФорму("Справочник.Партнеры.Форма.ФормаЭлемента",
	Новый Структура("Ключ",ТекДанные.Поставщик),
	ЭтаФорма,,,,
	Новый ОписаниеОповещения("Подключаемый_ОбработкаРезультатаОповещения", ЭтаФорма, "ФормаРедактированиеПартнера"));
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаИзменитьДопустимуюСкидку(Команда)
	
	ТекДанные = ЖБИ_ОбщийМодульКлиентСервер.ПроверитьТекСтрокуНаДоступность(ЭтаФорма,"ТаблицаПоставщиков");
	Если ТекДанные = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	СтруктураСобытия = Новый Структура("ИмяСобытия,Поставщик","ВводЗначенияЧислоДопустимаяСкидка",ТекДанные.Поставщик);
	ВыбЗнач = ТекДанные.ДопустимаяСкидка;
	Массив = Новый Массив;
	Массив.Добавить(Тип("Число"));
	КЧ = Новый КвалификаторыЧисла(10,2);
	ОписаниеТипов = Новый ОписаниеТипов(Массив, КЧ);
	Оповещение = Новый ОписаниеОповещения("Подключаемый_ОбработкаРезультатаОповещения", ЭтаФорма, СтруктураСобытия);
	ПоказатьВводЗначения(Оповещение,ВыбЗнач, "Введите допустимый %скидки", ОписаниеТипов);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаИзменитьПроцентНаценки(Команда)
	
	ТекДанные = ЖБИ_ОбщийМодульКлиентСервер.ПроверитьТекСтрокуНаДоступность(ЭтаФорма,"ТаблицаПоставщиков");
	Если ТекДанные = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	СтруктураСобытия = Новый Структура("ИмяСобытия,Поставщик","ВводЗначенияЧислоПроцентНаценки",ТекДанные.Поставщик);
	ВыбЗнач = ТекДанные.ПроцентНаценки;
	Массив = Новый Массив;
	Массив.Добавить(Тип("Число"));
	КЧ = Новый КвалификаторыЧисла(10,2);
	ОписаниеТипов = Новый ОписаниеТипов(Массив, КЧ);
	Оповещение = Новый ОписаниеОповещения("Подключаемый_ОбработкаРезультатаОповещения", ЭтаФорма, СтруктураСобытия);
	ПоказатьВводЗначения(Оповещение,ВыбЗнач, "Введите %наценки", ОписаниеТипов);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаИзменитьТранспортныйПроцент(Команда)
	
	ТекДанные = ЖБИ_ОбщийМодульКлиентСервер.ПроверитьТекСтрокуНаДоступность(ЭтаФорма,"ТаблицаПоставщиков");
	Если ТекДанные = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	СтруктураСобытия = Новый Структура("ИмяСобытия,Поставщик","ВводЗначенияЧислоТранспортныйПроцент",ТекДанные.Поставщик);
	ВыбЗнач = ТекДанные.ТранспортныйПроцент;
	Массив = Новый Массив;
	Массив.Добавить(Тип("Число"));
	КЧ = Новый КвалификаторыЧисла(10,2);
	ОписаниеТипов = Новый ОписаниеТипов(Массив, КЧ);
	Оповещение = Новый ОписаниеОповещения("Подключаемый_ОбработкаРезультатаОповещения", ЭтаФорма, СтруктураСобытия);
	ПоказатьВводЗначения(Оповещение,ВыбЗнач, "Введите транспортный %", ОписаниеТипов)
	
КонецПроцедуры

#КонецОбласти

#Область ТаблицаПоставщиков

&НаКлиенте
Процедура ТаблицаПоставщиковВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	Если Элемент.ТекущийЭлемент.Имя = "ТаблицаПоставщиковСсылкаПартнер"
		ИЛИ Элемент.ТекущийЭлемент.Имя = "ТаблицаПоставщиковСсылкаКонтрагент" Тогда
		КомандаИзменитьПоставщика("");
	ИначеЕсли Элемент.ТекущийЭлемент.Имя = "ТаблицаПоставщиковПроцентНаценки" Тогда 
		КомандаИзменитьПроцентНаценки("");
	ИначеЕсли Элемент.ТекущийЭлемент.Имя = "ТаблицаПоставщиковДопустимаяСкидка" Тогда
		КомандаИзменитьДопустимуюСкидку("");
	ИначеЕсли  Элемент.ТекущийЭлемент.Имя = "ТаблицаПоставщиковТранспортныйПроцент" Тогда 
		КомандаИзменитьТранспортныйПроцент("");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаПоставщиковПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаПоставщиковПередУдалением(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

#КонецОбласти

#Область ТаблицаПодписантов

&НаКлиенте
Процедура ТаблицаПодписантовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекДанные = ЖБИ_ОбщийМодульКлиентСервер.ПроверитьТекСтрокуНаДоступность(ЭтаФорма,"ТаблицаПодписантов");
	Если ТекДанные = Неопределено Тогда 
		Возврат;
	КонецЕсли; 
	
	СтандартнаяОбработка = Ложь;
	
	ОткрытьФорму("Обработка.ЖБИ_АРМРуководителя.Форма.ФормаРедактированияПодписанта",
	Новый Структура("Организация,ПравоПодписи,ОтветственныйСотрудник",ТекДанные.Организация,ТекДанные.ПравоПодписи,ТекДанные.ОтветственныйСотрудник),
	ЭтаФорма,,,,
	Новый ОписаниеОповещения("Подключаемый_ОбработкаРезультатаОповещения", ЭтаФорма, "ФормаРедактированияПодписанта"),РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаПодписантовПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	ТекДанные = ЖБИ_ОбщийМодульКлиентСервер.ПроверитьТекСтрокуНаДоступность(ЭтаФорма,"ТаблицаПодписантов");
	Если ТекДанные = Неопределено Тогда 
		Возврат;
	КонецЕсли; 
	
	Отказ = Истина;
	
	ОткрытьФорму("Обработка.ЖБИ_АРМРуководителя.Форма.ФормаРедактированияПодписанта",
	Новый Структура(),
	ЭтаФорма,,,,
	Новый ОписаниеОповещения("Подключаемый_ОбработкаРезультатаОповещения", ЭтаФорма, "ФормаРедактированияПодписанта"),РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);	
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_СОБЫТИЙ_ФОРМЫ

&НаКлиенте
Процедура УстановитьПараметрыДинамическогоСписка()
	
	
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
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
		
	УстановитьДоступностьЭлементовФормы();
	Элементы.СтраницыОсновнаяФорма.ТекущаяСтраница = Элементы.СтраницаПоставщиков;
	ИмяОперации = ПолучитьИмяОперации();
	
	УстановитьПараметрыДинамическогоСписка();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
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
			Если ДополнительныеПараметры.ИмяСобытия = "ВводЗначенияЧислоДопустимаяСкидка" Тогда 
				
				Если Результат = 0 
					ИЛИ Результат = Неопределено Тогда 
					Возврат;
				КонецЕсли;
				
				СообщениеОбОшибки = "";
				Поставщик = ДополнительныеПараметры.Поставщик;
				РезультатЗаписи = ЗаполнитьДопустимуюСкидкуСервер(Поставщик,Результат,СообщениеОбОшибки);
				Если Не РезультатЗаписи Тогда 
					ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибки);
				КонецЕсли;
				
				Элементы.ТаблицаПоставщиков.Обновить();
				
			ИначеЕсли ДополнительныеПараметры.ИмяСобытия = "ВводЗначенияЧислоПроцентНаценки" Тогда 
				
				Если Результат = 0 
					ИЛИ Результат = Неопределено Тогда 
					Возврат;
				КонецЕсли;
				
				СообщениеОбОшибки = "";
				Поставщик = ДополнительныеПараметры.Поставщик;
				РезультатЗаписи = ЗаполнитьПроцентНаценкиСервер(Поставщик,Результат,СообщениеОбОшибки);
				Если Не РезультатЗаписи Тогда 
					ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибки);
				КонецЕсли;
				
				Элементы.ТаблицаПоставщиков.Обновить();	
				
			ИначеЕсли ДополнительныеПараметры.ИмяСобытия = "ВводЗначенияЧислоТранспортныйПроцент" Тогда 
				
				Если Результат = 0 
					ИЛИ Результат = Неопределено Тогда 
					Возврат;
				КонецЕсли;
				
				СообщениеОбОшибки = "";
				Поставщик = ДополнительныеПараметры.Поставщик;
				РезультатЗаписи = ЗаполнитьТранспортныйПроцентСервер(Поставщик,Результат,СообщениеОбОшибки);
				Если Не РезультатЗаписи Тогда
					ОбщегоНазначенияКлиент.СообщитьПользователю(СообщениеОбОшибки);
				КонецЕсли;
				
				Элементы.ТаблицаПоставщиков.Обновить();
			КонецЕсли;	
		КонецЕсли;
	КонецЕсли;

	Если ДополнительныеПараметры = "ФормаРедактированиеПартнера" Тогда //редактирвоание партнера 
		//Элементы.ТаблицаПоставщиков.Обновить();  
	ИначеЕсли  ДополнительныеПараметры = "ФормаРедактированияПодписанта" Тогда
		Элементы.ТаблицаПодписантов.Обновить();
	КонецЕсли;
			
КонецПроцедуры

#КонецОбласти