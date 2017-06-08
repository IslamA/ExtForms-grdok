﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Объект.СтрокаЗапускаАстра = "C:\Program Files (x86)\Astra R-Nesting\Astra.exe";
	
	Объект.ШиринраРеза = 3.5;
	Объект.Кромка      = 20;
	Объект.МинОстатокДлина  = 560;
	Объект.МинОстатокШирина = 800;
	
	ПараметрыВыбора = Новый Массив;
	ПараметрыВыбора.Добавить(Новый ПараметрВыбора("Отбор.Владелец", ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.НайтиПоНаименованию("6 Сорт (Характеристики номенклатуры)")));
	
	Элементы.СортПоУмолчанию.ПараметрыВыбора = Новый ФиксированныйМассив(ПараметрыВыбора);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если НЕ ЗначениеЗаполнено(Объект.ИмяФайла) Тогда
		Объект.ИмяФайла = ПолучитьИмяВременногоФайла("xml");
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Функция ВыгрузитьНаСервере()
	
	Элементы.ФормаЗапуститьАстру.Доступность = Истина;
	Элементы.ФормаЗапуститьАстру.КнопкаПоУмолчанию = Истина;
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ИмяФайлаXML = ОбработкаОбъект.Выгрузить();
	
	ЗначениеВРеквизитФормы(ОбработкаОбъект, "Объект");
	
	Данные = Новый ДвоичныеДанные(ИмяФайлаXML);
	АдресХранилища = ПоместитьВоВременноеХранилище(Данные, УникальныйИдентификатор);
	
	Возврат АдресХранилища;
	
КонецФункции

&НаКлиенте
Процедура Выгрузить(Команда)
	
	АдресХранилища = ВыгрузитьНаСервере();
	
	Описание = Новый ОписаниеПередаваемогоФайла(Объект.ИмяФайла, АдресХранилища);
	ПолучаемыеФайлы = Новый Массив;
	ПолучаемыеФайлы.Добавить(Описание);

	ОписаниеОповещения = Новый ОписаниеОповещения("ВыгрузитьЗавершение", ЭтотОбъект);
	НачатьПолучениеФайлов(ОписаниеОповещения, ПолучаемыеФайлы,, Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыгрузитьЗавершение(ПолученныеФайлы, ДополнительныеПараметры) Экспорт
	
	Состояние("Выгрузка завершена");
	
КонецПроцедуры

&НаКлиенте
Процедура ИмяФайлаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	Диалог.Фильтр = "*.xml|*.xml";
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ИмяФайлаНачалоВыбораЗавершение", ЭтотОбъект);
	Диалог.Показать(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ИмяФайлаНачалоВыбораЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныеФайлы <> Неопределено Тогда
		Объект.ИмяФайла = ВыбранныеФайлы[0];
	Конецесли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ИмяФайлаОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ЗапуститьПриложение(Объект.ИмяФайла);
	
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаОстатковВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если Поле.Имя = "ТаблицаОстатковНоменклатура"
		ИЛИ Поле.Имя =  "ТаблицаОстатковХарактеристика" Тогда
	
		ТекущиеДанные = Объект.ТаблицаОстатков.НайтиПоИдентификатору(ВыбраннаяСтрока);
		ПоказатьЗначение(, ТекущиеДанные[СтрЗаменить(Поле.Имя, "ТаблицаОстатков", "")]);
	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НоменклатураЛистыНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ОписаниеТипов",     Новый ОписаниеТипов("СправочникСсылка.Номенклатура"));
	ПараметрыФормы.Вставить("ЗначенияДляВыбора", Объект.НоменклатураЛисты);
	ПараметрыФормы.Вставить("Отмеченные",        Объект.НоменклатураЛистыОтмеченные);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("НоменклатураЛистыНачалоВыбораЗавершение", ЭтотОбъект);
	
	ОткрытьФорму("ОбщаяФорма.ВводЗначенийСпискомСФлажками", ПараметрыФормы, ЭтаФорма, "НоменклатураЛисты",,, ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура НоменклатураЛистыНачалоВыбораЗавершение(РезультатЗакрытия, ДопПараметры) Экспорт
	
	Если РезультатЗакрытия = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	Объект.НоменклатураЛисты = РезультатЗакрытия;
	
	Объект.НоменклатураЛистыОтмеченные.Очистить();
	Для каждого ЭлементСписка из РезультатЗакрытия Цикл
		Если ЭлементСписка.Пометка Тогда
			Объект.НоменклатураЛистыОтмеченные.Добавить(ЭлементСписка.Значение);
		КонецЕсли;	
	КонецЦикла;	
	
КонецПроцедуры

&НаКлиенте
Процедура НоменклатураОстаткиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ОписаниеТипов",     Новый ОписаниеТипов("СправочникСсылка.Номенклатура"));
	ПараметрыФормы.Вставить("ЗначенияДляВыбора", Объект.НоменклатураОстатки);
	ПараметрыФормы.Вставить("Отмеченные",        Объект.НоменклатураОстаткиОтмеченные);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("НоменклатураОстаткиНачалоВыбораЗавершение", ЭтотОбъект);
	
	ОткрытьФорму("ОбщаяФорма.ВводЗначенийСпискомСФлажками", ПараметрыФормы, ЭтаФорма, "НоменклатураЛисты",,, ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура НоменклатураОстаткиНачалоВыбораЗавершение(РезультатЗакрытия, ДопПараметры) Экспорт
	
	Если РезультатЗакрытия = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	Объект.НоменклатураОстатки = РезультатЗакрытия;
	
	Объект.НоменклатураОстаткиОтмеченные.Очистить();
	Для каждого ЭлементСписка из РезультатЗакрытия Цикл
		Если ЭлементСписка.Пометка Тогда
			Объект.НоменклатураОстаткиОтмеченные.Добавить(ЭлементСписка.Значение);
		КонецЕсли;	
	КонецЦикла;	
	
КонецПроцедуры


&НаКлиенте
Процедура ЗапуститьАстру(Команда)
	
	СтрокаЗапуска = """" + Объект.СтрокаЗапускаАстра + """ """ + Объект.ИмяФайла + """ -i";
	ЗапуститьПриложение(СтрокаЗапуска);
	
КонецПроцедуры

&НаКлиенте
Процедура СтрокаЗапускаАстраНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	Диалог.Фильтр = "*.exe|*.exe";
	
	ОписаниеОповещения = Новый ОписаниеОповещения("СтрокаЗапускаАстраНачалоВыбораЗавершение", ЭтотОбъект);
	Диалог.Показать(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура СтрокаЗапускаАстраНачалоВыбораЗавершение(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныеФайлы <> Неопределено Тогда
		Объект.СтрокаЗапускаАстра = ВыбранныеФайлы[0];
	Конецесли;	
	
КонецПроцедуры

&НаКлиенте
Процедура Заполнить(Команда)
	ЗаполнитьНаСервере();
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНаСервере()
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ОбработкаОбъект.Заполнить();
	ЗначениеВРеквизитФормы(ОбработкаОбъект, "Объект");
	
	Элементы.ФормаВыгрузить.Доступность       = Истина;
	Элементы.ФормаВыгрузить.КнопкаПоУмолчанию = Истина;
	
	Элементы.ФормаЗапуститьАстру.Доступность = Ложь;
	
КонецПроцедуры
