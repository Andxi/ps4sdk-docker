 ====================
  What does this do?
 ====================

  This program will automatically build a docker image with
  ps4sdk, elf-loader and other various tools ready to be used for homebrew development on 5.05 PS4.

 ====================
  How do I build it?
 ====================

 Open Dockerfile and change IP addresses of both your local machine and PS4.
 This is needed for ps4sh to work.

 Build the image (--rm flag is for cache usage):

   docker build --rm==false -t ps4sdk-docker .

 Copy the helper script:

   cp ps4sdk-docker.sh /usr/local/bin

 OR add the directory where you cloned this repository to the $PATH

 ==================
  How do I use it?
 ==================

 Use the helper script to run elf-loader:

   ps4sdk-docker.sh

 Or, use the helper script to run 'make':

   ps4sdk-docker.sh make

 The local folder will be mounted as /build inside docker.

 ============================
  How do I save and load it?
 ============================

 Save the image:

   docker save ps4sdk-docker | bzip2 > ps4sdk-docker.tar.bz2

 Load the image:

   docker load < bzip2 -dc ps4sdk-docker.tar.bz2
