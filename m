Message-Id: <3.0.1.32.20000524115459.00698868@trinc.com>
Date: Wed, 24 May 2000 11:54:59 +0500
To: <linuxppc-embedded@lists.linuxppc.org>
From: "RAJESH.B.V" <rajeshbv@trinc.com>
Subject: Re: cross compiling of bash for 8xx
In-Reply-To: <veln15asyf.fsf@lipta.cendio.se>
References: <"RAJESH.B.V"'s message of "Sat, 20 May 2000 10:07:36 +0500">
 <3.0.1.32.20000520100736.006c7434@pop.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Marcus,

Thank you for providing the script to compile bash.

Now i am able to compile the bash with some changes.
it gave some error while compiling the  malloc to choose from gnu_malloc
or   gcc_malloc
So i turned off both the options and compiled.
But still it is not executing.
After completing all the checkings at the boot time the board is hanging
without giving the prompt.
I have compiled one more shell called "sash" and able to execute it.
At the same time i have compiled the Busybox and it is also executing under
Sash shell.
I found some binaries which are for PPC8xx at  mvista.com site. From that
site also i have downloaded the bash binary and failed to get the shell.
I did not able to understand why some binaries are executing which are
compiled with the same compiler and some are not...
I am using GCC version 2.95.2 and Glibc version 2.
I checked both the binaries which are working and failed with a hex editor .
They were showing the same shared libraries  as    " /lib/ld.so.1"
and using some  #defines in   "libc.so.6."

Will be there any difference between the binaries compiled with cross
compiler and straight compiler. i feel there should not be.

Thanks in regards,
--Rajesh







At 10:04 PM 5/20/00 +0200, you wrote:
>"RAJESH.B.V" <rajeshbv@trinc.com> writes:
>
>> Hi All,
>> I'm a newbie entered into this Linux world and working on mbx860...
>> i'm able to build the kernel and succeeded in running it.
>> But when i try to compile the applications like Bash and all i'm getting
>> some problem with shared libraries.
>> i'm using the compiler  powerpc-linux-gcc with version 2.95.2 and glibc
>> with version 1.99
>> if i compile with static libraries it is fine.
>> When compiling   Bash-2.03 when i try to configure with the command
>> " CC=powerpc-linux-gcc ./configure --target=860 " it is giving error when
>> it is searching to configure for  "getpgrep".
>> so the configure is exiting..
>
>--target is wrong here.
>
>--build is the environment you are compiling on.
>--host is the environment the program(s) will run on.
>--target is afaik only applicable for binutils, gcc and gdb, and
>specifies the system to generate code for (debug in the case of gdb).
>
>> And when i compile the ping application it is compiling well and when i try
>> to run it on my mbx860 board it is displaying an error that
>> "shared library libc.s0.6 is not found. failed to open libc.so.6"
>> but actually that lib file is there in the /lib path.
>>
>> can any one suggest me the solutions for the above..
>> Is there any site providing  the minimal root file system Disk Image with
>> libc-6 to download.
>
>The ping problem sounds like either a broken development environment
>and/or a broken runtime environment, hard to tell what the problem
>is there. strace and LD_DEBUG=help are your friends.
>
>As for cross compiling bash and other autoconf using applications
>I've been using a handy little wrapper script for configure. It's
>attached to this mail.
>
>//Marcus
>
>
>Attachment Converted: "C:\rajmail\Eudora\attach\acwppc"
>--
>-------------------------------+-----------------------------------
>        Marcus Sundberg        |       Phone: +46 707 452062
>  Embedded Systems Consultant  |      Email: marcus@cendio.se
>       Cendio Systems AB       |       http://www.cendio.com
>
******************************************************************

 B.V. Rajesh

 RENDEZVOUS ON CHIP (I) PVT.LTD.
 VOICE: ph:040-7742606 ( Extn )- 306
 mailto:rajeshbv@trinc.com
 Web Page  :   http://www.trinc.com
 ******************************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
