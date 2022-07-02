name: Playbook1
  hosta: all
  vars: 
    URL: www.google.com
    URL_i: www.google.com/images
  tasks:
  - name: Print messages
    debug:
      msg:
        welcome to cloudblitz
        my name is swapnil
----------------------------------------------------------------
  - name: Print messages_1
      debug:
        msg: "{{URL}}"

  - name: Print messages_2
      debug:
        msg: "{{URL_i}}"

  - name: Print messages_3
      debug:
        msg: "{{URL}}"
      vars:
        URL: local.google.com
----------------------------------------------
  vars_files: <file_name.yml(URL_2: abc.google.com)>
  -name: Print messages_4
      debug:
        msg: "{{URL_2}}"
-----------------------------------------------------

	#pass variables with help of prompt
- name: Playbook2
  hosts: all
  vars:
    URL: Global

  vars_files:
    - data.yml

  vars_prompt:
    - name: URL
      prompt: "ENTER URL"
      private: no

  tasks:
    - name: Print messages_2
      debug:
        msg: "{{URL}}"



	-------------------------------------------------------------------------------------------
	- name: Playbook1
  hosts: all
  vars:
    URL: www.google.com
    URL_i: www.google.com/images
  tasks:
    - name: Print messages
    - ping:
      debug:
        msg:
          welcome to cloudblitz
          my name is swapnil
---------------------------------------------------------------------
############# to ignore errors #####################
- name: playbook_3
  hosts: all
  tasks:

    - name: get output
      shell:  ps -elf | grep sleep | grep - v grep
      ignore_errors: yes

    -name: print massage
      debug:
        msg: "hello world"


-----------------------------------------------------------
########### use of tags  ############# (-t <tag name>)
- name: playbook_2
  hosts: all
  gather_facts: no
  tasks:

    - name: Print the task_0
      debug:
        msg: "{{ansible_selinux_python_present}}"
      tags: 0


    - name: Print the task_1
      debug:
        msg: "web server"
      tags: 1

    - name: Print the task_2
      debug:
        msg: "db server"
      tags: 2

    - name: Print the task_3
      debug:
        msg: "my server"
      tags: 3

    - name: Register value
      shell: uptime
      register: result

    - name: Printing the Register value
      debug:
        msg: "{{result.stdout}}"

---------------------------------------------------------------------------------
########  root Escalation ########################

# - name: playbook_2
#   hosts: all
#   become: true
#   tasks:
#     - name: get uid
#       shell: id
#       register: out

#     - name: print uid
#       debug:
#         msg: "my user id is {{out}}"

#     - name: install
#       yum:
#         name: tree
#         state: latest
