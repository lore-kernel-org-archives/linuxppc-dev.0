Message-Id: <v03110701b462eb31c585@[209.183.131.81]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 25 Nov 1999 08:39:20 -0500
To: yellowdog-general@lists.yellowdoglinux.com,
        linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Announcing jdk 1.2.2 pre-V1 and jdk 1.1.8 final for Linux on PPC
Cc: java-linux@java.blackdown.org, jdk-1.2-porting@java.blackdown.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Your Java Blackdown Porting Team for PPC is pleased to announce:
for Linux on PPC glibc 2.1 based systems (other archs will come soon)

- Sun's Java Development Kit 1.2.2 (Java 2) "pre-release"

- Sun's Java Development Kit 1.1.8 Version 2 (final)

Note: The JDK 1.2.2  is "pre-release" because I have not yet
proven to Sun's satisfaction that it successfully passes all
of the JCK tests (it has passed all of the JCK tests I have
tried to date and should be a very stable port).

**** IMPORTANT / READ THIS *****
Due to recently found bugs in glibc 2.1.2 and in kernel 2.2.13 the following
glibc and kernel (or later versions) are required for native threads to
work!!!!

    - glibc 2.1.3 pre-release or later
    - kernel 2.2.14-pre6 kernel from Paul's linuxcare.com.au site

Both are also available from this site.

If you do *not* want to upgrade at this time, please follow the
instructions given in the README.linuxppc release notes for info
on changing the default threads type to green_threads or the jdk
will not function properly.


What's New
----------

  - complete rewrite of native_threads using the latest linuxthreads
    to create a much improved stable native_threads port.

  - native threads are now the default for both jdk 1.1.8 and jdk 1.2.2

  - fixed the java version release string to say 1.1.8 or 1.2.2

  - fixed problems with Runtime.exec

  - fixed problems with thread interrupts, condvar waiting

  - fixed problems with socket interrupts, socket closing, etc

  - fixed some awt problems under some window managers
    (although some still exist)

  - fixed problems with escape key in textfields

  - plus numerous problem fixes direct from Sun in Swing 1.1.1

  - some bug fixes backported from Sun's 1.3

This will be the *final* releases for jdk 1.1 and jdk 1.2 on
PPC Linux unless serious problems are found.

All development work will be moved to jdk 1.3 with HotSpot.


Where to Get It
---------------

Thanks to both YellowDog Linux and LinuxPPC there are now up-to-date
mirrors for you to download from:

Please check out one of the following sites:

http://khendricks.ivey.uwo.ca/linuxppc/jdk/  (the home website)

ftp://khendricks.ivey.uwo.ca/pub/

ftp://ftp.yellowdoglinux.com

http://www.linuxppc.org/java/                (mirror of the home website)

ftp://ftp.linuxppc.org



Thanks,

Your Blackdown Java Linux Porting Team

p.s. Happy Thanksgiving to the US (we had ours over a month ago!)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
