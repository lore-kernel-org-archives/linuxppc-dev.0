Message-ID: <7283DE19D141D111AD0E00A0C95B195502C5F60A@mail2.aiinet.com>
From: "Whitney, John" <johnw@aiinet.com>
To: "'Seong-kyu Ko'" <sugenius@doit.ajou.ac.kr>,
        linuxppc-embedded@lists.linuxppc.org
Subject: RE: Problems of the corss-compiler.
Date: Mon, 28 Aug 2000 13:38:31 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Depending on what processor you are using, you may or may not need to
compile the development environment to use software floating-point.  The
860 serial does not have the FPU (at least, none that I know of do), while
the 8260 and 603 series do.

Trying to execute code compiled with hardware floating-point on a processor
without this will result in a crash (floating-point exception, I believe).

Most of the tools compile fairly well for software floating-point, but the
glibc code needs some source modification.

John Whitney
johnw@aiinet.com

-----Original Message-----
From: Seong-kyu Ko [mailto:sugenius@doit.ajou.ac.kr]
Sent: Monday, August 28, 2000 1:18 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problems of the corss-compiler.



Hi everyone.
First, I'm sorry for my weak English.

Well, Now I build a powerpc cross-compiler.
so I compiled some binary using that cross-compiler, but
I have some problems.

I think cross-compiler is not problem.
because I compile kernel with that cross-compiler, and
kernel runs good.

but, init, shell etc thease binaries have some problems.
shell cant recieve argument, and some binaries print 'segmentation fault'

I don't know why my compiler can't compile well.

These are the packages that I used.
1. binutils-2.10
2. gcc-2.95.2
3. glibc-2.1.3 (add-ons : glibc-crypt-2.1, glibc-linuxthreads-2.1.3)

First, I compile the binutils for powerpc cpu.
Second, I build cross compiler with gcc.
Third, I compile glibc for powerpc with cross compiler that I made.
Last, I re-build cross compiler include glibc for library.

Please tell me what do you think about that And why the problem happen.
I'll wait your answers.
thank you.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
