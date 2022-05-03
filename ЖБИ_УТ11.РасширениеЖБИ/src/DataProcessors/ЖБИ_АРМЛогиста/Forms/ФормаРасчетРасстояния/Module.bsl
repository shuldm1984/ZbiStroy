
#Область ПРОЦЕДУРЫ_И_ФУНКЦИИ_ОБЩЕГО_НАЗНАЧЕНИЯ

&НаСервере
Процедура ЗаполнитьТаблицуПредварительныхСтавок()
	
	Запрос 			= Новый Запрос;
	Запрос.УстановитьПараметр("Поставщик", Поставщик);
	Запрос.Текст 	= "ВЫБРАТЬ
	             	  |	ЖБИ_ПунктыНазначенияОтгрузки.Партнер КАК Поставщик,
	             	  |	ЖБИ_РасчетПредварительныхСтавок.ПунктОтгрузки КАК Откуда,
	             	  |	ЖБИ_РасчетПредварительныхСтавок.Регион КАК Регион,
	             	  |	ЖБИ_РасчетПредварительныхСтавок.Город КАК Город,
	             	  |	ЖБИ_РасчетПредварительныхСтавок.Расстояние КАК Расстояние,
	             	  |	ЖБИ_РасчетПредварительныхСтавок.ДатаОбновления КАК ДатаОбновления,
	             	  |	ЖБИ_РасчетПредварительныхСтавок.Автор КАК Автор
	             	  |ИЗ
	             	  |	РегистрСведений.ЖБИ_РасчетПредварительныхСтавок КАК ЖБИ_РасчетПредварительныхСтавок
	             	  |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЖБИ_ПунктыНазначенияОтгрузки КАК ЖБИ_ПунктыНазначенияОтгрузки
	             	  |		ПО ЖБИ_РасчетПредварительныхСтавок.ПунктОтгрузки = ЖБИ_ПунктыНазначенияОтгрузки.ПунктНазначенияОтгрузки
	             	  |ГДЕ
	             	  |	ЖБИ_ПунктыНазначенияОтгрузки.Партнер = &Поставщик";
	РезультатЗапроса = Запрос.Выполнить().Выбрать();
	Пока РезультатЗапроса.Следующий() Цикл
		НоваяСтр = ТаблПредварительныеСтавки.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтр,РезультатЗапроса);
	КонецЦикла;	
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьСкрипт()
	
	Для Каждого НомСтр Из ТаблПредварительныеСтавки Цикл
		
		КодХТМЛ = "<!DOCTYPE html>
		|<html>
		|<head>
		|    <title>Маршрут</title>
		|    <meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" /><meta http-equiv=""X-UA-Compatible"" content=""IE=8""/>
		|    <!-- Если вы используете API локально, то в URL ресурса необходимо указывать протокол в стандартном виде (http://...)-->
		|    <script src=""http://api-maps.yandex.ru/2.1/?lang=ru_RU&amp;apikey=" + APIКлюч + """ type=""text/javascript""></script>
		|    <script src=""http://yandex.st/jquery/1.6.4/jquery.min.js"" type=""text/javascript""></script>
		//|    <script src=""https://yandex.st/jquery/2.2.3/jquery.min.js"" type=""text/javascript""></script>
		//|    <script src=""https://yandex.st/jquery/2.0.3/jquery.min.js"" type=""text/javascript""></script>
		|
		|<script type=""text/javascript""> 
		|   
		|   
		|   ymaps.ready(init);
		|
		|function init() {
		|    var myMap = new ymaps.Map(""map"", {
		|            center: [55.745508, 37.435225],
		|            zoom: 10
		|        });
		|
		|    // Добавим на карту схему проезда
		|    // Точки маршрута можно задавать 3 способами:
		|    // как строка, как объект или как массив геокоординат.
		|    ymaps.route([
		|        //~~ТелоФункции1~~
		|    ]).then(function (route) {
		|        myMap.geoObjects.add(route);
		|        // Зададим содержание иконок начальной и конечной точкам маршрута.
		|        // С помощью метода getWayPoints() получаем массив точек маршрута.
		|        // Массив транзитных точек маршрута можно получить с помощью метода getViaPoints.
		|        var points = route.getWayPoints(),
		|            lastPoint = points.getLength() - 1;
		|        // Задаем стиль метки - иконки будут красного цвета, и
		|        // их изображения будут растягиваться под контент.
		|        points.options.set('preset', 'islands#redStretchyIcon');
		|
		|       var index = //~~ТелоФункции2~~;
		|		for (var i=1; i <= index; i++) {
		|			points.get(i).properties.set('iconContent', i);
		|		}
		|
		|        // Задаем контент меток в начальной и конечной точках.
		|        points.get(0).properties.set('iconContent', '//~~ТелоТочки1~~');
		|        points.get(lastPoint).properties.set('iconContent', '//~~ТелоТочки2~~');
		|
		|		var arrDist = '';
		|		var	way;
		|        for (var i = 0; i < route.getPaths().getLength(); i++) {
		|            way = route.getPaths().get(i);
		|			arrDist += Math.round(way.getLength()/1000)  + ',';
		|        }
		|		$('#list2').append(arrDist);
		|       $('#list').append(Math.round(route.getLength()/1000));
		|       
		|    }, function (error) {
		|        alert('Возникла ошибка: ' + error.message);
		|    });
		|}  
		|   </script>
		|   
		|	<style>
		|        body, html {
		|            padding: 0;
		|            margin: 0;
		|            width: 100%;
		|            height: 100%;
		|            font-family: Arial;
		|            font-size: 14px;
		|        }
		|        #list {
		|            padding: 10px;
		|        }
		|        #map {         
		|			width: 100%; height: 100%;
		|        }
		|    </style>
		|</head>
		|
		|<body>
		|<div id=""map""></div>
		|<div  id=""list"" name=""list""></div>
		|<div  id=""list2"" name=""list2""></div>
		|</body>
		|
		|</html>";
		
		ТелоФункции = "";
		
		НоваяСтр 		= МассивАдресов.Добавить();
		НоваяСтр.Адрес 	= НомСтр.Откуда; 
		НоваяСтр 		= МассивАдресов.Добавить();
		НоваяСтр.Адрес 	= НомСтр.Город;
		
		ИндексЭлемента = 1;
		Для Каждого Элемент Из МассивАдресов Цикл 
			Если ИндексЭлемента < МассивАдресов.Количество() Тогда
				ТелоФункции = ТелоФункции + "'" + Элемент.Адрес + "', ";
			Иначе
				ТелоФункции = ТелоФункции + "'" + Элемент.Адрес + "'";
			КонецЕсли;
			ИндексЭлемента = ИндексЭлемента + 1;
		КонецЦикла;
		
		КодХТМЛ = СтрЗаменить(КодХТМЛ, "//~~ТелоФункции1~~", ТелоФункции);
		КодХТМЛ = СтрЗаменить(КодХТМЛ, "//~~ТелоФункции2~~", МассивАдресов.Количество()-1);
		КодХТМЛ = СтрЗаменить(КодХТМЛ, "//~~ТелоТочки1~~", "Точка отправления");
		КодХТМЛ = СтрЗаменить(КодХТМЛ, "//~~ТелоТочки2~~", "Точка прибытия");
		Карта = КодХТМЛ;
		
		ПодключитьОбработчикОжидания("ПолучитьДистанцию", 5, Истина);	
		//ПолучитьДистанцию(7);
		//ВызватьПаузуНаСервере(7);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ВызватьПаузуНаСервере(Секунд)
	ОбщегоНазначенияБТС.Пауза(Секунд);
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьДистанцию()
	
	//ВызватьПаузуНаСервере(Секунд);
	
	//Попытка
		Попытка
			ИтогоМаршрут 	= Число(Элементы.Карта.Документ.body.children.Item(1).innerText); 
			ОтрезкиМаршрута = Элементы.Карта.Документ.body.children.Item(2).innerText;
		Исключение	
			ИтогоМаршрут 	=  Элементы.Карта.Документ.body.children[1].textContent;
			ОтрезкиМаршрута =  Элементы.Карта.Документ.body.children[2].textContent;
		КонецПопытки;	
	//Исключение
	//	ПодключитьОбработчикОжидания("ПолучитьДистанцию", 5, истина);
	//КонецПопытки;	
	
	МассивАдресов.Очистить();
	
КонецПроцедуры

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_ЭЛЕМЕНТОВ_УПРАВЛЕНИЯ_ФОРМЫ

&НаКлиенте
Процедура КомандаВыполнитьРасчет(Команда)
	
	Если Не ЗначениеЗаполнено(APIКлюч) Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю("Заполните поле APIКлюч");
		Возврат;
	КонецЕсли;
	
	ЗаполнитьСкрипт();
		
КонецПроцедуры

#КонецОбласти

#Область ПРОЦЕДУРЫ_ОБРАБОТЧИКИ_СОБЫТИЙ_ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Не Параметры.Свойство("Поставщик") Тогда 
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	Поставщик = Параметры.Поставщик;	
	ЗаполнитьТаблицуПредварительныхСтавок();
	
КонецПроцедуры

#КонецОбласти