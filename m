From: kd@flaga.is
Subject: [Summary] : pthreads, glibc2.1.2 problems
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF6B16E16F.BFA6D70C-ON0025683C.00357F1E@flaga.is>
Date: Fri, 3 Dec 1999 09:51:11 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

The problem I was having was not because of the compilers, or kernel. It is
somehow related to the Glibc library. Even if I compile the pthread test
program as static it does not run unless it (the program) has access to the
shared libraries. I.e. pthread_create() blocked on the installation where I
had no libc installed but runs  perfectly (both as static and dinamically
linked) on the installation where Glibc was installed (with both kernels
2.2.5 and 2.2.13). Now I just have to figure out exactly which dll I need
to supply in order to get it to run as statically linked program.

Thanks to those who ran my simple test program and reported to me. It was
most helpful.

K.D.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
