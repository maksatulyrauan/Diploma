
import 'package:diploma_note/Models/SharedInstances/data_holder.dart';
import 'package:diploma_note/Utilities/enumerations.dart';

class Strings {
  //Statistics

  static get selectedLanguage => DataHolder().selectedLanguage;

  String cancel = selectedLanguage == LanguageType.russian ? 'Отменить' :
  selectedLanguage == LanguageType.english ? 'Cancel' : 'Отменить';

  String addTasks = selectedLanguage == LanguageType.russian ? 'Добавить задачи' :
  selectedLanguage == LanguageType.english ? 'Add Tasks' : 'Добавить задачи';

  String withoutTitle = selectedLanguage == LanguageType.russian ? 'Без названия' :
  selectedLanguage == LanguageType.english ? 'No title' : 'Без названия';

  String favouritesEmpty = selectedLanguage == LanguageType.russian ? 'Список избранных пуст' :
  selectedLanguage == LanguageType.english ? 'Favourites list is empty' : 'Список избранных пуст';

  String addToFavourites = selectedLanguage == LanguageType.russian ? 'Добваить в избранные' :
  selectedLanguage == LanguageType.english ? 'Add to favourites' : 'Добваить в избранные';

  String removeFromFavourites = selectedLanguage == LanguageType.russian ? 'Убрать из избранных' :
  selectedLanguage == LanguageType.english ? 'Remove from favourites' : 'Убрать из избранных';

  String remove = selectedLanguage == LanguageType.russian ? 'Убрать' :
  selectedLanguage == LanguageType.english ? 'Remove' : 'Убрать';

  String done = selectedLanguage == LanguageType.russian ? 'Готово' :
  selectedLanguage == LanguageType.english ? 'Done' : 'Готово';

  String set = selectedLanguage == LanguageType.russian ? 'Установить' :
  selectedLanguage == LanguageType.english ? 'Set' : 'Установить';

  String addColor = selectedLanguage == LanguageType.russian ? 'Добавить цвет' :
  selectedLanguage == LanguageType.english ? 'Add color' : 'Добавить цвет';

  String addToNotebook = selectedLanguage == LanguageType.russian ? 'Выберите блокнот' :
  selectedLanguage == LanguageType.english ? 'Choose notebook' : 'Выберите блокнот';

  String remindMe = selectedLanguage == LanguageType.russian ? 'Напомнить мне' :
  selectedLanguage == LanguageType.english ? 'Remind me' : 'Напомнить мне';

  String reminder = selectedLanguage == LanguageType.russian ? 'Напоминание' :
  selectedLanguage == LanguageType.english ? 'Reminder' : 'Напоминание';

  String features = selectedLanguage == LanguageType.russian ? 'Детали' :
  selectedLanguage == LanguageType.english ? 'Features' : 'Детали';

  String createNotebook = selectedLanguage == LanguageType.russian ? 'Создать блокнот' :
  selectedLanguage == LanguageType.english ? 'Create notebook' : 'Создать блокнот';

  String addTag = selectedLanguage == LanguageType.russian ? 'Добавить тег' :
  selectedLanguage == LanguageType.english ? 'Add tag' : 'Добавить тег';

  String attachedFiles = selectedLanguage == LanguageType.russian ? 'Прикрепленные файлы' :
  selectedLanguage == LanguageType.english ? 'Attached files' : 'Прикрепленные файлы';

  String choose = selectedLanguage == LanguageType.russian ? 'Выберите' :
  selectedLanguage == LanguageType.english ? 'Choose' : 'Таңдаңыз';

  String camera = selectedLanguage == LanguageType.russian ? 'Камера' :
  selectedLanguage == LanguageType.english ? 'Camera' : 'Камера';

  String gallery = selectedLanguage == LanguageType.russian ? 'Галерея' :
  selectedLanguage == LanguageType.english ? 'Gallery' : 'Галерея';

