Date: Tue, 22 Aug 2000 01:22:29 +0900 (KST)
From: Seong-kyu Ko <sugenius@doit.ajou.ac.kr>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problems using shared library in corss environment
Message-ID: <Pine.LNX.4.21.0008220121070.24904-100000@doit.ajou.ac.kr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody.
First, I'm sorry for my weak English, but please read my problem and help
me.

I have some problems in building a powerpc corss compiler environment.
I'm now trying to build a cross environment, the host is i386 and target
is powerpc.

These are the packages that I used.
1. binutils-2.10
2. gcc-2.95.2
3. glibc-2.1.3 (add-ons : glibc-crypt-2.1, glibc-linuxthreads-2.1.3)

First, I compile the binutils for powerpc cpu.
Second, I build cross compiler with gcc.
Third, I compile glibc for powerpc with cross compiler that I made.
Last, I re-build cross compiler include glibc for library.

And I compiled kernel with cross compiler that I made.
Yeah, it's ok. And I compile 'init' with static library.

but I compile shell with shared labrary, it use ld.so.1 and libc.so.6
The problem is ld.so.1 can't found libc.so.6
The error message is this :
'error in loading shared libraries: libc.so.6: cannot open shared object
file: No such file or directory'

Please tell me why it can't find that and how can I solve this problem.
I'll wait your answers.
thank you.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
