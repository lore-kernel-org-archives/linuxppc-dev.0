Date: Tue, 29 Aug 2000 02:17:49 +0900 (KST)
From: Seong-kyu Ko <sugenius@doit.ajou.ac.kr>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problems of the corss-compiler.
Message-ID: <Pine.LNX.4.21.0008290209060.960-100000@doit.ajou.ac.kr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
