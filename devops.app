package com.devops;

import java.io.*;
import java.util.*;

class Student {
    private int id;
    private String name;
    private int age;
    private String course;

    public Student(int id, String name, int age, String course) {
        this.id = id;
        this.name = name;
        this.age = age;
        this.course = course;
    }

    @Override
    public String toString() {
        return id + ", " + name + ", " + age + ", " + course;
    }
}

public class StudentAdmissionCLI {
    private static final String FILE_NAME = "students.txt";
    private static final Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        while (true) {
            System.out.println("\nStudent Admission System");
            System.out.println("1. Add Student");
            System.out.println("2. Display Students");
            System.out.println("3. Search Student by ID");
            System.out.println("4. Exit");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();
            
            switch (choice) {
                case 1:
                    addStudent();
                    break;
                case 2:
                    displayStudents();
                    break;
                case 3:
                    searchStudentById();
                    break;
                case 4:
                    System.out.println("Exiting...");
                    return;
                default:
                    System.out.println("Invalid choice. Try again.");
            }
        }
    }

    private static void addStudent() {
        try (FileWriter fw = new FileWriter(FILE_NAME, true);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {
            System.out.print("Enter Student ID: ");
            int id = scanner.nextInt();
            scanner.nextLine();
            
            System.out.print("Enter Name: ");
            String name = scanner.nextLine();
            
            System.out.print("Enter Age: ");
            int age = scanner.nextInt();
            scanner.nextLine();
            
            System.out.print("Enter Course: ");
            String course = scanner.nextLine();
            
            Student student = new Student(id, name, age, course);
            out.println(student);
            System.out.println("Student added successfully!");
        } catch (IOException e) {
            System.out.println("Error writing to file.");
        }
    }

    private static void displayStudents() {
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_NAME))) {
            String line;
            System.out.println("\nList of Students:");
            while ((line = br.readLine()) != null) {
                System.out.println(line);
            }
        } catch (IOException e) {
            System.out.println("No students found.");
        }
    }

    private static void searchStudentById() {
        System.out.print("Enter Student ID to search: ");
        int searchId = scanner.nextInt();
        scanner.nextLine();
        
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_NAME))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split(", ");
                if (Integer.parseInt(data[0]) == searchId) {
                    System.out.println("Student Found: " + line);
                    return;
                }
            }
            System.out.println("Student with ID " + searchId + " not found.");
        } catch (IOException e) {
            System.out.println("Error reading file.");
        }
    }
}
