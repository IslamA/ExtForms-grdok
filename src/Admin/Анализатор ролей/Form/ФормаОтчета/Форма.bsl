﻿
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ВнешнийОтчет.АнализаторПравДоступа.ОсновнаяФорма.Модуль
//
// Автор: Уничкин Р. А. 5 марта 2015 г. 19:18:16
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

//==================================================================================== Уничкин_РА [24.03.2015 10:52:32]=
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОчищатьКэшПередФормированием	= Истина;
	Элементы.ОчищатьКэш.Пометка = Истина;
	УИД = Новый УникальныйИдентификатор;
	
	Если Параметры.СформироватьПриОткрытии <> Неопределено Тогда
		НеВосстанавливатьНастройкиПриОткрытииФормы = Истина;
		
		ВариантАнализа = Параметры.ВариантАнализа;
		АнализируемыйОбъект = Параметры.АнализируемыйОбъект;
		
		Если Параметры.Свойство("ПолноеИмяОбъекта") Тогда
			ПолноеИмяОбъекта = Параметры.ПолноеИмяОбъекта;
		КонецЕсли; 
		
		Элементы.НастройкаОтборапоПравамДоступа.Доступность = Ложь;
	
		сп_УстановитьНастройкиКомпоновщикаНаСервере();
		зт_НастройкаОтбораПоПравамДоступаНаСервере();		

		вс_СформироватьОтчетНаСервере();
	КонецЕсли; 	
	
	длг_УстановкаВидимостиЭлементовОтВариантаАнализаНаСервере();
	длг_УстановкаВидимостиПолейРезультатовНаСервере();
	
КонецПроцедуры

//==================================================================================== Уничкин_РА [15.04.2015 21:47:09]=
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если НЕ ПустаяСтрока(ВариантАнализа) И АнализируемыйОбъект <> Неопределено Тогда
		сп_НастройкаОчисткиКэша(Ложь);		
		ПриОткрытииНаСервере();
	КонецЕсли; 
КонецПроцедуры

//=================================================================================== Уничкин_РА [15.01.2015 22:02:50]=
&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)

	Если ВариантАнализа = "Объект" ИЛИ ВариантАнализа = "Роль" Тогда
		ПолноеИмяОбъекта = ВыбранноеЗначение.ПолноеИмя;
		АнализируемыйОбъект = ВыбранноеЗначение.Имя;
	Иначе
		АнализируемыйОбъект = ВыбранноеЗначение;		
	КонецЕсли; 
		
	сп_НастройкаОчисткиКэша(Истина);	
	вс_ОбработкаВыбораНаСервере();
КонецПроцедуры

//==================================================================================== Уничкин_РА [03.06.2015 17:44:03]=
&НаСервере
Процедура ПередЗагрузкойДанныхИзНастроекНаСервере(Настройки)
	Если НеВосстанавливатьНастройкиПриОткрытииФормы Тогда
		Настройки.Очистить();		
	КонецЕсли; 
КонецПроцедуры

//==================================================================================== Уничкин_РА [20.03.2015 17:22:49]=
&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	Если НеВосстанавливатьНастройкиПриОткрытииФормы Тогда
	Иначе		
		сп_УстановитьНастройкиКомпоновщикаНаСервере();
	КонецЕсли; 
	
КонецПроцедуры

//==================================================================================== Уничкин_РА [24.03.2015 19:33:57]=
&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ЗакрытиеФормыНастройкиСпискаОтбораПравДоступа" Тогда
		Если СписокЗначенийОтборПравДоступа <> Параметр Тогда
			СписокЗначенийОтборПравДоступа = Параметр;
			сп_НастройкаОчисткиКэша(Истина);
		КонецЕсли;
	КонецЕсли; 
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

