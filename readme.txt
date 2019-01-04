 ====================
  What does this do?
 ====================

  This program will automatically build a docker image with
  ps4sdk, elf-loader and other various tools ready to be used for homebrew development on 5.05 PS4.

 ====================
  How do I build it?
 ====================

 IMPORTANT: Open Dockerfile and change IP addresses of both your local machine and PS4. (PS4IP and LOCALIP)
 This is needed for ps4sh to work.

 Build the image (--rm flag is for cache usage):

   docker build --rm==false -t ps4sdk-docker .

 Copy the helper script:

   cp ps4sdk-docker.sh /usr/local/bin

 OR add the directory where you cloned this repository to the $PATH

 ==================
  How do I use it?
 ==================

 Use the helper script to run bash in the docker container:

   ps4sdk-docker.sh

 Or, use the helper script to run 'make':

   ps4sdk-docker.sh make

 The local folder will be mounted as /build inside docker.

 There are some aliases inside the docker container available for you to use:

 ps4sh      - Executes ps4sh installed
 elfcp      - When building the homebrew.elf executable, move this file to the ps4sh directory to start serving that file.

 And the following enviroment variables are available:

 $PS4SH     - directory where ps4sh is installed
 $PS4DEV    - directory where ps4dev tools are installed
 $PS4SDK    - directory where ps4sdk is installed

 ============================
  How do I save and load it?
 ============================

 Save the image:

   docker save ps4sdk-docker | bzip2 > ps4sdk-docker.tar.bz2

 Load the image:

   docker load < bzip2 -dc ps4sdk-docker.tar.bz2

 ============================
  What else is there?
 ============================

 Orbislink.pkg is added here. Install and start it on the PS4. The ServerIP is hardcoded (I think) to 192.168.1.3,
 so make sure the computer running PS4SH is that IP address. Else the PS4 won't be able to connect.

 Also the homebrew started from that Orbislink.pkg is only homebrew.elf.
 If assets (such as audio files) are missing when serving homebrew.elf via ps4sh you will only see a black screen via Orbislink.