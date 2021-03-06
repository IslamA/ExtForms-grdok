﻿
Функция СведенияОВнешнейОбработке() Экспорт
	
	ПараметрыРегистрации = Новый Структура;
	
	МассивНазначений = Новый Массив;
	МассивНазначений.Добавить("Документ.КадровыйПеревод"); //Указываем документ к которому делаем внешнюю печ. форму
	
	ПараметрыРегистрации.Вставить("Вид",             "ПечатнаяФорма"); //может быть – ПечатнаяФорма, ЗаполнениеОбъекта, ДополнительныйОтчет, СозданиеСвязанныхОбъектов…
	ПараметрыРегистрации.Вставить("Назначение",      МассивНазначений);
	ПараметрыРегистрации.Вставить("Наименование",    Метаданные().Представление()); //имя под которым обработка будет зарегестрирована в справочнике внешних обработок
	ПараметрыРегистрации.Вставить("БезопасныйРежим", Ложь);
	ПараметрыРегистрации.Вставить("Версия",          Метаданные().Комментарий);
	ПараметрыРегистрации.Вставить("Информация",      "");
	
	ТаблицаКоманд = ПолучитьТаблицуКоманд();
	ДобавитьКоманду(ТаблицаКоманд, "Договор о полной индивидуальной матответственности (Внешний)", "ПФ_MXL_Договор_О_ПолнойИндивидуальнойМатответственности", "ВызовСерверногоМетода", Истина, "ПечатьMXL");
	ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд);
		
	Возврат ПараметрыРегистрации;	
		
КонецФункции

Функция ПолучитьТаблицуКоманд()
	
	Команды = Новый ТаблицаЗначений;
	Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));//как будет выглядеть описание печ.формы для пользователя
	Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка")); //имя макета печ.формы
	Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка")); //ВызовСерверногоМетода
	Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево"));
	Команды.Колонки.Добавить("Модификатор", Новый ОписаниеТипов("Строка"));
	Возврат Команды;
	
КонецФункции

Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")
	
	НоваяКоманда = ТаблицаКоманд.Добавить();
	НоваяКоманда.Представление = Представление;
	НоваяКоманда.Идентификатор = Идентификатор;
	НоваяКоманда.Использование = Использование;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение;
	НоваяКоманда.Модификатор = Модификатор;
	
КонецПроцедуры

// Сформировать печатные формы объектов.
//
// ВХОДЯЩИЕ:
//   МассивОбъектов  - Массив    - Массив ссылок на объекты которые нужно распечатать.
//
// ИСХОДЯЩИЕ:
//   КоллекцияПечатныхФорм - Таблица значений - Сформированные табличные документы.
//   ОшибкиПечати          - Список значений  - Ошибки печати  (значение - ссылка на объект, представление - текст
//                           ошибки).
//   ОбъектыПечати         - Список значений  - Объекты печати (значение - ссылка на объект, представление - имя
//                           области в которой был выведен объект).
//   ПараметрыВывода       - Структура        - Параметры сформированных табличных документов.
//
Процедура Печать(МассивОбъектов, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	ПараметрыВывода.ДоступнаПечатьПоКомплектно = Истина;
	
	ПодходящиеОбъекты = Новый Массив;
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ПФ_MXL_Договор_О_ПолнойИндивидуальнойМатответственности") Тогда
		
		Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ПФ_MXL_Договор_О_ПолнойИндивидуальнойМатответственности") Тогда
			ИмяМакета = "ПФ_MXL_Договор_О_ПолнойИндивидуальнойМатответственности";
			Представление = НСтр("ru='Договор о полной индивидуальной матответственности'");
		КонецЕсли;
		
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
			КоллекцияПечатныхФорм,
			ИмяМакета, Представление,
			ТабличныйДокументТрудовойДоговор(
				ИмяМакета,
				МассивОбъектов,
				ОбъектыПечати),
			,
			"Обработка.ПечатьКадровыхПриказовРасширенная." + ИмяМакета);
				
	КонецЕсли;
	
	
КонецПроцедуры

Функция ТабличныйДокументТрудовойДоговор(ИмяМакета, МассивОбъектов, ОбъектыПечати)
	
	Макет = УправлениеПечатью.МакетПечатнойФормы("Обработка.ПечатьКадровыхПриказовРасширенная." + ИмяМакета);
	
	ДокументРезультат = Новый ТабличныйДокумент;
	НомерСтрокиНачало = ДокументРезультат.ВысотаТаблицы + 1;
	
	ДокументРезультат.КлючПараметровПечати = "ПараметрыПечати_"+ИмяМакета;
	МассивДанныхЗаполнения = ДанныеДляПечатиТрудовогоДоговора(МассивОбъектов, ИмяМакета);
	
	ПервыйПриказ = Истина;
	Для каждого ПараметрыМакета Из МассивДанныхЗаполнения Цикл
		
		Если Не ПервыйПриказ Тогда
			ДокументРезультат.ВывестиГоризонтальныйРазделительСтраниц();
		Иначе
			ПервыйПриказ = Ложь;
		КонецЕсли;
		
		НомерСтрокиНачало = ДокументРезультат.ВысотаТаблицы + 1;
		
		ОбластьЧасть10 = Макет.ПолучитьОбласть("Часть10");
		ОбластьЧасть10.Параметры.Заполнить(ПараметрыМакета);
		ДокументРезультат.Вывести(ОбластьЧасть10);
		
		//Зыков+
		//Если ПараметрыМакета.Страна <> Справочники.СтраныМира.Россия Тогда
		//	
		//	ОбластьСведенияИностранцев = Макет.ПолучитьОбласть("СведенияИностранцев");
		//	ОбластьСведенияИностранцев.Параметры.Заполнить(ПараметрыМакета);
		//	ДокументРезультат.Вывести(ОбластьСведенияИностранцев);
		//	
		//КонецЕсли; 
		//Зыков-
		
		ОбластьЧасть20 = Макет.ПолучитьОбласть("Часть20");
		ОбластьЧасть20.Параметры.Заполнить(ПараметрыМакета);
		ДокументРезультат.Вывести(ОбластьЧасть20);
		
		//Зыков+
		Колонтиктул = ДокументРезультат.НижнийКолонтитул;
		Колонтиктул.Выводить = Истина;
		Колонтиктул.ВертикальноеПоложение = ВертикальноеПоложение.Низ;
		Колонтиктул.НачальнаяСтраница = 1;
		Колонтиктул.ТекстСлева = "Работодаталь____________________";
		Колонтиктул.ТекстСправа= "Работник____________________";
		//Зыков-
		
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ДокументРезультат, НомерСтрокиНачало, ОбъектыПечати, ПараметрыМакета.Ссылка);
		
	КонецЦикла;
	
	Возврат ДокументРезультат;
	
