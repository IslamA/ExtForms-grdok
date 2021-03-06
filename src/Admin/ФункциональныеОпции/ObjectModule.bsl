﻿
Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ДокументРезультат.Очистить();
	
	ВнешниеНаборыДанных = Новый Структура;
	ВнешниеНаборыДанных.Вставить("Данные", ПолучитьТаблицуДанных());
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, КомпоновщикНастроек.ПолучитьНастройки(), ДанныеРасшифровки);
		
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, ВнешниеНаборыДанных, ДанныеРасшифровки, Истина);
		
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
		
	ПроцессорВывода.Вывести(ПроцессорКомпоновки, Истина);
	
КонецПроцедуры

Функция ПолучитьТаблицуДанных()
	
	Таблица = Новый ТаблицаЗначений;
	Таблица.Колонки.Добавить("ФО");
	Таблица.Колонки.Добавить("Объект");
	Таблица.Колонки.Добавить("Хранение");
	
	Для каждого ОбъектМетаданных из Метаданные.ФункциональныеОпции Цикл
		
		Для каждого Элемент Из ОбъектМетаданных.Состав Цикл
			
			НоваяСтрока = Таблица.Добавить();
			НоваяСтрока.ФО       = ОбъектМетаданных.Имя;
			НоваяСтрока.Хранение = ОбъектМетаданных.Хранение.ПолноеИмя();
			
			Объект = Элемент.Объект.ПолноеИмя();
			Объект = СтрЗаменить(Объект, "Реквизит.", "");
			Объект = СтрЗаменить(Объект, "ТабличнаяЧасть.", "");
			НоваяСтрока.Объект  = Объект;
			
		КонецЦикла;	
		
	КонецЦикла;
	
	Возврат Таблица;
	
КонецФункции	
