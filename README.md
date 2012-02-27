# About

yGit is a Rails app for hosting and managing private git repos.

# Installation

1) Backup the authorized_keys file on the server.

    ~/.ssh/authorized_keys

2) Copy the application.example.yml to application.yml and make configuration changes as necessary.

    ...
    production:
      app_title: "yGit"
      repo_path: "~/repos" # path to the repo folder on the same server
      repo_host: "user@git.example.com:repos" # the root path git will use to access repos
      authorized_keys_path: "/home/user_name/.ssh" # location of the ssh folder
      basic_auth_user: "user" 
      basic_auth_password: "password1"
      admin_email: "me@example.com"

3) Deploy the application.

4) Using the application add one or more public ssh keys. 

5) Create a new repo.

6) Clone the repo using git.
