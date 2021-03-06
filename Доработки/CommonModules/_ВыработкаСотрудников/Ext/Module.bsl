﻿
Процедура ПриСозданииНаСервере_ФормаДокумента(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	Объект = Форма.Объект;
	
	Элемент = Форма.Элементы.Вставить("_ДлительностьРаботДокумента", Тип("ПолеФормы"), Форма.Элементы.ГруппаШапкаПраво, );
    Элемент.Вид         = ВидПоляФормы.ПолеВвода;
	Элемент.ПутьКДанным = "Объект._ДлительностьРаботДокумента";
	Элемент.УстановитьДействие("ПриИзменении", "_ДлительностьРаботДокументаПриИзменении");
	
	Элемент = Форма.Элементы.Вставить("Сотрудники_РольИсполнителяРабот", Тип("ПолеФормы"), Форма.Элементы.Сотрудники, Форма.Элементы.СотрудникиНормативныйКТУ);
   	Элемент.Вид         = ВидПоляФормы.ПолеВвода;
	Элемент.ПутьКДанным = "Объект.Сотрудники._РольИсполнителяРабот";
	Элемент.УстановитьДействие("ПриИзменении", "Сотрудники_РольИсполнителяРаботПриИзменении");
	
	Элемент = Форма.Элементы.Вставить("Сотрудники_ДлительностьРаботСотрудника", Тип("ПолеФормы"), Форма.Элементы.Сотрудники, Форма.Элементы.СотрудникиНормативныйКТУ);
   	Элемент.Вид         = ВидПоляФормы.ПолеВвода;
	Элемент.ПутьКДанным = "Объект.Сотрудники._ДлительностьРаботСотрудника";
	Элемент.УстановитьДействие("ПриИзменении", "Сотрудники_ДлительностьРаботСотрудникаПриИзменении");
	
КонецПроцедуры

Процедура РассчитатьКТУ_ПоСтроке(ТекСтрока, Объект) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ТекСтрока._РольИсполнителяРабот) Тогда
		ТекСтрока.НормативныйКТУ = 0;
		
	Иначе
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	МАКСИМУМ(ФормированиеСоставаБригады.НачалоПериода) КАК НачалоПериода
		|ПОМЕСТИТЬ НачалоДействияСостава
		|ИЗ
		|	Документ.ФормированиеСоставаБригады КАК ФормированиеСоставаБригады
		|ГДЕ
		|	ФормированиеСоставаБригады.НачалоПериода <= &Период
		|	И ФормированиеСоставаБригады.Бригада = &Бригада
		|	И ФормированиеСоставаБригады.Проведен
		|	И НЕ ФормированиеСоставаБригады.ПометкаУдаления
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ФормированиеСоставаБригады.Бригада.Подразделение,
		|	ФормированиеСоставаБригадыСотрудники._РольИсполнителяРабот,
		|	СУММА(1) КАК КоличествоРаботниковПлан
		|ПОМЕСТИТЬ КоличествоПлановыхМест
		|ИЗ
		|	Документ.ФормированиеСоставаБригады.Сотрудники КАК ФормированиеСоставаБригадыСотрудники
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ФормированиеСоставаБригады КАК ФормированиеСоставаБригады
		|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ НачалоДействияСостава КАК НачалоДействияСостава
		|			ПО (НачалоДействияСостава.НачалоПериода = ФормированиеСоставаБригады.НачалоПериода)
		|				И (ФормированиеСоставаБригады.Проведен)
		|				И (НЕ ФормированиеСоставаБригады.ПометкаУдаления)
		|		ПО ФормированиеСоставаБригадыСотрудники.Ссылка = ФормированиеСоставаБригады.Ссылка
		|ГДЕ
		|	ФормированиеСоставаБригады.Бригада = &Бригада
		|	И ФормированиеСоставаБригадыСотрудники._РольИсполнителяРабот = &РольИсполнителяРабот
		|
		|СГРУППИРОВАТЬ ПО
		|	ФормированиеСоставаБригадыСотрудники._РольИсполнителяРабот,
		|	ФормированиеСоставаБригады.Бригада.Подразделение
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ЕСТЬNULL(КоличествоПлановыхМест._РольИсполнителяРабот, УС_РаспределениеВыпускаПоУчастникамСрезПоследних.РольИсполнителяРаботНаПеределе) КАК _РольИсполнителяРабот,
		|	ЕСТЬNULL(КоличествоПлановыхМест.КоличествоРаботниковПлан, 0) КАК КоличествоРаботниковПлан,
		|	ЕСТЬNULL(УС_РаспределениеВыпускаПоУчастникамСрезПоследних.КТУ, 0) КАК КТУ_РолиИсполнителя,
		|	УС_РаспределениеВыпускаПоУчастникамСрезПоследних.ПлановоеКоличествоИсполнителей КАК ПлановоеКоличествоИсполнителей
		|ИЗ
		|	КоличествоПлановыхМест КАК КоличествоПлановыхМест
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.УС_РаспределениеВыпускаПоУчастникам.СрезПоследних(&Период, ) КАК УС_РаспределениеВыпускаПоУчастникамСрезПоследних
		|		ПО КоличествоПлановыхМест._РольИсполнителяРабот = УС_РаспределениеВыпускаПоУчастникамСрезПоследних.РольИсполнителяРаботНаПеределе
		|			И КоличествоПлановыхМест.БригадаПодразделение = УС_РаспределениеВыпускаПоУчастникамСрезПоследних.Передел";
		
		Период = КонецДня(?(ЗначениеЗаполнено(Объект.Дата), Объект.Дата, ТекущаяДата()));
		
		Запрос.УстановитьПараметр("РольИсполнителяРабот", ТекСтрока._РольИсполнителяРабот);
		Запрос.УстановитьПараметр("Бригада", Объект.Бригада);
		Запрос.УстановитьПараметр("Период", Период);
		
		ТЗ = Запрос.Выполнить().Выгрузить();
		
		Если ТЗ.Количество() = 0 Тогда
			
			ТекСтрока.НормативныйКТУ = 0;
			
		Иначе
			//КоличествоРаботниковПлан = Макс(ТЗ[0].КоличествоРаботниковПлан,ТЗ[0].ПлановоеКоличествоИсполнителей);
			КоличествоРаботниковПлан = ТЗ[0].ПлановоеКоличествоИсполнителей;
			КТУ_РолиИсполнителя = ТЗ[0].КТУ_РолиИсполнителя;
			ЧасыСотрудника = ТекСтрока._ДлительностьРаботСотрудника;
			ЧасыДокумента = Объект._ДлительностьРаботДокумента;
			
			ТекСтрока.НормативныйКТУ = КТУ_РолиИсполнителя/Макс(КоличествоРаботниковПлан,1)*ЧасыСотрудника/Макс(ЧасыДокумента,ЧасыСотрудника,1);
			
		КонецЕсли; 
		
	КонецЕсли; 
	
КонецПроцедуры
