
&НаСервере
&После("ПриСозданииНаСервере")
Процедура ЖБИ_ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Объект", Объект);
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ЖБИ_ПриСозданииНаСервере(ЭтаФорма, ДополнительныеПараметры)
КонецПроцедуры
