#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура Заполнить(Команда)
	ВыполнитьОбработку();
	Сообщить("Обработка завершена!");
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыиФункции
&НаСервере
Процедура ВыполнитьОбработку()
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ОбработкаОбъект.ЗаполнитьГрафик(ВыборПериода.ДатаНачала, ВыборПериода.ДатаОкончания, ВыходныеДни);
КонецПроцедуры 
#КонецОбласти