КонецФункции

Процедура СоздатьВТОбщиеДанныеСправок(МенеджерВременныхТаблиц, МассивОбъектов)
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Запрос.УстановитьПараметр("Период", ТекущаяДатаСеанса());
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	
	Запрос.Текст =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	&Период,
		|	Сотрудники.Ссылка КАК Сотрудник
		|ПОМЕСТИТЬ ВТСотрудникиПериоды
		|ИЗ
		|	Справочник.Сотрудники КАК Сотрудники
		|ГДЕ
		|	Сотрудники.Ссылка В(&МассивОбъектов)";
		
	Запрос.Выполнить();
	
	ОписательВременныхТаблиц = КадровыйУчет.ОписательВременныхТаблицДляСоздатьВТКадровыеДанныеСотрудников(
		Запрос.МенеджерВременныхТаблиц,
		"ВТСотрудникиПериоды");
	
	КадровыеДанные = "ФизическоеЛицо,ФИОПолные,Пол,ДокументПредставление,ДатаПриема,ДатаУвольнения,Должность,ГоловнаяОрганизация";
	
	КадровыйУчет.СоздатьВТКадровыеДанныеСотрудников(ОписательВременныхТаблиц, Истина, КадровыеДанные);
	
	Запрос.Текст =
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	КадровыеДанные.Период КАК Период,
		|	КадровыеДанные.ГоловнаяОрганизация КАК Организация
		|ИЗ
		|	ВТКадровыеДанныеСотрудников КАК КадровыеДанные";
		
	СведенияОбОрганизациях = Новый ТаблицаЗначений;
	СведенияОбОрганизациях.Колонки.Добавить("Организация", Новый ОписаниеТипов("СправочникСсылка.Организации"));
	СведенияОбОрганизациях.Колонки.Добавить("Период", Новый ОписаниеТипов("Дата"));
	СведенияОбОрганизациях.Колонки.Добавить("НаименованиеПолное", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("ИНН", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("АдресЮридический", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("АдресФактический", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("ОрганизацияГородФактическогоАдреса", Новый ОписаниеТипов("Строка"));
	
	СведенияОбОрганизациях.Колонки.Добавить("ОрганизацияРасчетныйСчет", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("ОрганизацияБанк", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("ОрганизацияКорСчет", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("ОрганизацияБИК", Новый ОписаниеТипов("Строка"));
	
	СведенияОбОрганизациях.Колонки.Добавить("ОрганизацияТелефон", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("ОрганизацияФакс", Новый ОписаниеТипов("Строка"));
	
	СведенияОбОрганизациях.Колонки.Добавить("ФИОРуководителя", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("ФИОГлавногоБухгалтера", Новый ОписаниеТипов("Строка"));
	
	РезультатЗапросаПоШапке = Запрос.Выполнить();
	АдресаОрганизаций = УправлениеКонтактнойИнформациейЗарплатаКадры.АдресаОрганизаций(РезультатЗапросаПоШапке.Выгрузить().ВыгрузитьКолонку("Организация"));
	
	Выборка = РезультатЗапросаПоШапке.Выбрать();
	Пока Выборка.Следующий() Цикл
		
		НоваяСтрокаСведенияОбОрганизациях = СведенияОбОрганизациях.Добавить();
		
		Сведения = Новый СписокЗначений;
		Сведения.Добавить("", "НаимЮЛПол");
		Сведения.Добавить("", "ИННЮЛ");
	
		Сведения.Добавить("", "БанкСчетНомер");
		Сведения.Добавить("", "БанкСчетНаимБанка");
		Сведения.Добавить("", "БанкСчетКоррСчетБанка");
		Сведения.Добавить("", "БанкСчетБИКБанка");
		
		Сведения.Добавить("", "ТелОрганизации");
		Сведения.Добавить("", "ФаксОрганизации");
		
		Сведения.Добавить("", "ФИОРук");
		Сведения.Добавить("", "ФИОБух");
		
		ОргСведения = РегламентированнаяОтчетностьВызовСервера.ПолучитьСведенияОбОрганизации(Выборка.Организация, ?(ЗначениеЗаполнено(Выборка.Период),Выборка.Период, ТекущаяДатаСеанса()), Сведения);
		
		НоваяСтрокаСведенияОбОрганизациях.Организация = Выборка.Организация;
		НоваяСтрокаСведенияОбОрганизациях.Период = Выборка.Период;
		НоваяСтрокаСведенияОбОрганизациях.НаименованиеПолное = ОргСведения.НаимЮЛПол;
		НоваяСтрокаСведенияОбОрганизациях.ИНН = ОргСведения.ИННЮЛ;
		
		ОписаниеЮридическогоАдреса = УправлениеКонтактнойИнформациейЗарплатаКадры.АдресОрганизации(
			АдресаОрганизаций,
			Выборка.Организация,
			Справочники.ВидыКонтактнойИнформации.ЮрАдресОрганизации);
		НоваяСтрокаСведенияОбОрганизациях.АдресЮридический = ОписаниеЮридическогоАдреса.Представление;
		
		ОписаниеФактическогоАдреса = УправлениеКонтактнойИнформациейЗарплатаКадры.АдресОрганизации(
			АдресаОрганизаций,
			Выборка.Организация,
			Справочники.ВидыКонтактнойИнформации.ФактАдресОрганизации);
		НоваяСтрокаСведенияОбОрганизациях.АдресФактический = ОписаниеФактическогоАдреса.Представление;
		НоваяСтрокаСведенияОбОрганизациях.ОрганизацияГородФактическогоАдреса = ОписаниеФактическогоАдреса.Город;
		
		БанковскийСчет = ПолучитьОсновнойБанковскийСчет(Выборка.Организация);
		
		НоваяСтрокаСведенияОбОрганизациях.ОрганизацияРасчетныйСчет = БанковскийСчет.НомерСчета;
		НоваяСтрокаСведенияОбОрганизациях.ОрганизацияБанк = БанковскийСчет.Банк.Наименование;
		НоваяСтрокаСведенияОбОрганизациях.ОрганизацияКорСчет = БанковскийСчет.Банк.КоррСчет;
		НоваяСтрокаСведенияОбОрганизациях.ОрганизацияБИК = БанковскийСчет.Банк.Код;
		
		НоваяСтрокаСведенияОбОрганизациях.ОрганизацияТелефон = ОргСведения.ТелОрганизации;
		НоваяСтрокаСведенияОбОрганизациях.ОрганизацияФакс = ОргСведения.ФаксОрганизации;
		
		НоваяСтрокаСведенияОбОрганизациях.ФИОРуководителя = ОргСведения.ФИОРук;
		НоваяСтрокаСведенияОбОрганизациях.ФИОГлавногоБухгалтера = ОргСведения.ФИОБух;
		
	КонецЦикла;
	
	Запрос.УстановитьПараметр("СведенияОбОрганизациях", СведенияОбОрганизациях);
	
	Запрос.Текст =
		"ВЫБРАТЬ
		|	СведенияОбОрганизациях.Период,
		|	СведенияОбОрганизациях.Организация,
		|	СведенияОбОрганизациях.НаименованиеПолное КАК ОрганизацияНаименованиеПолное,
		|	СведенияОбОрганизациях.ИНН КАК ОрганизацияИНН,
		|	СведенияОбОрганизациях.АдресЮридический КАК ОрганизацияАдресЮридический,
		|	СведенияОбОрганизациях.АдресФактический КАК ОрганизацияАдресФактический,
		|	СведенияОбОрганизациях.ОрганизацияГородФактическогоАдреса КАК ОрганизацияГородФактическогоАдреса,
		|	СведенияОбОрганизациях.ОрганизацияРасчетныйСчет КАК ОрганизацияРасчетныйСчет,
		|	СведенияОбОрганизациях.ОрганизацияБанк КАК ОрганизацияБанк,
		|	СведенияОбОрганизациях.ОрганизацияКорСчет КАК ОрганизацияКорСчет,
		|	СведенияОбОрганизациях.ОрганизацияБИК КАК ОрганизацияБИК,
		|	СведенияОбОрганизациях.ОрганизацияТелефон КАК ОрганизацияТелефон,
		|	СведенияОбОрганизациях.ОрганизацияФакс КАК ОрганизацияФакс,
		|	СведенияОбОрганизациях.ФИОРуководителя КАК ФИОРуководителя,
		|	СведенияОбОрганизациях.ФИОГлавногоБухгалтера КАК ФИОГлавногоБухгалтера
		|ПОМЕСТИТЬ ВТДанныеОрганизаций
		|ИЗ
		|	&СведенияОбОрганизациях КАК СведенияОбОрганизациях
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ДанныеОрганизаций.Период,
		|	ДанныеОрганизаций.Период КАК ДатаСправки,
		|	ДанныеОрганизаций.Организация,
		|	ДанныеОрганизаций.ОрганизацияНаименованиеПолное,
		|	ДанныеОрганизаций.ОрганизацияИНН,
		|	ДанныеОрганизаций.ОрганизацияАдресЮридический,
		|	ДанныеОрганизаций.ОрганизацияАдресФактический,
		|	ДанныеОрганизаций.ОрганизацияГородФактическогоАдреса,
		|	ДанныеОрганизаций.ОрганизацияРасчетныйСчет,
		|	ДанныеОрганизаций.ОрганизацияБанк,
		|	ДанныеОрганизаций.ОрганизацияКорСчет,
		|	ДанныеОрганизаций.ОрганизацияБИК КАК ОрганизацияБИК,
		|	ДанныеОрганизаций.ОрганизацияТелефон,
		|	ДанныеОрганизаций.ОрганизацияФакс,
		|	ДанныеОрганизаций.ФИОРуководителя,
		|	ДанныеОрганизаций.ФИОГлавногоБухгалтера,
		|	КадровыеДанныеСотрудников.ГоловнаяОрганизация,
		|	КадровыеДанныеСотрудников.Сотрудник КАК Ссылка,
		|	КадровыеДанныеСотрудников.ФизическоеЛицо,
		|	КадровыеДанныеСотрудников.ДатаПриема,
		|	КадровыеДанныеСотрудников.Должность,
		|	КадровыеДанныеСотрудников.ФИОПолные,
		|	КадровыеДанныеСотрудников.Пол
		|ПОМЕСТИТЬ ВТОбщиеДанныеСправок
		|ИЗ
		|	ВТКадровыеДанныеСотрудников КАК КадровыеДанныеСотрудников
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТДанныеОрганизаций КАК ДанныеОрганизаций
		|		ПО (ДанныеОрганизаций.Период = КадровыеДанныеСотрудников.Период)
		|			И (ДанныеОрганизаций.Организация = КадровыеДанныеСотрудников.ГоловнаяОрганизация)";
		
	Запрос.Выполнить();
	
КонецПроцедуры

Функция ПолучитьОсновнойБанковскийСчет(Организация)
	
	Если Организация.ИНН = "5921026481" Тогда      // ПЛПК ООО
		
		Возврат Справочники.БанковскиеСчетаОрганизаций.НайтиПоНаименованию("ВТБ 24 (ЗАО) (Расчетный-РУБЛИ)");
		
	ИначеЕсли Организация.ИНН = "6316113996" Тогда // Капитал-3 ООО	
		
		Возврат Справочники.БанковскиеСчетаОрганизаций.НайтиПоНаименованию("ВТБ 24 (ПАО), Капитал-3 ООО (руб.)");
		
	Иначе
		
		Возврат Справочники.БанковскиеСчетаОрганизаций.ПустаяСсылка();
		
	КонецЕсли;	
	
КонецФункции	

Функция ДанныеДляПечатиТрудовогоДоговора(МассивОбъектов, ИмяМакета)
	
	МассивПараметров = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	
	Запрос.Текст =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	Док.Номер КАК Номер,
		|	Док.Дата КАК Дата,
		|	Док.Номер КАК ПриказОПриемеНомер,
		|	Док.Дата КАК ПриказОПриемеДата,
		|	Док.Дата КАК ДатаПриема,
		|   ДАТАВРЕМЯ(1, 1, 1) КАК ДатаЗавершенияТрудовогоДоговора,
		|	Док.Организация.НаименованиеПолное КАК ОрганизацияНаименованиеПолное,
		|	Док.Организация.НаименованиеСокращенное КАК ОрганизацияНаименованиеСокращенное,
		|	Док.Сотрудник,
		|	Док.Должность,
		|	Док.Подразделение,
		|	Док.ВидЗанятости,
		|	Док.ТрудовойДоговорНомер,
		|	Док.ТрудовойДоговорДата,
		|	Док.Руководитель,
		|	Док.ДолжностьРуководителя,
		|	Док.Ссылка,
		|	Док.Организация,
		|	Док.ОснованиеПредставителяНанимателя,
		|	Док.ОборудованиеРабочегоМеста,
		|	Док.ИныеУсловияДоговора,
		|	Док.КоличествоСтавок,
		|	""""  КАК РазрешениеНаРаботу,
		|	""""  КАК РазрешениеНаПроживание,
		|	""""  КАК УсловияОказанияМедПомощи
		|ПОМЕСТИТЬ ВТДанныеПриказаОПриеме
		|ИЗ
		|	Документ.КадровыйПеревод КАК Док
		|ГДЕ
		|	Док.Ссылка В(&МассивОбъектов)
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		|	ДанныеПриказаОПриеме.Сотрудник,
		|	ДанныеПриказаОПриеме.ДатаПриема КАК Период
		|ПОМЕСТИТЬ ВТСотрудникиПериоды
		|ИЗ
		|	ВТДанныеПриказаОПриеме КАК ДанныеПриказаОПриеме
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ДанныеПриказаОПриеме.Руководитель КАК ФизическоеЛицо,
		|	ДанныеПриказаОПриеме.ДатаПриема КАК Период
		|ПОМЕСТИТЬ ВТФизическиеЛицаПериоды
		|ИЗ
		|	ВТДанныеПриказаОПриеме КАК ДанныеПриказаОПриеме";
	
	Запрос.Выполнить();
	
	// Получение кадровых данных сотрудника.
	ОписательВременныхТаблиц = КадровыйУчет.ОписательВременныхТаблицДляСоздатьВТКадровыеДанныеСотрудников(
		Запрос.МенеджерВременныхТаблиц,
		"ВТСотрудникиПериоды");
	КадровыеДанные = "ФИОПолные,ФамилияИО,АдресПоПропискеПредставление,ДокументПредставление,Пол,Страна,КоличествоДнейОтпускаОбщее,КлассУсловийТруда";
	КадровыйУчет.СоздатьВТКадровыеДанныеСотрудников(ОписательВременныхТаблиц, Истина, КадровыеДанные);
	
	// Получение ФИО руководителей.
	ОписательВременныхТаблиц = КадровыйУчет.ОписательВременныхТаблицДляСоздатьВТКадровыеДанныеФизическихЛиц(
		Запрос.МенеджерВременныхТаблиц,
		"ВТФизическиеЛицаПериоды");
	КадровыеДанные = "ФИОПолные,ФамилияИО,Пол";
	КадровыйУчет.СоздатьВТКадровыеДанныеФизическихЛиц(ОписательВременныхТаблиц, Истина, КадровыеДанные);
	
	ТаблицаНачислений = КадровыйУчет.ТаблицаНачисленийСотрудниковПоВременнойТаблице(Запрос.МенеджерВременныхТаблиц, "ВТСотрудникиПериоды", , , , Ложь, Истина);
	
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ДанныеПриказаОПриеме.Организация,
		|	ДанныеПриказаОПриеме.ПриказОПриемеДата КАК Период
		|ИЗ
		|	ВТДанныеПриказаОПриеме КАК ДанныеПриказаОПриеме";
	
	СведенияОбОрганизациях = Новый ТаблицаЗначений;
	СведенияОбОрганизациях.Колонки.Добавить("Организация", Новый ОписаниеТипов("СправочникСсылка.Организации"));
	СведенияОбОрганизациях.Колонки.Добавить("Период", Новый ОписаниеТипов("Дата"));
	СведенияОбОрганизациях.Колонки.Добавить("НаименованиеПолное", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("ИНН", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("КПП", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("ТелефонОрганизации", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("ФаксОрганизации", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("АдресЮридический", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("АдресФактический", Новый ОписаниеТипов("Строка"));
	СведенияОбОрганизациях.Колонки.Добавить("ОрганизацияГородФактическогоАдреса", Новый ОписаниеТипов("Строка"));
	
	РезультатЗапросаПоШапке = Запрос.Выполнить();
	
	АдресаОрганизаций = УправлениеКонтактнойИнформациейЗарплатаКадры.АдресаОрганизаций(РезультатЗапросаПоШапке.Выгрузить().ВыгрузитьКолонку("Организация"));
	
	Выборка = РезультатЗапросаПоШапке.Выбрать();
	Пока Выборка.Следующий() Цикл
		
		НоваяСтрокаСведенияОбОрганизациях = СведенияОбОрганизациях.Добавить();
		
		Сведения = Новый СписокЗначений;
		Сведения.Добавить("", "НаимЮЛПол");
		Сведения.Добавить("", "ИННЮЛ");
		Сведения.Добавить("", "КППЮЛ");
		Сведения.Добавить("", "ТелОрганизации");
		Сведения.Добавить("", "ФаксОрганизации");
		
		УстановитьПривилегированныйРежим(Истина);
		ОргСведения = РегламентированнаяОтчетностьВызовСервера.ПолучитьСведенияОбОрганизации(Выборка.Организация, Выборка.Период, Сведения);
		УстановитьПривилегированныйРежим(Ложь);
		
		НоваяСтрокаСведенияОбОрганизациях.Организация = Выборка.Организация;
		НоваяСтрокаСведенияОбОрганизациях.Период = Выборка.Период;
		НоваяСтрокаСведенияОбОрганизациях.НаименованиеПолное = ОргСведения.НаимЮЛПол;
		НоваяСтрокаСведенияОбОрганизациях.ИНН = ОргСведения.ИННЮЛ;
		НоваяСтрокаСведенияОбОрганизациях.КПП = ОргСведения.КППЮЛ;
		НоваяСтрокаСведенияОбОрганизациях.ТелефонОрганизации = ОргСведения.ТелОрганизации;
		НоваяСтрокаСведенияОбОрганизациях.ФаксОрганизации = ОргСведения.ФаксОрганизации;
		
		ОписаниеЮридическогоАдреса = УправлениеКонтактнойИнформациейЗарплатаКадры.АдресОрганизации(
			АдресаОрганизаций,
			Выборка.Организация,
			Справочники.ВидыКонтактнойИнформации.ЮрАдресОрганизации);
		НоваяСтрокаСведенияОбОрганизациях.АдресЮридический = ОписаниеЮридическогоАдреса.Представление;
		
		ОписаниеФактическогоАдреса = УправлениеКонтактнойИнформациейЗарплатаКадры.АдресОрганизации(
			АдресаОрганизаций,
			Выборка.Организация,
			Справочники.ВидыКонтактнойИнформации.ФактАдресОрганизации);
		НоваяСтрокаСведенияОбОрганизациях.АдресФактический = ОписаниеФактическогоАдреса.Представление;
		НоваяСтрокаСведенияОбОрганизациях.ОрганизацияГородФактическогоАдреса = ОписаниеФактическогоАдреса.Город;
		
	КонецЦикла;
	
	Запрос.УстановитьПараметр("СведенияОбОрганизациях", СведенияОбОрганизациях);
	
	Запрос.Текст =
		"ВЫБРАТЬ
		|	СведенияОбОрганизациях.Период,
		|	СведенияОбОрганизациях.Организация,
		|	СведенияОбОрганизациях.НаименованиеПолное КАК ОрганизацияНаименованиеПолное,
		|	СведенияОбОрганизациях.ИНН КАК ИНН,
		|	СведенияОбОрганизациях.КПП КАК КПП,
		|	СведенияОбОрганизациях.ТелефонОрганизации КАК ТелефонОрганизации,
		|	СведенияОбОрганизациях.ФаксОрганизации КАК ФаксОрганизации,
		|	СведенияОбОрганизациях.АдресЮридический КАК ОрганизацияАдресЮридический,
		|	СведенияОбОрганизациях.АдресФактический КАК ОрганизацияАдресФактический,
		|	СведенияОбОрганизациях.ОрганизацияГородФактическогоАдреса КАК ОрганизацияГородФактическогоАдреса
		|ПОМЕСТИТЬ ВТДанныеОрганизаций
		|ИЗ
		|	&СведенияОбОрганизациях КАК СведенияОбОрганизациях
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ДанныеПриказаОПриеме.Ссылка,
		|	ДанныеПриказаОПриеме.ПриказОПриемеНомер,
		|	ДанныеПриказаОПриеме.ПриказОПриемеДата,
		|	ДанныеПриказаОПриеме.Подразделение,
		|	ДанныеПриказаОПриеме.Должность,
		|	ДанныеПриказаОПриеме.Сотрудник,
		|	ДанныеПриказаОПриеме.ВидЗанятости,
		|	ДанныеПриказаОПриеме.ТрудовойДоговорНомер,
		|	ДанныеПриказаОПриеме.ТрудовойДоговорДата,
		|	ДанныеПриказаОПриеме.ДолжностьРуководителя КАК РуководительДолжность,
		|	ДанныеПриказаОПриеме.ДатаПриема,
		|	ДанныеПриказаОПриеме.ДатаЗавершенияТрудовогоДоговора,
		|	ВЫБОР
		|		КОГДА КадровыеДанныеСотрудников.Страна = ЗНАЧЕНИЕ(Справочник.СтраныМира.Россия)
		|			ТОГДА """"
		|		ИНАЧЕ ДанныеПриказаОПриеме.РазрешениеНаРаботу
		|	КОНЕЦ КАК РазрешениеНаРаботу,
		|	ВЫБОР
		|		КОГДА КадровыеДанныеСотрудников.Страна = ЗНАЧЕНИЕ(Справочник.СтраныМира.Россия)
		|			ТОГДА """"
		|		ИНАЧЕ ДанныеПриказаОПриеме.РазрешениеНаПроживание
		|	КОНЕЦ КАК РазрешениеНаПроживание,
		|	ВЫБОР
		|		КОГДА КадровыеДанныеСотрудников.Страна = ЗНАЧЕНИЕ(Справочник.СтраныМира.Россия)
		|			ТОГДА """"
		|		ИНАЧЕ ДанныеПриказаОПриеме.УсловияОказанияМедпомощи
		|	КОНЕЦ КАК УсловияОказанияМедпомощи,
		|	ДанныеПриказаОПриеме.ОснованиеПредставителяНанимателя,
		|	ДанныеПриказаОПриеме.ОборудованиеРабочегоМеста,
		|	ДанныеПриказаОПриеме.ИныеУсловияДоговора,
		|	ДанныеОрганизаций.Организация,
		|	ДанныеОрганизаций.ОрганизацияНаименованиеПолное,
		|	ДанныеОрганизаций.ИНН,
		|	ДанныеОрганизаций.КПП,
		|	ДанныеОрганизаций.ТелефонОрганизации,
		|	ДанныеОрганизаций.ФаксОрганизации,
		|	ДанныеОрганизаций.ОрганизацияАдресЮридический,
		|	ДанныеОрганизаций.ОрганизацияАдресФактический,
		|	ДанныеОрганизаций.ОрганизацияГородФактическогоАдреса,
		|	КадровыеДанныеСотрудников.Страна,
		|	КадровыеДанныеФизическихЛиц.ФИОПолные КАК РуководительФИОПолные,
		|	КадровыеДанныеФизическихЛиц.ФамилияИО КАК РуководительФамилияИО,
		|	КадровыеДанныеФизическихЛиц.Пол КАК РуководительПол,
		|	КадровыеДанныеСотрудников.ФИОПолные КАК ФИОПолные,
		|	КадровыеДанныеСотрудников.ФамилияИО КАК ФамилияИО,
		|	КадровыеДанныеСотрудников.Пол КАК Пол,
		|	КадровыеДанныеСотрудников.АдресПоПропискеПредставление КАК АдресПоПропискеПредставление,
		|	КадровыеДанныеСотрудников.ДокументПредставление КАК ДокументПредставление,
		|	КадровыеДанныеСотрудников.КоличествоДнейОтпускаОбщее,
		|	КадровыеДанныеСотрудников.КлассУсловийТруда
		|ИЗ
		|	ВТДанныеПриказаОПриеме КАК ДанныеПриказаОПриеме
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТДанныеОрганизаций КАК ДанныеОрганизаций
		|		ПО ДанныеПриказаОПриеме.Организация = ДанныеОрганизаций.Организация
		|			И ДанныеПриказаОПриеме.ПриказОПриемеДата = ДанныеОрганизаций.Период
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТКадровыеДанныеФизическихЛиц КАК КадровыеДанныеФизическихЛиц
		|		ПО ДанныеПриказаОПриеме.Руководитель = КадровыеДанныеФизическихЛиц.ФизическоеЛицо
		|			И ДанныеПриказаОПриеме.ДатаПриема = КадровыеДанныеФизическихЛиц.Период
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТКадровыеДанныеСотрудников КАК КадровыеДанныеСотрудников
		|		ПО ДанныеПриказаОПриеме.Сотрудник = КадровыеДанныеСотрудников.Сотрудник
		|			И ДанныеПриказаОПриеме.ДатаПриема = КадровыеДанныеСотрудников.Период";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		ПараметрыТрудовогоДоговора = ПараметрыТрудовогоДоговора();
		ЗаполнитьЗначенияСвойств(ПараметрыТрудовогоДоговора, Выборка);
		
		РезультатСклонения = "";
		Если ФизическиеЛицаЗарплатаКадры.Просклонять(Строка(ПараметрыТрудовогоДоговора.РуководительФИОПолные), 2, РезультатСклонения, ПараметрыТрудовогоДоговора.РуководительПол) Тогда
			ПараметрыТрудовогоДоговора.РуководительФИОПолные = РезультатСклонения
		КонецЕсли;
		
		ПараметрыТрудовогоДоговора.РуководительДолжностьВПадеже = СклонениеПредставленийОбъектов.ПросклонятьПредставление(Строка(ПараметрыТрудовогоДоговора.РуководительДолжность), 2);
		
		ПараметрыТрудовогоДоговора.ТрудовойДоговорДата = Формат(Выборка.ТрудовойДоговорДата, "ДЛФ=DD; ДП='""___"" ____________ 20___ г.'");
		ПараметрыТрудовогоДоговора.ПриказОПриемеДата = Формат(Выборка.ПриказОПриемеДата, "ДЛФ=D; ДЛФ=DD");
		ПараметрыТрудовогоДоговора.ДатаПриема = Формат(Выборка.ДатаПриема, "ДЛФ=D; ДЛФ=DD");
		
		ОплатаТруда = "";
		СтрокиНачислений = ТаблицаНачислений.НайтиСтроки(Новый Структура("Сотрудник,Период", Выборка.Сотрудник, Выборка.ДатаПриема));
		Если СтрокиНачислений.Количество() > 0 Тогда
			
			Если Не ПустаяСтрока(СтрокиНачислений[0].ОписаниеОклада) Тогда
				ОплатаТруда = СтрокиНачислений[0].ОписаниеОклада;
			КонецЕсли;
		
			Если ЗначениеЗаполнено(СтрокиНачислений[0].Надбавка) Тогда
				ОплатаТруда = ?(ПустаяСтрока(ОплатаТруда), "", ОплатаТруда + "; ") + СтрокиНачислений[0].Надбавка;
			КонецЕсли;
			
		КонецЕсли;
		
		Если ПустаяСтрока(ОплатаТруда) Тогда
			ОплатаТруда = Символы.ПС + "_____________________________________________________________________________________";
		КонецЕсли;
		
		УсловияОплатыТруда = НСтр("ru='Согласно настоящему договору Работнику выплачивается заработная плата'");
		Если ПолучитьФункциональнуюОпцию("ИспользоватьШтатноеРасписание") Тогда
			УсловияОплатыТруда = УсловияОплатыТруда + " " + НСтр("ru='в соответствии со штатным расписанием'");
		КонецЕсли;
		
		УсловияОплатыТруда = УсловияОплатыТруда + ".";
		
		УсловияОплатыТруда = УсловияОплатыТруда + " " + НСтр("ru='На момент заключения договора заработная плата состоит из'") + ": " + ОплатаТруда;
		ПараметрыТрудовогоДоговора.УсловияОплатыТруда = УсловияОплатыТруда + ?(Прав(УсловияОплатыТруда, 1) = ".", "", ".");
		
		Если ЗначениеЗаполнено(Выборка.КлассУсловийТруда) Тогда
			
			Если Выборка.КлассУсловийТруда = Перечисления.КлассыУсловийТрудаПоРезультатамСпециальнойОценки.Оптимальный Тогда
				
				ПараметрыТрудовогоДоговора.УсловияТруда = НСтр("ru='оптимальными'");
				ПараметрыТрудовогоДоговора.КлассУсловий = НСтр("ru='1 класс'");
				
			ИначеЕсли Выборка.КлассУсловийТруда = Перечисления.КлассыУсловийТрудаПоРезультатамСпециальнойОценки.Допустимый Тогда
				
				ПараметрыТрудовогоДоговора.УсловияТруда = НСтр("ru='допустимыми'");
				ПараметрыТрудовогоДоговора.КлассУсловий = НСтр("ru='2 класс'");
				
			ИначеЕсли Выборка.КлассУсловийТруда = Перечисления.КлассыУсловийТрудаПоРезультатамСпециальнойОценки.Вредный1 Тогда
				
				ПараметрыТрудовогоДоговора.УсловияТруда = НСтр("ru='вредными'");
				ПараметрыТрудовогоДоговора.КлассУсловий = НСтр("ru='3 класс, подкласс 3.1 (вредные условия труда 1 степени)'");
				
			ИначеЕсли Выборка.КлассУсловийТруда = Перечисления.КлассыУсловийТрудаПоРезультатамСпециальнойОценки.Вредный2 Тогда
				
				ПараметрыТрудовогоДоговора.УсловияТруда = НСтр("ru='вредными'");
				ПараметрыТрудовогоДоговора.КлассУсловий = НСтр("ru='3 класс, подкласс 3.2 (вредные условия труда 2 степени)'");
				
			ИначеЕсли Выборка.КлассУсловийТруда = Перечисления.КлассыУсловийТрудаПоРезультатамСпециальнойОценки.Вредный3 Тогда
				
				ПараметрыТрудовогоДоговора.УсловияТруда = НСтр("ru='вредными'");
				ПараметрыТрудовогоДоговора.КлассУсловий = НСтр("ru='3 класс, подкласс 3.3 (вредные условия труда 3 степени)'");
				
			ИначеЕсли Выборка.КлассУсловийТруда = Перечисления.КлассыУсловийТрудаПоРезультатамСпециальнойОценки.Вредный4 Тогда
				
				ПараметрыТрудовогоДоговора.УсловияТруда = НСтр("ru='вредными'");
				ПараметрыТрудовогоДоговора.КлассУсловий = НСтр("ru='3 класс, подкласс 3.4 (вредные условия труда 4 степени)'");
				
			ИначеЕсли Выборка.КлассУсловийТруда = Перечисления.КлассыУсловийТрудаПоРезультатамСпециальнойОценки.Опасный Тогда
				
				ПараметрыТрудовогоДоговора.УсловияТруда = НСтр("ru='опасными'");
				ПараметрыТрудовогоДоговора.КлассУсловий = НСтр("ru='4 класс'");
				
			КонецЕсли;
			
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(ПараметрыТрудовогоДоговора.УсловияТруда) Тогда
			
			ПараметрыТрудовогоДоговора.УсловияТруда = "_____________";
			ПараметрыТрудовогоДоговора.КлассУсловий = "_____________";
			
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Выборка.ОснованиеПредставителяНанимателя) Тогда
			ПараметрыТрудовогоДоговора.ОснованиеРуководителя = Выборка.ОснованиеПредставителяНанимателя;
		Иначе
			ПараметрыТрудовогоДоговора.ОснованиеРуководителя = "__________________";
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Выборка.ОборудованиеРабочегоМеста) Тогда
			ПараметрыТрудовогоДоговора.ОборудованиеРабочегоМеста = " (" + Выборка.ОборудованиеРабочегоМеста + ")"
		Иначе
			ПараметрыТрудовогоДоговора.ОборудованиеРабочегоМеста = "";
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Выборка.ИныеУсловияДоговора) Тогда
			
			Если ИмяМакета = "ПФ_MXL_ТрудовойДоговорПриДистанционнойРаботе" Тогда
				ПараметрыТрудовогоДоговора.ИныеУсловияДоговора = "8.5.";
			Иначе
				ПараметрыТрудовогоДоговора.ИныеУсловияДоговора = "7.3.";
			КонецЕсли;
			
			ПараметрыТрудовогоДоговора.ИныеУсловияДоговора = ПараметрыТрудовогоДоговора.ИныеУсловияДоговора + " " + Выборка.ИныеУсловияДоговора + ".";
			
		Иначе
			ПараметрыТрудовогоДоговора.ИныеУсловияДоговора = "";
		КонецЕсли;
		
		Если Выборка.ВидЗанятости = Перечисления.ВидыЗанятости.ОсновноеМестоРаботы Тогда
			ПараметрыТрудовогоДоговора.ВидЗанятостиПоДоговору = НСтр("ru='основным местом работы'");
		Иначе
			ПараметрыТрудовогоДоговора.ВидЗанятостиПоДоговору = НСтр("ru='местом работы по совместительству'");
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Выборка.ДатаЗавершенияТрудовогоДоговора) Тогда
			
			ПараметрыТрудовогоДоговора.СрокДействияПредставление = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='на срок до %1'"),
				Формат(Выборка.ДатаЗавершенияТрудовогоДоговора, "ДЛФ=DD"));
				
			Если Прав(ПараметрыТрудовогоДоговора.СрокДействияПредставление, 1) = "." Тогда
				ПараметрыТрудовогоДоговора.СрокДействияПредставление =
					Лев(ПараметрыТрудовогоДоговора.СрокДействияПредставление, СтрДлина(ПараметрыТрудовогоДоговора.СрокДействияПредставление) - 1);
			КонецЕсли;
				
		Иначе
			ПараметрыТрудовогоДоговора.СрокДействияПредставление = НСтр("ru='на неопределенный срок'");
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(ПараметрыТрудовогоДоговора.КоличествоДнейОтпускаОбщее) Тогда
			ПараметрыТрудовогоДоговора.КоличествоДнейОтпускаОбщее = "____";
		КонецЕсли;
		
		Если ПараметрыТрудовогоДоговора.Страна <> Справочники.СтраныМира.Россия Тогда
			
			Если Не ЗначениеЗаполнено(ПараметрыТрудовогоДоговора.РазрешениеНаРаботу) Тогда
				ПараметрыТрудовогоДоговора.РазрешениеНаРаботу = Символы.ПС
					+ "______________________________________________________________________________________";
			КонецЕсли;
			
			Если Не ЗначениеЗаполнено(ПараметрыТрудовогоДоговора.РазрешениеНаПроживание) Тогда
				ПараметрыТрудовогоДоговора.РазрешениеНаПроживание = Символы.ПС
					+ "______________________________________________________________________________________";
			КонецЕсли;
			
			Если Не ЗначениеЗаполнено(ПараметрыТрудовогоДоговора.УсловияОказанияМедпомощи) Тогда
				ПараметрыТрудовогоДоговора.УсловияОказанияМедпомощи = Символы.ПС
					+ "______________________________________________________________________________________";
			КонецЕсли;
			
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Выборка.Организация) Тогда
			
			ПараметрыТрудовогоДоговора.ИННКПП =
				НСтр("ru='ИНН'") + ":  " + ?(ЗначениеЗаполнено(Выборка.ИНН), Выборка.ИНН, "_____________");
				
			Если ЗарплатаКадры.ЭтоЮридическоеЛицо(Выборка.Организация) Тогда
				
				ПараметрыТрудовогоДоговора.ИННКПП = ПараметрыТрудовогоДоговора.ИННКПП +
					" " + НСтр("ru='КПП'") + ": " + ?(ЗначениеЗаполнено(Выборка.КПП), Выборка.КПП, "_____________");
				
			КонецЕсли;
			
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(Выборка.РуководительДолжность) Тогда
			ПараметрыТрудовогоДоговора.РуководительДолжность = "__________________________";
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(Выборка.РуководительФамилияИО) Тогда
			ПараметрыТрудовогоДоговора.РуководительФамилияИО = "__________________________";
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Выборка.ТелефонОрганизации) Тогда
			ПараметрыТрудовогоДоговора.ОрганизацияТелефон = Выборка.ТелефонОрганизации;
		Иначе
			ПараметрыТрудовогоДоговора.ОрганизацияТелефон = "__________________________";
		КонецЕсли;
		
		Если ЗначениеЗаполнено(Выборка.ФаксОрганизации) Тогда
			
			ПараметрыТрудовогоДоговора.ОрганизацияТелефон = ПараметрыТрудовогоДоговора.ОрганизацияТелефон +
				" " + НСтр("ru='Факс'") + ": " + Выборка.ФаксОрганизации;
			
		КонецЕсли;
		
		МассивПараметров.Добавить(ПараметрыТрудовогоДоговора);
		
	КонецЦикла;
	
	Возврат МассивПараметров;
	
КонецФункции

Функция ПараметрыТрудовогоДоговора()
	
	Параметры = Новый Структура;
	
	Параметры.Вставить("Ссылка", Неопределено);
	Параметры.Вставить("ПриказОПриемеНомер", "");
	Параметры.Вставить("ПриказОПриемеДата", '00010101');
	Параметры.Вставить("ОрганизацияНаименованиеПолное", "");
	Параметры.Вставить("ИННКПП", "");
	Параметры.Вставить("ОрганизацияТелефон", "");
	Параметры.Вставить("ОрганизацияАдресЮридический", "");
	Параметры.Вставить("ОрганизацияАдресФактический", "");
	Параметры.Вставить("ОрганизацияГородФактическогоАдреса", "");
	Параметры.Вставить("Сотрудник", Справочники.Сотрудники.ПустаяСсылка());
	Параметры.Вставить("Подразделение", Справочники.ПодразделенияОрганизаций.ПустаяСсылка());
	Параметры.Вставить("Должность", Справочники.Должности.ПустаяСсылка());
	Параметры.Вставить("ВидЗанятостиПоДоговору", "");
	Параметры.Вставить("ТрудовойДоговорНомер", "");
	Параметры.Вставить("ТрудовойДоговорДата", '00010101');
	Параметры.Вставить("СрокДействияПредставление", "");
	Параметры.Вставить("РуководительФамилияИО", "");
	Параметры.Вставить("РуководительФИОПолные", "");
	Параметры.Вставить("РуководительПол");
	Параметры.Вставить("РуководительДолжность", Справочники.Должности.ПустаяСсылка());
	Параметры.Вставить("ДатаПриема", '00010101');
	Параметры.Вставить("ФИОПолные", "");
	Параметры.Вставить("ФамилияИО", "");
	Параметры.Вставить("Пол");
	Параметры.Вставить("КлассУсловийТруда");
	Параметры.Вставить("УсловияТруда", "");
	Параметры.Вставить("КлассУсловий", "");
	Параметры.Вставить("АдресПоПропискеПредставление", "");
	Параметры.Вставить("ДокументПредставление", "");
	Параметры.Вставить("Страна", Справочники.СтраныМира.Россия);
	Параметры.Вставить("РазрешениеНаРаботу", "");
	Параметры.Вставить("РазрешениеНаПроживание", "");
	Параметры.Вставить("УсловияОказанияМедпомощи", "");
	Параметры.Вставить("КоличествоДнейОтпускаОбщее", "");
	Параметры.Вставить("ОснованиеРуководителя", "");
	Параметры.Вставить("ОборудованиеРабочегоМеста", "");
	Параметры.Вставить("ИныеУсловияДоговора", "");
	Параметры.Вставить("РуководительДолжностьВПадеже", "");
	Параметры.Вставить("УсловияОплатыТруда");
	
	Возврат Параметры;
	
КонецФункции


