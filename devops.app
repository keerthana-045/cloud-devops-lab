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

    public int getId() {
        return id;
    }

    public void updateDetails(String name, int age, String course) {
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
    private static final List<Student> students = new ArrayList<>();

    public static void main(String[] args) {
        loadStudents();
        while (true) {
            System.out.println("\nStudent Admission System");
            System.out.println("1. Add Student");
            System.out.println("2. Display Students");
            System.out.println("3. Search Student by ID");
            System.out.println("4. Edit Student");
            System.out.println("5. Delete Student");
            System.out.println("6. Sort Students");
            System.out.println("7. Exit");
            System.out.print("Enter your choice: ");

            int choice = scanner.nextInt();
            scanner.nextLine(); 

            switch (choice) {
                case 1 -> addStudent();
                case 2 -> displayStudents();
                case 3 -> searchStudent();
                case 4 -> editStudent();
                case 5 -> deleteStudent();
                case 6 -> sortStudents();
                case 7 -> {
                    saveStudents();
                    System.out.println("Exiting...");
                    return;
                }
                default -> System.out.println("Invalid choice! Try again.");
            }
        }
    }

    private static void addStudent() {
        System.out.print("Enter ID: ");
        int id = scanner.nextInt();
        scanner.nextLine();
        
        System.out.print("Enter Name: ");
        String name = scanner.nextLine();
        
        System.out.print("Enter Age: ");
        int age = scanner.nextInt();
        scanner.nextLine();
        
        System.out.print("Enter Course: ");
        String course = scanner.nextLine();

        students.add(new Student(id, name, age, course));
        System.out.println("Student added successfully!");
    }

    private static void displayStudents() {
        if (students.isEmpty()) {
            System.out.println("No students found!");
            return;
        }
        students.forEach(System.out::println);
    }

    private static void searchStudent() {
        System.out.print("Enter Student ID: ");
        int id = scanner.nextInt();
        students.stream()
                .filter(s -> s.getId() == id)
                .findFirst()
                .ifPresentOrElse(
                        System.out::println,
                        () -> System.out.println("Student not found!"));
    }

    private static void editStudent() {
        System.out.print("Enter Student ID to edit: ");
        int id = scanner.nextInt();
        scanner.nextLine();

        for (Student s : students) {
            if (s.getId() == id) {
                System.out.print("Enter New Name: ");
                String name = scanner.nextLine();
                
                System.out.print("Enter New Age: ");
                int age = scanner.nextInt();
                scanner.nextLine();
                
                System.out.print("Enter New Course: ");
                String course = scanner.nextLine();
                
                s.updateDetails(name, age, course);
                System.out.println("Student updated successfully!");
                return;
            }
        }
        System.out.println("Student not found!");
    }

    private static void deleteStudent() {
        System.out.print("Enter Student ID to delete: ");
        int id = scanner.nextInt();
        students.removeIf(s -> s.getId() == id);
        System.out.println("Student deleted successfully!");
    }

    private static void sortStudents() {
        students.sort(Comparator.comparing(s -> s.toString()));
        System.out.println("Students sorted successfully!");
        displayStudents();
    }

    private static void loadStudents() {
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_NAME))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(", ");
                students.add(new Student(
                        Integer.parseInt(parts[0]), 
                        parts[1], 
                        Integer.parseInt(parts[2]), 
                        parts[3]
                ));
            }
        } catch (IOException e) {
            System.out.println("No existing data found, starting fresh.");
        }
    }

    private static void saveStudents() {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_NAME))) {
            for (Student s : students) {
                bw.write(s.toString());
                bw.newLine();
            }
            System.out.println("Student data saved successfully!");
        } catch (IOException e) {
            System.out.println("Error saving student data.");
        }
    }
}
