module com.mycompany.javaproj {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;
    
    opens com.mycompany.javaproj to javafx.fxml;
    exports com.mycompany.javaproj;
}
