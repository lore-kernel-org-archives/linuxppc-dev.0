Message-ID: <3712C0A0.C2C68F44@dgs.monash.edu.au>
Date: Tue, 13 Apr 1999 03:57:20 +0000
From: Brendan Simon <brendan@dgs.monash.edu.au>
Reply-To: brendan@dgs.monash.edu.au
MIME-Version: 1.0
To: linuxppc-user <linuxppc-user@lists.linuxppc.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        linux-embedded <linux-embedded@waste.org>
Subject: Booting Linux from Flash
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I want to run Linux (linuxppc) on a custom MPC860 board with 32MB DRAM
and 2-4MB of Flash.  This is pure memory mapped flash (not ide
compatible).

What do I need to build and boot an embedded linux system ?

1) Cross Compiler:  I have egcs-1.1b built from the RTEMS build scripts
for powerpc.

2) C libraries:  Do I need these and how are they compiled ?  Is newlib
or glibc required ?

3) Kernenl sources:  How to cross compile ?  Is it as simple as
CC=powerpc-eabi-gcc & make ?

4) What about support executables like init, bash/ash/sh ?  Are the
sources included with the kernel or do I have to get them elsewhere and
compile them with the cross compiler ?

5) I guess I need to write a bootloader.  What does the bootloader have
to do and how do I pass parameters to the kernel ?

6) If I have a root file system image compressed in Flash, how does it
get uncompressed into RAM.  How do I tell the kernel where the root FS
is ?

Thanks,
Brendan Simon.

PS.  Are there any HOWTOs which cover booting from Flash (not Flash IDE
drives).
Ta.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
