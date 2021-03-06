﻿
Процедура ПриОткрытии()
	
	ЭтаФорма.Заголовок						= ЭтотОбъект.Метаданные().Представление();
	
	//++ ОБЩЕЕ.
	
	ИмяОбработки 							= Настройки.ИмяОбработки + ". " + Настройки.АвторскиеПраваНаОбработку;
	КомментарийОбработки					= Настройки.КомментарийОбработки + ".";
	ВерсияОбработки							= Настройки.ВерсияОбработки;
	ДомашняяСтраницаОбработки				= Настройки.ДомашняяСтраницаОбработки;
	ФайлОбработки							= Настройки.ФайлОбработки;
	ЭлементыФормы.ДомашняяСтраницаОбработки.Заголовок = ДомашняяСтраницаОбработки;
	
	ПлатформаИВерсия	 					= "1С:Предприятие, версия " + Настройки.ВерсияПриложения;
	КонфигурацияИВерсия 					= Настройки.КонфигурацияИВерсия;
	БазаДанных								= Настройки.СтрокаСоединенияИнформационнойБазы;
	
	РежимСовместимости						= Настройки.РежимСовместимости;
	ВерсияБСП	 							= Настройки.ВерсияБСП;
	РежимИспользованияМодальностиБулево		= Настройки.РежимИспользованияМодальностиБулево;
	РежимИспользованияМодальностиСтрока		= Настройки.РежимИспользованияМодальностиСтрока;
	
	РежимЗапуска1С							= ""+Настройки.ОсновнойРежимЗапускаПриложения + " / " + Настройки.ТекущийРежимЗапускаПриложения + " (" + Настройки.ТекущийРежимЗапускаКлиента + ")";

	ТекущийПользовательИБ   				= Настройки.ТекущийПользовательИБ;
	РольПолныеПраваДоступна					= Настройки.РольПолныеПраваДоступна;
	ПравоДоступаАдминистрирование			= Настройки.ПравоДоступаАдминистрирование;
	
	//++.
	
	// ЛЕВО.
	МонопольныйРежим						= Настройки.МонопольныйРежим;
	ОбменДаннымиЗагрузка					= Настройки.ОбменДаннымиЗагрузка;
	//ПРАВО.
	ПоказыватьСообщения						= Настройки.ПоказыватьСообщения;
	СкрыватьПустыеТаблицыДвиженийРегистров	= Настройки.СкрыватьПустыеТаблицыДвиженийРегистров;
	СкрыватьПустыеТабличныеЧасти			= Настройки.СкрыватьПустыеТабличныеЧасти;

КонецПроцедуры

