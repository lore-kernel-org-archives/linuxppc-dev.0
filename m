Message-ID: <A33AEFDC2EC0D411851900D0B73EBEF7063E55@NAPA>
From: Hua Ji <hji@netscreen.com>
To: "'crossgcc@sources.redhat.com'" <crossgcc@sources.redhat.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Hello World and 405GP with my gcc cross compiling.
Date: Wed, 17 Jan 2001 14:31:55 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for all feedback. Please review my current postion.

----------------------
cannot find entry symbol _start; defaulting to 01800074
/var/tmp/ccAEuQ8q.o: In function `ppctest':
/var/tmp/ccAEuQ8q.o(.text+0x20): undefined reference to `printf'
GNU ld version 2.9.1 (with BFD 2.9.1)
  Supported emulations:
   elf32ppc
----------------------

My current position is:

I have no problem for creating the object file, say, HelloWorld.o by using
my
gcc for powerpc-elf under a solaris. And then I moved the object file from
solaris to a PC and
used the IBM High c/C++ linker to link my Helloworld.o with the sample
"usr_samp"
codes provided by IBM 405GP reference kit. It works fine after being loaded
with
the tftp... In other words, it is running on my 405GP reference board and
print out my
inserted "hello world..."!

So, my conclusion is: my gcc for powerpc-elf works, at least for creating
object file part.

Now, why I can't direct creat the executable file but get the above compain?
Looks like
it can't find correct libc codes, for example, the __start and printf symbol
and so on.

What my environment is: I used newlib to creat my libc.a. However, I am not
sure if my native
gcc use gnulic or newlib. does this matter?

Any clue, folks,

Hua

Attached is information I copied from my 405gp board terminal
----
---------------------------
Transfer Complete ...
Loaded successfully ...
Entry point at 0x26898 ...
Pinging host to select baud rate (press any key to quit).
  trying 56000
SLIP not active.

*****Hello World from Hua JI!
*****This is a test for gcc for powerpc

Hello 405GP user!

Your ROM Monitor version is : 1.13

Your 405GP Evaluation Board has 134217728 bytes of SDRAM installed.
Processor speed is 200MHz
PLB speed is       100MHz.
PCI speed is       33MHz.

Your built-in Ethernet controller's network address is :  0004ace31112
Your PCI Ethernet controller's network address is      :  000000000000

usr_samp done!
---------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
