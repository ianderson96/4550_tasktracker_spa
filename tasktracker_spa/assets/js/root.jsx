import React from "react";
import ReactDOM from "react-dom";
import _ from "lodash";
import $ from "jquery";
import { Link, BrowserRouter as Router, Route } from "react-router-dom";
import { Redirect } from "react-router-dom";

export default function root_init(node) {
  let tasks = window.tasks;
  let users = window.users;
  ReactDOM.render(<Root tasks={tasks} users={users} />, node);
}

class Root extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      tasks: props.tasks,
      users: props.users,
      login_form: { email: "", password: "" },
      session: null,
      register_form: {email: "", password_hash: "", admin: false},
      task_form: {title: "", desc: "", completed: false, minutes: 0}
    };
  }

  fetch_tasks() {
    $.ajax("/api/v1/tasks", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: resp => {
        let state1 = _.assign({}, this.state, { tasks: resp.data });
        this.setState(state1);
      }
    });
  }

  update_login_form(data) {
    let form1 = _.assign({}, this.state.login_form, data);
    let state1 = _.assign({}, this.state, { login_form: form1 });
    this.setState(state1);
  }

  login() {
    $.ajax("/api/v1/auth", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify(this.state.login_form),
      success: resp => {
        let state1 = _.assign({}, this.state, { session: resp.data });
        this.setState(state1);
      }
    });
  }

  update_register_form(data) {
    let form1 = _.assign({}, this.state.register_form, data);
    let state1 = _.assign({}, this.state, { register_form: form1 });
    this.setState(state1);
  }

  register() {
    $.ajax("/api/v1/users", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({user: this.state.register_form}),
      success: resp => {
        let state1 = _.assign({}, this.state, { session: {user_id: resp.data.id }});
        this.setState(state1);
        this.fetch_users();
      }
    });
  }

    createTask() {
    $.ajax("/api/v1/tasks", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({task: this.state.task_form}),
      success: resp => {
        this.fetch_tasks();
      }
    });
  }

  update_task_form(data) {
    let form1 = _.assign({}, this.state.task_form, data);
    let state1 = _.assign({}, this.state, { task_form: form1 });
    this.setState(state1);
  }

    fetch_users() {
    $.ajax("/api/v1/users", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: (resp) => {
        let state1 = _.assign({}, this.state, { users: resp.data });
        this.setState(state1);
      }
    });
  }

  render() {
    return (
      <div>
        <Router>
          <div>
            <Header session={this.state.session} root={this} />
            <Route
              path="/"
              exact={true}
              render={() => <TaskList tasks={this.state.tasks} />}
            />
            <Route
              path="/users"
              exact={true}
              render={() => <UserList users={this.state.users} />}
            />
            <Route
              path="/register"
              exact={true}
              render={() => <RegisterForm root={this} />}
            />
            <Route
              path="/create"
              exact={true}
              render={() => <TaskForm root={this} />}
            />
          </div>
        </Router>
      </div>
    );
  }
}

function Header(props) {
  let { root, session } = props;
  let loginView;
  if (session) {
      loginView = <p>{"Welcome back, " + session.user_id}</p>;
  }
  else {
      loginView = <div className="form-inline my-2">
          <input
            type="email"
            placeholder="email"
            onChange={ev => root.update_login_form({ email: ev.target.value })}
          />
          <input
            type="password"
            placeholder="password"
            onChange={ev =>
              root.update_login_form({ password: ev.target.value })
            }
          />
          <button onClick={() => root.login()} className="btn btn-primary">
            Login
          </button>
          <p><Link to={"/register"}> or Register an Account</Link></p>
        </div>;
  }
  return (
    <div className="row my-2">
      <div className="col-2">
        <p>
          <Link to={"/"}>Tasktracker</Link>
        </p>
      </div>
      <div className="col-2">
        <p>
          <Link to={"/users"}>Users</Link>
        </p>
      </div>
      <div className="col-6">
        {loginView}
      </div>
    </div>
  );
}

function TaskList(props) {
  let tasks = _.map(props.tasks, t => <Task key={t.id} task={t} />);
  return <div className="container">
  <Link to={"/create"}><button className="btn btn-primary">Create Task</button></Link>
  <div className="row">
  {tasks}
  </div>
  </div>;
}

function Task(props) {
  let { task } = props;
  let completed;
  if (task.completed) {
      completed = "Task Completed";
  }
  else {
      completed = "";
  }
  return (
    <div className="card col-4">
      <div className="card-body">
        <h2 className="card-title">{task.title}</h2>
        <p className="card-text">
          {task.desc} <br />
          Time spent: {task.minutes}
          <br />
          {completed}
        </p>
      </div>
    </div>
  );
}

function UserList(props) {
  let rows = _.map(props.users, uu => <User key={uu.id} user={uu} />);
  return (
    <div className="row">
      <div className="col-12">
        <table className="table table-striped">
          <thead>
            <tr>
              <th>email</th>
              <th>admin?</th>
            </tr>
          </thead>
          <tbody>{rows}</tbody>
        </table>
      </div>
    </div>
  );
}

function User(props) {
  let { user } = props;
  return (
    <tr>
      <td>{user.email}</td>
      <td>{user.admin ? "yes" : "no"}</td>
    </tr>
  );
}

function RegisterForm(props) {
    let {root} = props;
    return <div>
        <h1>Register an Account</h1>
    <div className="row">
          <input
            type="email"
            placeholder="email"
            onChange={ev => root.update_register_form({ email: ev.target.value })}
          />
          <input
            type="password"
            placeholder="password"
            onChange={ev =>
              root.update_register_form({ password_hash: ev.target.value })
            }
          />
          <button onClick={() => root.register()} className="btn btn-secondary">
            Register
          </button></div>
          </div>;
}

function TaskForm(props) {
        let {root} = props;
    return <div>
        <h1>Create a Task</h1>
    <div className="row">
          <input
            type="text"
            placeholder="title"
            onChange={ev => root.update_task_form({ title: ev.target.value })}
          /><br />
          <input
            type="text"
            placeholder="description"
            onChange={ev =>
              root.update_task_form({ desc: ev.target.value })
            }
          /><br />
          <p>Completed: </p>
          <input
            type="checkbox"
            onChange={ev =>
              root.update_task_form({ completed: ev.target.checked })
            }
          />
          <Link to={"/"}>
          <button onClick={() => root.createTask()} className="btn btn-secondary">
            Create Task
          </button></Link>
          </div>
          </div>;
}
