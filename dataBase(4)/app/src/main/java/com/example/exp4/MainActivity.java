package com.example.exp4;
import android.content.DialogInterface;
import android.database.Cursor;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    com.example.exp4.DatabaseHelper myDb;
    EditText etStudentName, etRollNo, etPhoneNumber, etDepartment, etFatherName, etMotherName, etParentMobileNumber, etCommunity, etAddress, etQuota, etDOB;
    Button btnSubmit, btnViewAll;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        myDb = new com.example.exp4.DatabaseHelper(this);

        etStudentName = findViewById(R.id.etStudentName);
        etRollNo = findViewById(R.id.etRollNo);
        etPhoneNumber = findViewById(R.id.etPhoneNumber);
        etDepartment = findViewById(R.id.etDepartment);
        etFatherName = findViewById(R.id.etFatherName);
        etMotherName = findViewById(R.id.etMotherName);
        etParentMobileNumber = findViewById(R.id.etParentMobileNumber);
        etCommunity = findViewById(R.id.etCommunity);
        etAddress = findViewById(R.id.etAddress);
        etQuota = findViewById(R.id.etQuota);
        etDOB = findViewById(R.id.etDOB);
        btnSubmit = findViewById(R.id.btnSubmit);
        btnViewAll = findViewById(R.id.btnViewAll);

        // Submit button click event
        btnSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                boolean isInserted = myDb.insertData(
                        etStudentName.getText().toString(),
                        etRollNo.getText().toString(),
                        etPhoneNumber.getText().toString(),
                        etDepartment.getText().toString(),
                        etFatherName.getText().toString(),
                        etMotherName.getText().toString(),
                        etParentMobileNumber.getText().toString(),
                        etCommunity.getText().toString(),
                        etAddress.getText().toString(),
                        etQuota.getText().toString(),
                        etDOB.getText().toString()
                );

                if (isInserted)
                    Toast.makeText(MainActivity.this, "Data Stored Successfully", Toast.LENGTH_SHORT).show();
                else
                    Toast.makeText(MainActivity.this, "Data Insertion Failed", Toast.LENGTH_SHORT).show();
            }
        });

        // View All button click event
        btnViewAll.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Cursor res = myDb.getAllData();
                if (res.getCount() == 0) {
                    // Show message if no data
                    Toast.makeText(MainActivity.this, "No Data Found", Toast.LENGTH_SHORT).show();
                    return;
                }

                StringBuilder buffer = new StringBuilder();
                while (res.moveToNext()) {
                    buffer.append("Student Name: ").append(res.getString(1)).append("\n");
                    buffer.append("Roll No: ").append(res.getString(2)).append("\n");
                    buffer.append("Phone Number: ").append(res.getString(3)).append("\n");
                    buffer.append("Department: ").append(res.getString(4)).append("\n");
                    buffer.append("Father Name: ").append(res.getString(5)).append("\n");
                    buffer.append("Mother Name: ").append(res.getString(6)).append("\n");
                    buffer.append("Parent Mobile Number: ").append(res.getString(7)).append("\n");
                    buffer.append("Community: ").append(res.getString(8)).append("\n");
                    buffer.append("Address: ").append(res.getString(9)).append("\n");
                    buffer.append("Quota: ").append(res.getString(10)).append("\n");
                    buffer.append("Date of Birth: ").append(res.getString(11)).append("\n\n");
                }

                // Show all data in an AlertDialog
                showMessage("Stored Data", buffer.toString());
            }
        });
    }

    // Method to show data in an AlertDialog
    public void showMessage(String title, String message) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setCancelable(true);
        builder.setTitle(title);
        builder.setMessage(message);
        builder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        builder.show();
}
}