  String title = selectedLanguage == LanguageType.russian ? 'Название' :
  selectedLanguage == LanguageType.english ? 'Title' : 'Название';

  String notebookTitleHint = selectedLanguage == LanguageType.russian ? 'Введите название блокнота' :
  selectedLanguage == LanguageType.english ? 'Type notebook name' : 'Введите название блокнота';

  String noteHint = selectedLanguage == LanguageType.russian ? 'Напишите что-нибудь' :
  selectedLanguage == LanguageType.english ? 'Start writing' : 'Напишите что-нибудь';

  String tagHint = selectedLanguage == LanguageType.russian ? 'Введите теги через "#"' :
  selectedLanguage == LanguageType.english ? 'Add tags after "#"' : 'Введите теги через "#"';

  String russian = selectedLanguage == LanguageType.russian ? 'Русский' :
  selectedLanguage == LanguageType.english ? 'Russian' : 'Орысша';

  String english = selectedLanguage == LanguageType.russian ? 'Английский' :
  selectedLanguage == LanguageType.english ? 'English' : 'Ағылшынша';

  String kazkh = selectedLanguage == LanguageType.russian ? 'Казахский' :
  selectedLanguage == LanguageType.english ? 'Kazakh' : 'Қазақша';

  String searchNotebook = selectedLanguage == LanguageType.russian ? 'Найти блокнот' :
  selectedLanguage == LanguageType.english ? 'Find a notebook' : 'Блокнот іздеу';

  String searchNote = selectedLanguage == LanguageType.russian ? 'Найти среди Всех Заметок' :
  selectedLanguage == LanguageType.english ? 'Search in All Notes' : 'Найти среди Всех Заметок';

  String favourite = selectedLanguage == LanguageType.russian ? 'Избранные' :
  selectedLanguage == LanguageType.english ? 'Favourite' : 'Избранные';

  String allNotes = selectedLanguage == LanguageType.russian ? 'Все заметки' :
  selectedLanguage == LanguageType.english ? 'All Notes' : 'Барлық түртпелер';

  String reminders = selectedLanguage == LanguageType.russian ? 'Напоминания' :
  selectedLanguage == LanguageType.english ? 'Reminders' : 'Ескертулер';

  String notebooks = selectedLanguage == LanguageType.russian ? 'Блокноты' :
  selectedLanguage == LanguageType.english ? 'Notebooks' : 'Блокноттар';

  String chat = selectedLanguage == LanguageType.russian ? 'Сообщения' :
  selectedLanguage == LanguageType.english ? 'Chat' : 'Хаттар';

  String settings = selectedLanguage == LanguageType.russian ? 'Настройки' :
  selectedLanguage == LanguageType.english ? 'Settings' : 'Настройки';

  String support = selectedLanguage == LanguageType.russian ? 'Поддержка' :
  selectedLanguage == LanguageType.english ? 'Support' : 'Поддержка';

  String appLanguage = selectedLanguage == LanguageType.russian ? 'Язык' :
  selectedLanguage == LanguageType.english ? 'Language' : 'Тіл';

  String appLanguageHint = selectedLanguage == LanguageType.russian ? 'Выберите язык приложения' :
  selectedLanguage == LanguageType.english ? 'Choose app language' : 'Қосымша тілін таңдаңыз';

  String signOut = selectedLanguage == LanguageType.russian ? 'Выйти из аккаунта' :
  selectedLanguage == LanguageType.english ? 'Sign out' : 'Выйти из аккаунта';

  String privacyPolicy = selectedLanguage == LanguageType.russian ? 'Политика конфиденциальности' :
  selectedLanguage == LanguageType.english ? 'Privacy policy' : 'Политика конфиденциальности';

  String termsOfUse = selectedLanguage == LanguageType.russian ? 'Пользовательское соглашение' :
  selectedLanguage == LanguageType.english ? 'Terms of use' : 'Пользовательское соглашение';


}