//==================================================================================== Уничкин_РА [22.03.2015 20:08:59]=
&НаКлиенте
Процедура АнализируемыйОбъектНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	Если ПустаяСтрока(ВариантАнализа) Тогда
		Возврат;				
	КонецЕсли; 
	
	Если ВариантАнализа = "Профиль" Тогда
		ПараметрыФормы = Новый Структура("РежимВыбора", Истина);
		ОткрытьФорму("Справочник.ПрофилиГруппДоступа.ФормаВыбора",ПараметрыФормы, ЭтаФорма);
		
	ИначеЕсли ВариантАнализа = "Пользователь" Тогда
		ПараметрыФормы = Новый Структура("РежимВыбора", Истина);
		ОткрытьФорму("Справочник.Пользователи.ФормаВыбора" ,ПараметрыФормы, ЭтаФорма);
		
	Иначе
		ПараметрыФормы = Новый Структура("ВариантАнализа", ВариантАнализа);
		ОткрытьФорму("ВнешнийОтчет.АнализаторПравДоступа.Форма.ФормаВыборТаблицыИзДереваМетаданных", ПараметрыФормы, ЭтаФорма);	
	КонецЕсли; 	
	
КонецПроцедуры

//==================================================================================== Уничкин_РА [22.03.2015 19:58:18]=
&НаКлиенте
Процедура ВариантАнализаПриИзменении(Элемент)	
	АнализируемыйОбъект = Неопределено;	
	Элементы.НастройкаОтборапоПравамДоступа.Доступность = Ложь;

	сп_НастройкаОчисткиКэша(Истина);	
	
	вс_ВариантАнализаПриИзмененииНаСервере();
	
КонецПроцедуры

