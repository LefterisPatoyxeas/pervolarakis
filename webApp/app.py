from flask import Flask, render_template,url_for
from markupsafe import escape
app = Flask(__name__)


@app.route("/")
def index():
    # SQL Query
    return render_template('home.html')

@app.route('/hello/')
@app.route('/hello/<name>')
def hello(name=None):
    return render_template('hello.html', name=name)

@app.get('/user/<username>')
def show_user_profile(username):
    # show the user profile for that user
    return f'User {escape(username)}'

@app.get('/books')
def get_books():
    # show the user profile for that user
    # books = SQL.qure('Select * from Books')
    # books = ['O arxonsas ']
    return render_template('books.html', books = books)

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        return do_the_login()
    else:
        return show_the_login_form() 


@app.route('/path/<path:subpath>')
def show_subpath(subpath):
    # show the subpath after /path/
    return f'Subpath {escape(subpath)}'