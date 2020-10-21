class BaseColumns {}

class PageEntry extends BaseColumns {
  static const String TABLE_PAGE = "page_table";
  static const String COLUMN_PAGE_ID = "pageid";
  static const String COLUMN_NS = "ns";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_INDEX = "index";
  static const String COLUMN_THUMBNAIL = "thumbnail";
  static const String COLUMN_TERMS = "terms";

  static const String CREATE_TABLE_PAGE = "CREATE TABLE " +
      TABLE_PAGE +
      " (" +
      COLUMN_PAGE_ID +
      " INTEGER," +
      COLUMN_NS +
      " INTEGER," +
      COLUMN_TITLE +
      " TEXT," +
      COLUMN_INDEX +
      " INTEGER," +
      COLUMN_THUMBNAIL +
      " TEXT," +
      COLUMN_TERMS +
      " TEXT," +
      " PRIMARY KEY (" +
      COLUMN_PAGE_ID +
      ")" +
      ")";
  static const String DELETE_PAGE_TABLE =
      "DROP TABLE IF EXISTS " + TABLE_PAGE;

  static String PRIMARY_KEY_WHERE_STRING =
      COLUMN_PAGE_ID + " = ?";
}