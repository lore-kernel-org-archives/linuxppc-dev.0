Message-Id: <3.0.1.32.20000520100736.006c7434@pop.mail.yahoo.com>
Date: Sat, 20 May 2000 10:07:36 +0500
To: <linuxppc-embedded@lists.linuxppc.org>
From: "RAJESH.B.V" <rajeshbv@trinc.com>
Subject: cross compiling of bash for 8xx
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,
I'm a newbie entered into this Linux world and working on mbx860...
i'm able to build the kernel and succeeded in running it.
But when i try to compile the applications like Bash and all i'm getting
some problem with shared libraries.
i'm using the compiler  powerpc-linux-gcc with version 2.95.2 and glibc
with version 1.99
if i compile with static libraries it is fine.
When compiling   Bash-2.03 when i try to configure with the command
" CC=powerpc-linux-gcc ./configure --target=860 " it is giving error when
it is searching to configure for  "getpgrep".
so the configure is exiting..

And when i compile the ping application it is compiling well and when i try
to run it on my mbx860 board it is displaying an error that
"shared library libc.s0.6 is not found. failed to open libc.so.6"
but actually that lib file is there in the /lib path.

can any one suggest me the solutions for the above..
Is there any site providing  the minimal root file system Disk Image with
libc-6 to download.

Thanks,
Rajesh
******************************************************************

 B.V. Rajesh

 RENDEZVOUS ON CHIP (I) PVT.LTD.
 VOICE: ph:040-7742606 ( Extn )- 306
 mailto:rajeshbv@trinc.com
 Web Page  :   http://www.trinc.com
 ******************************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
