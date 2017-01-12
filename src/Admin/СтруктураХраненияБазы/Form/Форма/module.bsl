﻿
Процедура КнопкаВыполнитьНажатие(Кнопка)
	
	Таблица = ПолучитьСтруктуруХраненияБазыДанных(, Истина);
	
	СтруктураХраненияБазы.Строки.Очистить();
	
	Для каждого СтрокаТЗ Из Таблица Цикл
		
		
		
		Если ЗначениеЗаполнено(ФильтрТаблица) Тогда
			
			Если ТипПоиска = "ИмяБД" Тогда
				
				Если Найти(СтрокаТЗ.ИмяТаблицыХранения, СокрЛП(ФильтрТаблица)) = 0 Тогда
					Продолжить;
				КонецЕсли;
				
			Иначе
				
				Если Найти(СтрокаТЗ.Метаданные, СокрЛП(ФильтрТаблица)) = 0 Тогда
					Продолжить;
				КонецЕсли;
				
			КонецЕсли;	
			
		КонецЕсли;
		
		НоваяСтрока = СтруктураХраненияБазы.Строки.Добавить();
		НоваяСтрока.ИмяБД      = СтрокаТЗ.ИмяТаблицыХранения;
		НоваяСтрока.Имя1С      = СтрокаТЗ.Метаданные;
		НоваяСтрока.Метаданные = СтрокаТЗ.Метаданные;
		
		Для каждого СтрокаТЗ2 Из СтрокаТЗ.Поля Цикл
			
			Если ЗначениеЗаполнено(ФильтрПоле)
				И Найти(СтрокаТЗ2.ИмяПоляХранения, СокрЛП(ФильтрПоле)) = 0 Тогда
				
				Продолжить;
				
			КонецЕсли;
			
			НоваяСтрока2 = НоваяСтрока.Строки.Добавить();
			НоваяСтрока2.ИмяБД      = СтрокаТЗ2.ИмяПоляХранения;
			НоваяСтрока2.Имя1С      = СтрокаТЗ2.ИмяПоля;
			НоваяСтрока2.Метаданные = СтрокаТЗ2.Метаданные;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ПередОткрытием(Отказ, СтандартнаяОбработка)
	
	ТипПоиска = "ИмяБД";
	
КонецПроцедуры
