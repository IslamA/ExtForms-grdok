﻿

Процедура КнопкаОткрытьСхемуНажатие(Элемент)
	
	ЧтениеТекста = Новый ЧтениеТекста;
	ЧтениеТекста.Открыть(ФайлСКД);
	
	СтрСКД = ЧтениеТекста.Прочитать();
	ЧтениеТекста.Закрыть();
	
	СхемаКомпоновкиДанных = ЗначениеИзСтрокиВнутр(СтрСКД);
	
	Конструктор = Новый КонструкторСхемыКомпоновкиДанных(СхемаКомпоновкиДанных);
	Конструктор.Редактировать(ЭтаФорма);
	
КонецПроцедуры

Процедура КнопкаЗагрузитьНастройкиНажатие(Элемент)
	
	ЧтениеТекста = Новый ЧтениеТекста;
	ЧтениеТекста.Открыть(ФайлНастройки);
	СтрНастройки = ЧтениеТекста.Прочитать();
	ЧтениеТекста.Закрыть();
	
	Настройки = ЗначениеИзСтрокиВнутр(СтрНастройки);
	КомпоновщикНастроек.ЗагрузитьНастройки(Настройки);
	
КонецПроцедуры

Процедура ФайлНачалоВыбора(Элемент, СтандартнаяОбработка)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Если Диалог.Выбрать() Тогда
		Элемент.Значение = Диалог.ПолноеИмяФайла;
	КонецЕсли;	
	
КонецПроцедуры
