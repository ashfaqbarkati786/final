from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://randomuser:r4nd0mP4ssw0rd@db-service:3306/sampledb'
db = SQLAlchemy(app)

# Define your Student model
class Student(db.Model):
    __tablename__ = 'student'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50))
    email = db.Column(db.String(50))
    student_id = db.Column(db.String(50))
    question = db.Column(db.Text)

    def __repr__(self):
        return f"<Student(name='{self.name}', email='{self.email}', student_id='{self.student_id}', question='{self.question}')>"

# Create the table
with app.app_context():
    db.create_all()

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        # Retrieve form data
        name = request.form['name']
        email = request.form['email']
        student_id = request.form['student_id']
        question = request.form['question']

        # Create a new Student object
        student = Student(name=name, email=email, student_id=student_id, question=question)

        # Add the student to the database
        with app.app_context():
            db.session.add(student)
            db.session.commit()

        return 'Form data submitted successfully'

    questions = Student.query.with_entities(Student.question, Student.email).all()

    return render_template('index.html', questions=questions)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)
