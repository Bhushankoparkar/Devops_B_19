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

