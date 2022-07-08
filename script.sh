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

- name: playbook_2
  hosts: all
  become: true
  tasks:
    - name: get uid
      shell: id
      register: out
    
    - name: print uid
      debug:
        msg: "my user id is {{out}}"    

    - name: install
      yum:
        name: tree
        state: latest

---------------------------------------------------------------------------------
########  when condition ########################

- name: playbook_2
  hosts: all
  gather_facts: yes
  tasks:
    - name: Print the task_1
      debug:
        msg: "{{ansible_distribution}}" 
      when: ansible_distribution == "Ubuntu" and ansible_os_family == "Debian"
      when: (ansible_distribution == "Ubuntu" and ansible_os_family == "Debian") or (ansible_distribution == "Ubuntu" and ansible_os_family == "Debian")
    
    - name: print uid
      debug:
        msg: "my user id is {{ansible_selinux_python_present}}"
###############################################################################################

#####################loop####################

- name : loop name
  hosta: all
  tasks: 
    - name : print city name
      debug: 
        msg: "all my city name : {{item}}"
      loop:
        - nag
        - pune
        - mumbai
        - chandrapur

    - name : install packages
      become: true
      yum: 
        name: "{{item}}"
        state: latest
      loop:
        - httpd
        - vim
        - tree
        - tomcat
########################################
############# Setfacts ################################

- name: setfacts_playbook
  hosts: all
  tasks:
    - name: set fact
      set_fact: URL=["www.google.com","www.igp.com"] city="nagpur"

    - name: print variable
      debug:
        msg: "{{URL}}  {{city}}"

########################## package modules in ansible  ###################
- name: Package server installation
  hosta: all
  tasks:
    - name: package installation
      package: 
        name: httpd
        state: present

############################## copy modules in ansible ################
- name: copy module
  hosts: all
  tasks:
    - name: copy file
      copy: 
        src: <file to copy>
        dest: <location to pest by name>

############################## template modules in ansible ################
- name: template module
  hosts: all
  become: true
  vars:
    demo: <variable name>  # mention in file by: {{}}
  tasks:
    - template:
        src: <file to copy>
        dest: <location to pest by name>

############################## blockinfile modules in ansible ################
- name: blockinfile module
  hosts: all
  become: true
  tasks:
    - blockinfile:
        path: /etc/httpd/conf.d/demo.conf
        create: yes
        block: |
          <virtualhost *:80>
          servername localhost
          documentroot /var/www/html
          </virtualhost>


##################### lineinfile ########################### 
- name: playbook_2
  hosts: all
  become: true
  tasks:
    - lineinfile:
        path: <path of file to insert>
        insertbefore: <line in file, before to be placed>
        #insertafter: <line in file, after to be placed>
        #regexp: <line in file to be replace>
        line: <content to add>
    - debug:
        msg: "added" 

##################### find ########################### 

- name: find playbook
  hosts: all
  become: true
  tasks: 
    - name:
      find:
        path: /var/log  #<where to find>
        file_type: file
        pattern: "*" 
      register: out

    - debug:
        msg={{out}}
-------------------------------------------------------
# get details of path files
    - debug:       
        msg={{item.path}} 
      loop: "{{out.files}}"

# remove details of file stored in register
    - name: remove the files
      file:
        path: "{{item.path}}"
        state: absent
      loop: "{{out.files}}"
-------------------------------------------------------







TASK [websrv : confign file copied] *********************************************************************************************************
ok: [16.170.225.226]

TASK [websrv : start and enableing httpd service] *******************************************************************************************
ok: [16.170.225.226]

PLAY RECAP **********************************************************************************************************************************
16.170.225.226             : ok=7    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

root@ip-172-31-38-59:/practice/shubham_b# vim websrv/tasks/main.yml
    name: nginx
    state: latest

- name: download web-application
  get_url:
    url: https://www.free-css.com/assets/files/free-css-templates/download/page280/sungla.zip
    dest: /usr/share/nginx/html

- name: install package unzip
  package:
    name: unzip
    state: latest

- name: extracting zip file
  unarchive:
    src: /usr/share/nginx/html/sungla.zip
    dest: /usr/share/nginx/html
    remote_src: true

- name: confign file copied
  become: true
  copy:
    src: websrv/files/demo.conf
    dest: /etc/nginx/conf.d/demo.conf
  notify:
   - restart httpd

- name: start and enableing httpd service
  service:
    name: nginx
    state: started
...
    
    
    ---------------------------------------------------------------------
    
