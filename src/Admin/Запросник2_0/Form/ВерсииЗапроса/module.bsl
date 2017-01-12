﻿
Процедура КнопкаВыполнитьНажатие(Кнопка)
	// Вставить содержимое обработчика.
КонецПроцедуры

Процедура ПриОткрытии()
	
	ВерсииЗапроса.Сортировать("ДатаВерсии УБЫВ");
	
	ЭлементыФормы.ВерсииЗапроса.СоздатьКолонки();
	
	Для каждого Колонка Из ЭлементыФормы.ВерсииЗапроса.Колонки Цикл
		
		Если Колонка.Имя = "ДатаВерсии" Тогда
			Колонка.ТекстШапки = "Версия";
			Колонка.Ширина = 8;
		Иначе
			Колонка.Видимость = Ложь;
		КонецЕсли; 
		
	КонецЦикла; 
	
	ЭлементыФормы.ВерсииЗапроса.Колонки.ДатаВерсии.Формат = "ДЛФ=T";
	
	НовКолонка = ЭлементыФормы.ВерсииЗапроса.Колонки.Добавить("ДатаСтрокой");
	НовКолонка.ТекстШапки = "";
	НовКолонка.Ширина = 7;
	НовКолонка.Положение = ПоложениеКолонки.ВТойЖеКолонке;
	
	СтрокаТекВерсии = ВерсииЗапроса.Найти(ДатаТекущейВерсии,"ДатаВерсии");
	ЭлементыФормы.ВерсииЗапроса.ТекущаяСтрока = СтрокаТекВерсии;
	
КонецПроцедуры

Процедура ВерсииЗапросаПриАктивизацииСтроки(Элемент)
	
	ТекДанные = ЭлементыФормы.ВерсииЗапроса.ТекущиеДанные;
	
	Если ТекДанные = Неопределено Тогда Возврат	КонецЕсли; 
	
	ЭлементыФормы.ТекстЗапроса.УстановитьТекст(ТекДанные.ТекстЗапроса);
	
	Параметры.Очистить();
	
	Для каждого Параметр Из ТекДанные.Параметры Цикл
		
		НовСтрока = Параметры.Добавить();
		ЗаполнитьЗначенияСвойств(НовСтрока,Параметр);
		
	КонецЦикла; 
	
КонецПроцедуры

Процедура ВерсииЗапросаВыбор(Элемент, ВыбраннаяСтрока, Колонка, СтандартнаяОбработка)
	
	Закрыть(ВыбраннаяСтрока.ДатаВерсии);
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

Процедура КнопкаОтменаНажатие(Элемент)
	
	Закрыть();
	
КонецПроцедуры

Процедура ВерсииЗапросаПриПолученииДанных(Элемент, ОформленияСтрок)
	
	Для каждого ОформлениеСтроки Из ОформленияСтрок Цикл
		
		ДанныеСтроки = ОформлениеСтроки.ДанныеСтроки; 
		
		Если ДанныеСтроки.ДатаВерсии = ДатаТекущейВерсии Тогда
			ОформлениеСтроки.ЦветТекста = Новый Цвет(26, 126, 224);
		КонецЕсли; 
		
		РазностьВДнях = Цел((НачалоДня(ТекущаяДата()) - НачалоДня(ДанныеСтроки.ДатаВерсии))/(24*60*60));
		
		Если РазностьВДнях = 0 Тогда
			ОформлениеСтроки.Ячейки.ДатаСтрокой.УстановитьТекст("сегодня");
		ИначеЕсли РазностьВДнях = 1 Тогда
			ОформлениеСтроки.Ячейки.ДатаСтрокой.УстановитьТекст("вчера");
		Иначе	
			ОформлениеСтроки.Ячейки.ДатаСтрокой.УстановитьТекст(Формат(ДанныеСтроки.ДатаВерсии,"ДФ=dd.MM.yyyy"));
		КонецЕсли; 		
		
	КонецЦикла; 
	
	
КонецПроцедуры