//==================================================================================== Уничкин_РА [03.06.2015 19:38:37]=
&НаКлиенте
Процедура ВариантАнализаОчистка(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
КонецПроцедуры

//==================================================================================== Уничкин_РА [16.05.2015 23:02:54]=
&НаКлиенте
Процедура ОтключитьАнализРолейПриИзменении(Элемент)
	
	вс_ОтключитьАнализРолейПриИзмененииНаСервере();
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦ ФОРМЫ

//==================================================================================== Уничкин_РА [16.05.2015 23:56:46]=
&НаКлиенте
Процедура Результат1ОбработкаРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если ТипЗнч(Расшифровка) = Тип("Структура") И Расшифровка.Свойство("НомерГруппировки") Тогда
		Результат1.ПоказатьУровеньГруппировокСтрок(Расшифровка.НомерГруппировки - 1);
		
		КоличествоГруппировок = Результат1.КоличествоУровнейГруппировокСтрок();

		Для сч=1 По КоличествоГруппировок Цикл
			ЭтоТекущая = Расшифровка.НомерГруппировки = сч;
			обл_Кнопка = Результат1.Область(1, сч*2-1);
			
			Если ЭтоТекущая Тогда
				обл_Кнопка.ЦветФона = WebЦвета.Бирюзовый;
			Иначе
				обл_Кнопка.ЦветФона = WebЦвета.СветлоСерый;
			КонецЕсли; 
		КонецЦикла; 
		
		Возврат;
	КонецЕсли; 
	
	зн = сп_ЗначениеРасшифровкиНаСервере(Расшифровка, ДанныеРасшифровкиРезультата1);
	
	Если зн = Неопределено Тогда
		Возврат;		
	КонецЕсли; 

	// Формирование нового экземпляра отчета, согласно значению расшифровки
	ОткрытьФорму("ВнешнийОтчет.АнализаторПравДоступа.Форма.ФормаОтчета", зн,,Истина);

КонецПроцедуры

//==================================================================================== Уничкин_РА [17.05.2015 0:00:08]=
&НаКлиенте
Процедура Результат2ОбработкаРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	зн = сп_ЗначениеРасшифровкиНаСервере(Расшифровка, ДанныеРасшифровкиРезультата2);
	
	Если зн = Неопределено Тогда
		Возврат;		
	КонецЕсли; 

	// Формирование нового экземпляра отчета, согласно значению расшифровки
	ОткрытьФорму("ВнешнийОтчет.АнализаторПравДоступа.Форма.ФормаОтчета", зн,,Истина);

КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// КОМАНДЫ ФОРМЫ

//==================================================================================== Уничкин_РА [17.03.2015 18:48:34]=
&НаКлиенте
Процедура Сформировать(Команда)
	
	Если ПустаяСтрока(ВариантАнализа) ИЛИ ПустаяСтрока(АнализируемыйОбъект) Тогда
		Сообщить("Отчет не может быть сформирован...");
		Возврат;
	КонецЕсли; 
	
	вс_СформироватьОтчетНаСервере();
	сп_НастройкаОчисткиКэша(Ложь);
КонецПроцедуры

//==================================================================================== Уничкин_РА [23.03.2015 12:32:03]=
&НаКлиенте
Процедура ОбновитьИОМ(Команда)
	вс_ОбновитьИОМНаСервере();	
КонецПроцедуры

//==================================================================================== Уничкин_РА [24.03.2015 9:40:26]=
&НаКлиенте
Процедура НастройкаОтборапоПравамДоступа(Команда)
	
	ПараметрыФормы = Новый Структура("СписокЗначенийОтборПравДоступа, НаименованиеАнализируемогоОбъекта"
		, СписокЗначенийОтборПравДоступа
		, Элементы.АнализируемыйОбъект.ТекстРедактирования);
		
	ОткрытьФорму("ВнешнийОтчет.АнализаторПравДоступа.Форма.ФормаНастройкиОтбора"
		, ПараметрыФормы
		, ЭтаФорма
		, Истина);
	
КонецПроцедуры

//==================================================================================== Уничкин_РА [24.03.2015 19:52:07]=
&НаКлиенте
Процедура ОчищатьКэш(Команда)
	сп_НастройкаОчисткиКэша();
КонецПроцедуры

//==================================================================================== Уничкин_РА [25.03.2015 10:01:30]=
&НаКлиенте
Процедура ОткрытьСправочникПрофилиГруппДоступа(Команда)
	ОткрытьФорму("Справочник.ПрофилиГруппДоступа.ФормаСписка");
КонецПроцедуры

//==================================================================================== Уничкин_РА [29.05.2015 20:52:54]=
&НаКлиенте
Процедура ОткрытьСправочникГруппыДоступа(Команда)
	ОткрытьФорму("Справочник.ГруппыДоступа.ФормаСписка");
КонецПроцедуры

//==================================================================================== Уничкин_РА [29.05.2015 20:54:20]=
&НаКлиенте
Процедура ОткрытьСправочникПользователи(Команда)
	ОткрытьФорму("Справочник.Пользователи.ФормаСписка");
КонецПроцедуры

//==================================================================================== Уничкин_РА [29.05.2015 20:55:29]=
&НаКлиенте
Процедура ОткрытьСправочникИдентификаторыОбъектовМетаданных(Команда)
	ОткрытьФорму("ВнешнийОтчет.АнализаторПравДоступа.Форма.ФормаСпискаИОМ");
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
 
//==================================================================================== Уничкин_РА [24.03.2015 20:01:51]=
&НаКлиенте
Процедура сп_НастройкаОчисткиКэша(ФлагКэша = Неопределено)	
	Если ФлагКэша <> Неопределено Тогда
		ОчищатьКэшПередФормированием = ФлагКэша;
	Иначе
		ОчищатьКэшПередФормированием = НЕ ОчищатьКэшПередФормированием;	
	КонецЕсли; 
	
	Элементы.ОчищатьКэш.Пометка = ОчищатьКэшПередФормированием;	
КонецПроцедуры
  
//==================================================================================== Уничкин_РА [23.03.2015 15:33:21]=
&НаСервере
Функция сп_ЗначениеРасшифровкиНаСервере(Расшифровка, АдресВременногоХранилища)
	
	КоллекцияРасшифровки = ПолучитьИзВременногоХранилища(АдресВременногоХранилища);
	КоллекцияПолей = КоллекцияРасшифровки.Элементы[Расшифровка].ПолучитьПоля();
	
	Если КоллекцияПолей.Количество() = 0 Тогда
		Возврат Неопределено;		
	КонецЕсли; 
	
	// Поиск значения поля в зависимости от выбранного варианта анализа
	ЗначениеПоля = КоллекцияПолей[0].Значение;
	
	СтруктураРезультат = Новый Структура("АнализируемыйОбъект, ВариантАнализа", "", "");
	
	ТипЗначенияПоля = ТипЗнч(ЗначениеПоля);
	
	Если ТипЗначенияПоля = Тип("СправочникСсылка.ИдентификаторыОбъектовМетаданных") Тогда	
		СтруктураРезультат.ВариантАнализа = "Роль";	
		СтруктураРезультат.АнализируемыйОбъект = ОбщегоНазначения.ПолучитьЗначениеРеквизита(
			ЗначениеПоля, "ПолноеИмя");
		СтруктураРезультат.Вставить("ПолноеИмяОбъекта", СтруктураРезультат.АнализируемыйОбъект);	
			
	ИначеЕсли ТипЗначенияПоля = Тип("СправочникСсылка.ПрофилиГруппДоступа") Тогда		
		СтруктураРезультат.ВариантАнализа = "Профиль";
		СтруктураРезультат.АнализируемыйОбъект = ЗначениеПоля;
			
	ИначеЕсли ТипЗначенияПоля = Тип("Строка") Тогда 
		
		МетаТаблица = Метаданные.НайтиПоПолномуИмени(ЗначениеПоля);
		Если МетаТаблица = Неопределено Тогда
			Возврат Неопределено;			
		КонецЕсли; 
		
		СтруктураРезультат.ВариантАнализа = "Объект";
		СтруктураРезультат.АнализируемыйОбъект = МетаТаблица.Имя;
		СтруктураРезультат.Вставить("ПолноеИмяОбъекта", МетаТаблица.ПолноеИмя());
	КонецЕсли; 
	
	СтруктураРезультат.Вставить("СформироватьПриОткрытии", Истина);
	
	Возврат СтруктураРезультат;	
	
КонецФункции
 
//==================================================================================== Уничкин_РА [20.03.2015 17:01:37]=
&НаСервере
Процедура сп_УстановитьНастройкиКомпоновщикаНаСервере()		
	ОбъектОтчета = РеквизитФормыВЗначение("Отчет");
	СКД = ОбъектОтчета.ПолучитьМакет("Макет");
	
	Если ВариантАнализа = "Пользователь" И ОтключитьАнализРолей Тогда
		ИмяНастройкиВарианта = "ПользовательБезАнализаРолей";	//Пользователь (с откл. анализом ролей)
	Иначе
		ИмяНастройкиВарианта = ВариантАнализа;
	КонецЕсли; 
	
	Если ПустаяСтрока(ИмяНастройкиВарианта) Тогда
		Возврат;		
	КонецЕсли; 
		
	НастройкаВарианта = СКД.ВариантыНастроек[ИмяНастройкиВарианта].Настройки;
	ОбъектОтчета.КомпоновщикНастроек.ЗагрузитьНастройки(НастройкаВарианта);	
	ЗначениеВРеквизитФормы(ОбъектОтчета, "Отчет");
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ: вызовы сервера обработчиков (св)

//==================================================================================== Уничкин_РА [03.06.2015 16:04:02]=
&НаСервере
Процедура ПриОткрытииНаСервере()

	сп_УстановитьНастройкиКомпоновщикаНаСервере();
	длг_УстановкаВидимостиЭлементовОтВариантаАнализаНаСервере();	
	длг_УстановкаВидимостиПолейРезультатовНаСервере();
	
КонецПроцедуры
 
//==================================================================================== Уничкин_РА [17.05.2015 0:29:38]=
&НаСервере
Процедура вс_СформироватьОтчетНаСервере()
	Перем ДанныеРасшифровкиСКД;
	
	ОтчетОбъект = РеквизитФормыВЗначение("Отчет");
	
	// Небольшой механизм кеширования набора данных:
	ФормироватьНаборДанных = Ложь;	
	Если ПустаяСтрока(АдресКэшаНабораДанных) Или ОчищатьКэшПередФормированием Тогда
		ФормироватьНаборДанных = Истина;		
	КонецЕсли; 
	Если НЕ ФормироватьНаборДанных Тогда
		тзПредварительныйНаборДанных = ПолучитьИзВременногоХранилища(АдресКэшаНабораДанных);
		Если тзПредварительныйНаборДанных = Неопределено Тогда
			ФормироватьНаборДанных = Истина;			
		КонецЕсли; 
	КонецЕсли; 
		
	СтруктураПараметров = Новый Структура(
		"ВариантАнализа, СписокЗначенийОтборПравДоступа, ОтключитьАнализРолей"
		, ВариантАнализа
		, СписокЗначенийОтборПравДоступа
		, ОтключитьАнализРолей);
		
	Если ВариантАнализа = "Объект" ИЛИ ВариантАнализа = "Роль" Тогда
		СтруктураПараметров.Вставить("АнализируемыйОбъект", ПолноеИмяОбъекта);
	Иначе
		СтруктураПараметров.Вставить("АнализируемыйОбъект", АнализируемыйОбъект);		
	КонецЕсли; 		
				
	Если ФормироватьНаборДанных Тогда		
		тзПредварительныйНаборДанных =  ОтчетОбъект.зт_ПредварительныйНаборДанных(СтруктураПараметров);
	КонецЕсли; 
	
	СтруктураПараметров.Вставить("тзПредварительныйНаборДанных", тзПредварительныйНаборДанных);
	
	тзНаборДанных = ОтчетОбъект.сп_ВыборкаПоПредварительномуНаборуДанных(СтруктураПараметров);
	
	АдресКэшаНабораДанных = ПоместитьВоВременноеХранилище(тзНаборДанных, УИД);
	
	ОтчетОбъект.ВременныйКэшНабораДанных = АдресКэшаНабораДАнных;
	ОтчетОбъект.СкомпоноватьРезультат(Результат1, ДанныеРасшифровкиСКД);

	Если ВариантАнализа = "Пользователь" И ОтключитьАнализРолей Тогда
		СтруктураПараметров = Новый Структура("АнализируемыйОбъект", АнализируемыйОбъект);
		до_АнализПользователяНаСервере(СтруктураПараметров, ОтчетОбъект);
		
	ИначеЕсли ВариантАнализа = "Объект" И Лев(ПолноеИмяОбъекта, 10) <> "Подсистема" Тогда
		
		до_АнализИнтерфейсногоПоложенияОбъектаНаСервере();		
		
	КонецЕсли; 
	
	ЗначениеВРеквизитФормы(ОтчетОбъект, "Отчет");
	
	ДанныеРасшифровкиРезультата1 = ПоместитьВоВременноеХранилище(ДанныеРасшифровкиСКД, УникальныйИдентификатор);
	ЭтаФорма.Заголовок = "АПД: " + Лев(ВариантАнализа, 1) + "; " + 
		АнализируемыйОбъект;					
			
КонецПроцедуры

//==================================================================================== Уничкин_РА [23.03.2015 12:32:18]=
&НаСервере
Процедура вс_ОбновитьИОМНаСервере()
	ЕстьИзменения = Ложь; ЕстьУдаленные = Ложь;
	Справочники.ИдентификаторыОбъектовМетаданных.ОбновитьДанныеСправочника(ЕстьИзменения, ЕстьУдаленные);
	Сообщить("Справочники.ИдентификаторыОбъектовМетаданных: есть изменения - " +
	ЕстьИзменения + ", есть удаленные - "+ ЕстьУдаленные + ".");
	
	ЕстьИзменения = Ложь;
	Константы.ПараметрыРаботыПользователей.СоздатьМенеджерЗначения().ОбновитьОбщиеПараметры(ЕстьИзменения);
	Сообщить("Константы.ПараметрыРаботыПользователей: есть изменения - " + ЕстьИзменения + " .");
КонецПроцедуры

//==================================================================================== Уничкин_РА [16.05.2015 23:48:25]=
&НаСервере
Процедура вс_ВариантАнализаПриИзмененииНаСервере()
	
	сп_УстановитьНастройкиКомпоновщикаНаСервере();
	длг_УстановкаВидимостиЭлементовОтВариантаАнализаНаСервере();	
	длг_УстановкаВидимостиПолейРезультатовНаСервере();	
	
КонецПроцедуры

//==================================================================================== Уничкин_РА [16.05.2015 23:51:41]=
&НаСервере
Процедура вс_ОтключитьАнализРолейПриИзмененииНаСервере()
	
	сп_УстановитьНастройкиКомпоновщикаНаСервере();
	длг_УстановкаВидимостиЭлементовОтВариантаАнализаНаСервере();	
	длг_УстановкаВидимостиПолейРезультатовНаСервере();		
	
КонецПроцедуры
 
//==================================================================================== Уничкин_РА [17.05.2015 0:15:29]=
&НаСервере
Процедура вс_ОбработкаВыбораНаСервере()
	
	сп_УстановитьНастройкиКомпоновщикаНаСервере();
	зт_НастройкаОтбораПоПравамДоступаНаСервере();	
	длг_УстановкаВидимостиПолейРезультатовНаСервере();	
	
КонецПроцедуры
 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ: дополнительные отчеты (до)

//==================================================================================== Уничкин_РА [03.06.2015 18:39:27]=
Процедура до_АнализПользователяНаСервере(СтруктураПараметров, ОтчетОбъект)
	МакетСКД = ОтчетОбъект.ПолучитьМакет("ДО_АнализПользователя");
	
	ПараметрыМакета = МакетСКД.Параметры;
	Для каждого Элем Из СтруктураПараметров Цикл
		ПараметрыМакета[Элем.Ключ].Значение = Элем.Значение;
	КонецЦикла; 
	
	Настройки = МакетСКД.НастройкиПоУмолчанию;
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;	
	ДанныеРасшифровки = Неопределено;
	МакетКомпоновкиДанных = КомпоновщикМакета.Выполнить(МакетСКД, Настройки, ДанныеРасшифровки);

	ДанныеРасшифровкиРезультата2  = ПоместитьВоВременноеХранилище(ДанныеРасшифровки, УИД);
	
	ПроцессорКомпоновкиДанных = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновкиДанных.Инициализировать(МакетКомпоновкиДанных, ,ДанныеРасшифровки);
	
	Результат2.Очистить();
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(Результат2);
	ПроцессорВывода.Вывести(ПроцессорКомпоновкиДанных, Истина);				
КонецПроцедуры

//==================================================================================== Уничкин_РА [17.06.2015 20:26:32]=
Процедура до_РекурсивнаяПроверкаУчастияОбъектаВСоставеПодсистем(КоллекцияПодсистем, тз, МетаОбъект)
	
	Для каждого Подсистема Из КоллекцияПодсистем Цикл
		Если Подсистема.Состав.Содержит(МетаОбъект) Тогда
			
			нс_Тек = тз.Добавить();
			нс_Тек.Мета = Подсистема;
			нс_Тек.ПодчиненныйЭлементСодержитОбъект = Ложь;
			нс_Тек.ТекущийЭлементСодержитОбъект = Истина;
			
			
			ИндексСтроки = тз.Индекс(нс_Тек);
			
			КоличествоРодителей = 0;
			ТекРодитель = Подсистема.Родитель();
			Пока ТипЗнч(ТекРодитель) <> Тип("ОбъектМетаданныхКонфигурация") Цикл			
				
				стр_тз = тз.Найти(ТекРодитель, "Мета");
				Если стр_тз = Неопределено Тогда
					стр_тз = тз.Вставить(ИндексСтроки);
					стр_тз.Мета = ТекРодитель;
					стр_тз.ПодчиненныйЭлементСодержитОбъект = Истина;	
					стр_тз.ТекущийЭлементСодержитОбъект = Ложь;
				Иначе	
					ТекИнд = тз.Индекс(стр_тз);
					Смещение = ИндексСтроки - 1 - ТекИнд;
					Если Смещение <> 0 Тогда
						тз.Сдвинуть(стр_тз, Смещение);						
					КонецЕсли; 
				КонецЕсли;
				
				ИндексСтроки = тз.Индекс(стр_тз);
				КоличествоРодителей = КоличествоРодителей + 1;			
				ТекРодитель = ТекРодитель.Родитель();
			КонецЦикла; 
			
			ИндексСтроки = тз.Индекс(нс_Тек);
			НачалоДиапазона = ИндексСтроки - КоличествоРодителей;
			УровеньОтступа = 0;
			Для сч = НачалоДиапазона По ИндексСтроки Цикл
				УровеньОтступа = УровеньОтступа + 1;
				тз[сч].Отступ = УровеньОтступа;	
			КонецЦикла; 

		КонецЕсли; 		
		
		до_РекурсивнаяПроверкаУчастияОбъектаВСоставеПодсистем(Подсистема.Подсистемы, тз, МетаОбъект);
	КонецЦикла; 
		
КонецПроцедуры
 
//==================================================================================== Уничкин_РА [17.06.2015 20:18:58]=
Процедура до_АнализИнтерфейсногоПоложенияОбъектаНаСервере()
	
	Результат2.Очистить();
	
	МетаОбъект = Метаданные.НайтиПоПолномуИмени(ПолноеИмяОбъекта);
	
	тз = Новый ТаблицаЗначений;
	тз.Колонки.Добавить("Мета");
	тз.Колонки.Добавить("ПодчиненныйЭлементСодержитОбъект");
	тз.Колонки.Добавить("ТекущийЭлементСодержитОбъект");
	тз.Колонки.Добавить("Отступ", Новый ОписаниеТипов("Число"));
		
	// Получаю список подсистем, в которых находится данный объект:
	до_РекурсивнаяПроверкаУчастияОбъектаВСоставеПодсистем(Метаданные.Подсистемы, тз, МетаОбъект);
	
	Макет = РеквизитФормыВЗначение("Отчет").ПолучитьМакет("до_АнализИнтерфейсногоПоложенияОбъекта");
	
	обл_Заголовок = Макет.ПолучитьОбласть("Заголовок");
	обл_Легенда = Макет.ПолучитьОбласть("Легенда"); 
	
	Результат2.Вывести(обл_Заголовок);
	Результат2.ФиксацияСверху = 1;
	
	Для каждого стр_тз Из тз Цикл
		стр_тз.Отступ = стр_тз.Отступ - 1;
		обл_Строка = Макет.ПолучитьОбласть("Строка" + стр_тз.Отступ);		
		обл_Строка.Параметры.СинонимПодсистемы = стр_тз.Мета.Синоним + " \ " + стр_тз.Мета.Имя;
		
		н1 = стр_тз.Отступ + 1; 
		
		обл_Строка.Область(1, н1, 1, н1).ЦветФона = ?(стр_тз.Мета.ВключатьВКомандныйИнтерфейс , WebЦвета.Желтый, WebЦвета.Белый);
		обл_Строка.Область(1, 6, 1, 6).ЦветФона = ?(стр_тз.ТекущийЭлементСодержитОбъект, WebЦвета.Киноварь, WebЦвета.Черный);

		Результат2.Вывести(обл_Строка);
	КонецЦикла; 
	
	Результат2.Вывести(обл_Легенда);
	
КонецПроцедуры
 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ: новые строки таблиц (нс)

//==================================================================================== Уничкин_РА [22.03.2015 21:24:28]=
&НаСервере
Процедура нс_ПОСИОМ(тз, МетаТаблица, ПолноеИмя, НаименованиеРодителя, Наименование)
	
	НовСтр = тз.Добавить();
	НовСтр.Имя = МетаТаблица.Имя;
	НовСтр.Синоним = МетаТаблица.Синоним;
	НовСтр.ПолноеИмя = ПолноеИмя;
	НовСтр.Наименование = Наименование;
	НовСтр.НаименованиеРодителя = НаименованиеРодителя;
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ: структуры временных таблиц (свт)
 
//==================================================================================== Уничкин_РА [22.03.2015 21:21:11]=
&НаСервере
Функция свт_ПроверяемыеОбъектыИОМ_ТаблицаЗначений()
	
	ОписаниеСтроки = Новый ОписаниеТипов("Строка", ,,, Новый КвалификаторыСтроки(100));
	
	тз = Новый ТаблицаЗначений;
	тз.Колонки.Добавить("Наименование", ОписаниеСтроки);
	тз.Колонки.Добавить("Имя", ОписаниеСтроки);
	тз.Колонки.Добавить("Синоним", ОписаниеСтроки);
	тз.Колонки.Добавить("ПолноеИмя", ОписаниеСтроки);
	тз.Колонки.Добавить("НаименованиеРодителя", ОписаниеСтроки);
	
	Возврат тз;
КонецФункции

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ: заполнение таблиц (зт)

//==================================================================================== Уничкин_РА [24.03.2015 9:43:25]=
&НаСервере
Процедура зт_НастройкаОтбораПоПравамДоступаНаСервере()
	
	Элементы.НастройкаОтборапоПравамДоступа.Доступность = Истина;
	
	ОтчетОбъект = РеквизитФормыВЗначение("Отчет");
	
	дз = ОтчетОбъект.зт_ОбъектыПравДоступа();
	СписокЗначенийОтборПравДоступа.Очистить();
		
	Если ВариантАнализа = "Объект" Тогда
		
		ВидПоля = ОтчетОбъект.пп_ВидыПроверяемыхПолей().О;

		ПолноеИмя = АнализируемыйОбъект;
		поз = Найти(ПолноеИмя, "."); 
		
		Если Поз > 0 Тогда
			ВидТаблицы = Лев(ПолноеИмя, поз - 1);
		Иначе
			ВидТаблицы = ПолноеИмя;
		КонецЕсли; 		
		
		Поиск = Новый Структура("ВидТаблицы, ВидПоля", ВидТаблицы, ВидПоля);
		МассивСтрок = дз.Строки.НайтиСтроки(Поиск, Истина);		
		
		Для каждого стр_ур2 Из МассивСтрок Цикл
			Для каждого стр_ур3 Из стр_ур2.Строки Цикл	
				СписокЗначенийОтборПравДоступа.Добавить(стр_ур3.ПравоДоступа, , Истина);				
			КонецЦикла; 
		КонецЦикла; 
	Иначе	
		
		Поиск = Новый Структура("ВидТаблицы, ВидПоля", Неопределено, Неопределено);
		МассивСтрок = дз.Строки.НайтиСтроки(Поиск, Истина);		
		
		Для каждого стр_ур3 Из МассивСтрок Цикл
			Элем = СписокЗначенийОтборПравДоступа.НайтиПоЗначению(стр_ур3.ПравоДоступа);
			
			Если Элем = Неопределено Тогда
				СписокЗначенийОтборПравДоступа.Добавить(стр_ур3.ПравоДоступа, , Истина);	
			КонецЕсли; 
			
		КонецЦикла; 

	КонецЕсли; 
	
	СписокЗначенийОтборПравДоступа.СортироватьПоПредставлению();
	
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ: диалоговые (длг)

//==================================================================================== Уничкин_РА [16.05.2015 22:47:25]=
&НаСервере
Процедура длг_УстановкаВидимостиЭлементовОтВариантаАнализаНаСервере()
	
	Элементы.ОтключитьАнализРолей.Видимость = ВариантАнализа = "Пользователь"; 		
	
КонецПроцедуры

 //==================================================================================== Уничкин_РА [16.05.2015 23:45:31]=
&НаСервере
Процедура длг_УстановкаВидимостиПолейРезультатовНаСервере()
	
	Элементы.Результат2.Видимость = ВариантАнализа = "Пользователь" И ОтключитьАнализРолей;
	Элементы.Результат2.Видимость = ВариантАнализа = "Объект" 
		И Лев(ПолноеИмяОбъекта, 10) <> "Подсистема" И ПолноеИмяОбъекта <> "Конфигурация";
	
КонецПроцедуры









