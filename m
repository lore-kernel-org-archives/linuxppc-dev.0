Message-ID: <3C487FC2.85553E91@midrivers.com>
Date: Fri, 18 Jan 2002 13:04:18 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: building gdbserver 5.0
References: <3C44A4AF.9000302@cray.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've searched for info on building gdbserver from gdb5.0 w/o
success -- any pointers?

I cd .../gdb-5.0/gdb/gdbserver,
./configure --target=powerpc-linux --host=i586-pc-linux-gnu
make CC=powerpc-linux-gcc

3 objects are created:
remote-utils.o  server.o  utils.o

and the following are undefined @ link:
mywait, kill_inferior, mythread_alive, registers and a few others.

I suspect that some other source should be compiled in but am not
seeing how to configure so that it's mentioned in the Makefile.

suggestions appreciated,
Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
