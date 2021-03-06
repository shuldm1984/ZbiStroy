	
#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ


#КонецОбласти

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)	
	ИнициализироватьДокумент(ДанныеЗаполнения);	
КонецПроцедуры

Процедура ИнициализироватьДокумент(ДанныеЗаполнения = Неопределено)
	
	Дата				  		= ТекущаяДатаСеанса();
	Валюта                		= ЗначениеНастроекПовтИсп.ПолучитьВалютуРегламентированногоУчета(Валюта);
	Автор                		= Пользователи.ТекущийПользователь();
	Менеджер                	= Пользователи.ТекущийПользователь();
	Организация           		= ЗначениеНастроекПовтИсп.ПолучитьОрганизациюПоУмолчанию(Организация);
	Подразделение		  		= Автор.Подразделение;	
	БанковскийСчет 				= Справочники.БанковскиеСчетаОрганизаций.ПолучитьБанковскийСчетОрганизацииПоУмолчанию(Организация, Валюта);
	Контрагент 					= ЖБИ_ОбщийМодульДокументы.ЗаполнитьКонтрагентаПартнераПоУмолчанию(Партнер);
		
КонецПроцедуры

