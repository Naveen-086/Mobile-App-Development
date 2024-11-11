package com.example.exp4;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class DatabaseHelper extends SQLiteOpenHelper {

    public static final String DATABASE_NAME = "Student.db";
    public static final String TABLE_NAME = "student_table";
    public static final String COL_1 = "ID";
    public static final String COL_2 = "STUDENT_NAME";
    public static final String COL_3 = "ROLL_NO";
    public static final String COL_4 = "PHONE_NUMBER";
    public static final String COL_5 = "DEPARTMENT";
    public static final String COL_6 = "FATHER_NAME";
    public static final String COL_7 = "MOTHER_NAME";
    public static final String COL_8 = "PARENT_MOBILE_NUMBER";
    public static final String COL_9 = "COMMUNITY";
    public static final String COL_10 = "ADDRESS";
    public static final String COL_11 = "QUOTA";
    public static final String COL_12 = "DOB";

    public DatabaseHelper(Context context) {
        super(context, DATABASE_NAME, null, 1);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("CREATE TABLE " + TABLE_NAME + " (" +
                "ID INTEGER PRIMARY KEY AUTOINCREMENT," +
                "STUDENT_NAME TEXT," +
                "ROLL_NO TEXT," +
                "PHONE_NUMBER TEXT," +
                "DEPARTMENT TEXT," +
                "FATHER_NAME TEXT," +
                "MOTHER_NAME TEXT," +
                "PARENT_MOBILE_NUMBER TEXT," +
                "COMMUNITY TEXT," +
                "ADDRESS TEXT," +
                "QUOTA TEXT," +
                "DOB TEXT)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_NAME);
        onCreate(db);
    }

    // Method to insert data into the database
    public boolean insertData(String studentName, String rollNo, String phoneNumber, String department, String fatherName, String motherName, String parentMobileNumber, String community, String address, String quota, String dob) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(COL_2, studentName);
        contentValues.put(COL_3, rollNo);
        contentValues.put(COL_4, phoneNumber);
        contentValues.put(COL_5, department);
        contentValues.put(COL_6, fatherName);
        contentValues.put(COL_7, motherName);
        contentValues.put(COL_8, parentMobileNumber);
        contentValues.put(COL_9, community);
        contentValues.put(COL_10, address);
        contentValues.put(COL_11, quota);
        contentValues.put(COL_12, dob);

        long result = db.insert(TABLE_NAME, null, contentValues);
        return result != -1; // returns true if data is inserted successfully, otherwise false
    }

    // Method to get all data from the database
    public Cursor getAllData() {
        SQLiteDatabase db = this.getWritableDatabase();
        return db.rawQuery("SELECT * FROM " + TABLE_NAME,null);
    }
}