Процедура МонопольныйРежимПриИзменении(Элемент)
	
	Попытка
		УстановитьМонопольныйРежим(Элемент.Значение);
		Оповестить("МонопольныйРежим", МонопольныйРежим(), ЭтаФорма);
	Исключение
		Оповестить("МонопольныйРежим", МонопольныйРежим(), ЭтаФорма);
		Сообщить(ОписаниеОшибки(), СтатусСообщения.ОченьВажное);
		Возврат;
	КонецПопытки;
	
	Если МонопольныйРежим Тогда
		ПредупреждениеСообщение(, "УСТАНОВЛЕН МОНОПОЛЬНЫЙ РЕЖИМ.
		|
		|""Один пашет, а семеро руками машут."" (народная мудрость)");
	Иначе
		ПредупреждениеСообщение(, "УСТАНОВЛЕН МНОГОПОЛЬЗОВАТЕЛЬКИЙ ДОСТУП.
		|
		|""Один горюет, а артель воюет."" (народная мудрость)");
	КонецЕсли;
	
КонецПроцедуры

Процедура ПоказыватьСообщенияПриИзменении(Элемент)
	
	Оповестить("ПоказыватьСообщения", ПоказыватьСообщения, ЭтаФорма);

	Если ПоказыватьСообщения Тогда
		ПредупреждениеСообщение(, "ПОКАЗЫВАТЬ СООБЩЕНИЯ.
		|
		|""Свой глаз - алмаз."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	Иначе	
		ПредупреждениеСообщение(, "НЕ ПОКАЗЫВАТЬ СООБЩЕНИЯ.
		|
		|""Не видит око и зуб неймет."" (~ народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбменДаннымиЗагрузкаПриИзменении(Элемент)
	
	Оповестить("ОбменДаннымиЗагрузка", ОбменДаннымиЗагрузка, ЭтаФорма);
	
	Если ОбменДаннымиЗагрузка Тогда
		ПредупреждениеСообщение(, "ОТКЛЮЧИТЬ ТРИГГЕРЫ ЗАПИСИ (<Объект изменяемый>.ОбменДанными.Загрузка = Истина):
		|
		|1С: Если значение данного свойства Истина, 
		|то при выполнении записи или удаления данных будет производиться минимум проверок, 
		|так как при этом делается предположение, что производится запись данных, 
		|полученных через механизмы обмена данными, и эти данные корректны.
		|
		|Триггер (Trigger) - это особый вид хранимых процедур, автоматически выполняемых 
		|при исполнении оператора Update, Insert или Delete над данными таблицы.
		|
		|""Одна мудрая голова ста голов стоит."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	Иначе	
		ПредупреждениеСообщение(, "ВКЛЮЧИТЬ ТРИГГЕРЫ ЗАПИСИ (<Объект изменяемый>.ОбменДанными.Загрузка = Ложь):
		|
		|1С: Если значение данного свойства Истина, 
		|то при выполнении записи или удаления данных будет производиться минимум проверок, 
		|так как при этом делается предположение, что производится запись данных, 
		|полученных через механизмы обмена данными, и эти данные корректны.
		|
		|Триггер (Trigger) - это особый вид хранимых процедур, автоматически выполняемых 
		|при исполнении оператора Update, Insert или Delete над данными таблицы.
		|
		|""Одна голова хорошо, а две лучше."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	КонецЕсли;
	
КонецПроцедуры

Процедура СкрыватьПустыеТаблицыДвиженийРегистровПриИзменении(Элемент)
	
	Оповестить("СкрыватьПустыеТаблицыДвиженийРегистров", СкрыватьПустыеТаблицыДвиженийРегистров, ЭтаФорма);

	Если СкрыватьПустыеТаблицыДвиженийРегистров Тогда
		ПредупреждениеСообщение(, "НЕ ОТОБРАЖАТЬ ПУСТЫЕ ТАБЛИЦЫ ДВИЖЕНИЙ РЕГИСТРОВ.
		|
		|""С глаз долой - из сердца вон."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	Иначе	
		ПредупреждениеСообщение(, "ОТОБРАЖАТЬ ВСЕ ТАБЛИЦЫ ДВИЖЕНИЙ РЕГИСТРОВ (в т.ч. пустые).
		|
		|""Глаза боятся, а руки делают."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	КонецЕсли;
	
КонецПроцедуры

Процедура СкрыватьПустыеТабличныеЧастиПриИзменении(Элемент)
	
	Оповестить("СкрыватьПустыеТабличныеЧасти", СкрыватьПустыеТабличныеЧасти, ЭтаФорма);

	Если ЭтаФорма.СкрыватьПустыеТабличныеЧасти Тогда
		ПредупреждениеСообщение(, "НЕ ОТОБРАЖАТЬ ПУСТЫЕ ТАБЛИЧНЫЕ ЧАСТИ.
		|
		|""С глаз долой - из сердца вон."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	Иначе	
		ПредупреждениеСообщение(, "ОТОБРАЖАТЬ ВСЕ ТАБЛИЧНЫЕ ЧАСТИ (в т.ч. пустые).
		|
		|""Глаза боятся, а руки делают."" (народная мудрость)",, "УСТАНОВЛЕН РЕЖИМ:");
	КонецЕсли;
	
КонецПроцедуры

Процедура ДомашняяСтраницаОбработки(Элемент)
	ЗапуститьПриложение(ДомашняяСтраницаОбработки);
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// МОДАЛЬНОЕ/НЕМОДАЛЬНОЕ ПРЕДУПРЕЖДЕНИЕ.
//

Процедура ПредупреждениеСообщение(Оповещение, ТекстПредупрежденияСообщения, Таймаут = 0, Заголовок = "")
	
	Если ИспользоватьРежимМодальности() Тогда
		Предупреждение(ТекстПредупрежденияСообщения, Таймаут, Заголовок);
	Иначе
		Выполнить("ПоказатьПредупреждение(Оповещение, ТекстПредупрежденияСообщения, Таймаут, Заголовок)");
	КонецЕсли;;
		
КонецПроцедуры

Функция ИспользоватьРежимМодальности()
	Возврат ЭтотОбъект.РежимИспользованияМодальностиБулево;
КонецФункции
