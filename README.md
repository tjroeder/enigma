![image](https://user-images.githubusercontent.com/78194232/141664189-d4d85cf1-058e-47c6-ab41-51ffd9917001.png)

# Enigma
Is a program created to take secret messages, encrypt them using a modified [Caesar Cipher](https://en.wikipedia.org/wiki/Caesar_cipher). The program can be utilized from the CLI with arguements passed in the terminal.
## Setup (for Unix based systems):
### 1. Clone this repository:
---
Theres is no need to fork the repository, cloning is just fine to your directory of choice. Start by opening up your terminal, and typing the following commands for either ssh or https to clone the directory. Once cloned, you'll have a new local copy in your directory.
```shell
// using ssh key
$ git clone git@github.com:tjroeder/enigma.git

// using https
$ git clone https://github.com/tjroeder/enigma.git
```
### 2. Change to the project directory:
---
In terminal, utilize the `cd` command to change to the enigma project directory. 
```shell
$ cd enigma/
```

### 3. Install required Gems utilizing Bundler:
---
In terminal, use Bundler to install any missing Gems. If Bundler is not installed first run the following command.
```shell
$ gem install bundler
```

If Bundler is already installed or after it has been installed, then run the following command.
```shell
$ bundle install
```
There should be be verbose text diplayed of the installation process that looks similar to below. (this is not an actual copy of what will be output).
```shell
$ bundle install
Fetching gem metadata from https://rubygems.org/........
Resolving dependencies...
Using bundler 2.1.4
Using byebug 11.1.3
Fetching coderay 1.1.2
Installing coderay 1.1.2
Using diff-lcs 1.4.4
Using method_source 1.0.0
Using pry 0.13.1
Fetching pry-byebug 3.9.0
Installing pry-byebug 3.9.0
Fetching rspec-support 3.10.1
Installing rspec-support 3.10.1
Fetching rspec-core 3.10.1
Installing rspec-core 3.10.1
Fetching rspec-expectations 3.10.1
Installing rspec-expectations 3.10.1
Fetching rspec-mocks 3.10.1
Installing rspec-mocks 3.10.1
Fetching rspec 3.10.0
Installing rspec 3.10.0
Bundle complete! 3 Gemfile dependencies, 12 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

If there are any errors, verify that bundler or your ruby environment was correctly setup.

## Encrypt and Decrypt messages:
### 1. Message to encrypt:
---
Open the message text file in your preferred text editor.
```shell
$ code message.txt
```
Once the file is open type, or paste your message to encrypt. Save and close the file.

### 2. Encrypt command line input:
---
In the terminal, run the `encrypt.rb` file with arguments for the message and encrypted message paths.
```shell
$ ruby ./lib/encrypt.rb message.txt encrypted.txt
```
Open `encrypted.txt` to view the encrypted message.

### 3. Decrypt command line input:
---
In the terminal, run the `decrypt.rb` file with arguments for the encrypted, and decrypted message paths, and the key and date strings that were used to create the decrypted message. For example see the below possible terminal command.
```shell
$ ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82548 240818
```
Open `decrypted.txt` to view the newly decrypted message.

# Contributor:

[Tim Roeder](https://github.com/tjroeder)

# Rubric:

|Categories   |Score  |Personal Evaluation |
|-------------|:-----:|-------------------:|
|Functionality|3      |Enigma class encrypt work, encrypt/decrypt from CLI works.|
|OOP          |4      |Used both superclass and module. Superclass (Cipher) used with attributes. Cipher could be used for other non-Enigma cipher machines. Module Inputs and Outputs controls all IO for Enigma. No attributes used.|
|Ruby Conventions|4   |Code is well formatted, short efficient methods, helpers are used when needed.|
|TDD          |4      |SimpleCov of 100%, all methods tested extensively, mocks and stubs are used when appropriate.|
|Version Control|4    |15 PRs, 50+ commits, numerous branches for most methods and features.|
---
This project is based on the starter repository for the [Turing School](https://turing.io/) Enigma project.

###### Do not use for delivering secret messages in times of war. This is much better for passing notes in school.