
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	
	Если ПравоДоступа("Добавление", Метаданные.Документы.РеализацияТоваровУслуг) Тогда
		
        КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
        КомандаСоздатьНаОсновании.Менеджер = Метаданные.Документы.РеализацияТоваровУслуг.ПолноеИмя();
        КомандаСоздатьНаОсновании.Представление = ОбщегоНазначения.ПредставлениеОбъекта(Метаданные.Документы.РеализацияТоваровУслуг);
        КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		
		Возврат КомандаСоздатьНаОсновании;
		
	КонецЕсли;

	Возврат Неопределено;
	
КонецФункции

#КонецОбласти


#Область СлужебныеПроцедурыИФункции
//Доработка Печать акта Шутова И.Н.

Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Идентификатор		= "ВКМ_АктВыполненныхУслуг";
	КомандаПечати.Представление		= НСтр("ru = 'Акт об оказании услуг'");
	КомандаПечати.Порядок			= 1;
	
КонецПроцедуры

Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	 ПечатнаяФорма = УправлениеПечатью.СведенияОПечатнойФорме(КоллекцияПечатныхФорм, "ВКМ_АктВыполненныхУслуг");
	 ПечатнаяФорма.ТабличныйДокумент = ПечатьАктаОбОказанииУслуг(МассивОбъектов, ОбъектыПечати);
	 ПечатнаяФорма.СинонимМакета = НСтр("ru = 'Акт об оказании услуг'");
	 ПечатнаяФорма.ПолныйПутьКМакету = "Документ.РеализацияТоваровУслуг.ВКМ_АктВыполненныхУслуг";	
	
КонецПроцедуры

Функция ПечатьАктаОбОказанииУслуг(МассивОбъектов, ОбъектыПечати)
	
	Макет = УправлениеПечатью.МакетПечатнойФормы("Документ.РеализацияТоваровУслуг.ВКМ_АктВыполненныхУслуг");
	ОбластьШапка 	= Макет.ПолучитьОбласть("Шапка");
	ОбластьЗаголовок 	= Макет.ПолучитьОбласть("Заголовок");
	ОбластьСтрока 	= Макет.ПолучитьОбласть("Строка");
	ОбластьПодвал 	= Макет.ПолучитьОбласть("Подвал");
	
	ТабличныйДокумент = Новый ТабличныйДокумент;
	ТабличныйДокумент.ОриентацияСтраницы = ОриентацияСтраницы.Портрет;
	ТабличныйДокумент.КлючПараметровПечати = "ПАРАМЕТРЫПЕЧАТИ_АКТВЫПОЛНЕННЫХУСЛУГ";
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	РеализацияТоваровУслуг.Ссылка КАК Ссылка,
	               |	РеализацияТоваровУслуг.Организация КАК Организация,
	               |	РеализацияТоваровУслуг.Контрагент КАК Контрагент,
	               |	РеализацияТоваровУслуг.Договор КАК Договор,
	               |	РеализацияТоваровУслуг.СуммаДокумента КАК СуммаДокумента,
	               |	РеализацияТоваровУслуг.Дата КАК Дата,
	               |	РеализацияТоваровУслуг.Номер КАК Номер
	               |ИЗ
	               |	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
	               |ГДЕ
	               |	РеализацияТоваровУслуг.Ссылка В(&МассивОбъектов)
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	Дата,
	               |	Номер
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	РеализацияТоваровУслугУслуги.НомерСтроки КАК НомерСтроки,
	               |	РеализацияТоваровУслугУслуги.Номенклатура КАК Номенклатура,
	               |	РеализацияТоваровУслугУслуги.Количество КАК Количество,
	               |	РеализацияТоваровУслугУслуги.Цена КАК Цена,
	               |	РеализацияТоваровУслугУслуги.Сумма КАК Сумма,
	               |	РеализацияТоваровУслугУслуги.Ссылка КАК Ссылка
	               |ИЗ
	               |	Документ.РеализацияТоваровУслуг.Услуги КАК РеализацияТоваровУслугУслуги
	               |ГДЕ
	               |	РеализацияТоваровУслугУслуги.Ссылка В(&МассивОбъектов)
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	НомерСтроки
	               |ИТОГИ ПО
	               |	Ссылка";
	
Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);

РезультатЗапроса = Запрос.ВыполнитьПакет();	
ВыборкаШапка = РезультатЗапроса[0].Выбрать();
ВыборкаВсеСтроки = РезультатЗапроса[1].Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
ПервыйДокумент = Истина;
Пока ВыборкаШапка.Следующий() Цикл
		
		Если Не ПервыйДокумент Тогда
			ТабличныйДокумент.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;

        ПервыйДокумент = Ложь;
		НомерСтрокиНачало = ТабличныйДокумент.ВысотаТаблицы + 1;		
		ОбластьШапка.Параметры.Заполнить(ВыборкаШапка);
        ТабличныйДокумент.Вывести(ОбластьШапка);
        ВыборкаВсеСтроки.Сбросить();
		ОтборСтрок = Новый Структура("Ссылка", ВыборкаШапка.Ссылка);
		Если ВыборкаВсеСтроки.НайтиСледующий(ОтборСтрок) Тогда
			ВыборкаСтрок = ВыборкаВсеСтроки.Выбрать();
			КоличествоСтрок = ВыборкаСтрок.Количество();
		Иначе
			КоличествоСтрок = 0;
		КонецЕсли; 
		ТабличныйДокумент.Вывести(ОбластьЗаголовок);

        Пока КоличествоСтрок > 0 И ВыборкаСтрок.Следующий() Цикл
        ОбластьСтрока.Параметры.Заполнить(ВыборкаСтрок);	
		ТабличныйДокумент.Вывести(ОбластьСтрока);
		КонецЦикла;
		
		Если КоличествоСтрок = 0 Тогда
			Область = Макет.ПолучитьОбласть("Строка");
			ТабличныйДокумент.Вывести(Область);
		КонецЕсли;
		
		ОбластьПодвал.Параметры.Заполнить(ВыборкаШапка);
		СуммаПрописью = СформироватьСуммуПрописью(ВыборкаШапка.СуммаДокумента, );
		ОбластьПодвал.Параметры.СуммаПрописью = СуммаПрописью;
		ТабличныйДокумент.Вывести(ОбластьПодвал);
		
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабличныйДокумент, 
		НомерСтрокиНачало, ОбъектыПечати, ВыборкаШапка.Ссылка);
	КонецЦикла;
	
	Возврат ТабличныйДокумент;

КонецФункции

Функция СформироватьСуммуПрописью(Сумма,Знач Валюта) Экспорт
	
	ПараметрыПрописиНаРусском = "";
	Если Не ЗначениеЗаполнено(Валюта) Тогда
		
		ПараметрыПрописиНаРусском = "рубль, рубля, рублей, м, копейка, копейки, копеек, ж, 2";
				
	Иначе
		
		ПараметрыПрописиНаРусском = Валюта.ПараметрыПрописи;
	
	КонецЕсли;
	
	
		Возврат ЧислоПрописью(Сумма, "Л=ru_RU" ,ПараметрыПрописиНаРусском);


	
КонецФункции

	
//Конец доработки
#КонецОбласти

#КонецЕсли
