Date: Wed, 19 May 1999 11:14:12 -0500 (CDT)
From: Mark Lin <mlin@MPI-Softtech.Com>
To: linuxppc-dev@lists.linuxppc.org
cc: linux-kernel@vger.rutgers.edu
Subject: 2.3.3 compile error on ppc
Message-ID: <Pine.SOL.4.05.9905191112430.18118-100000@mpi.mpi-softtech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -c -o fork.o fork.c
fork.c: In function `mm_alloc':
fork.c:306: warning: implicit declaration of function `init_MUTEX_LOCKED'
fork.c: In function `do_fork':
fork.c:539: warning: implicit declaration of function `DECLARE_MUTEX_LOCKED'
fork.c:539: `sem' undeclared (first use in this function)
fork.c:539: (Each undeclared identifier is reported only once
fork.c:539: for each function it appears in.)
make[2]: *** [fork.o] Error 1
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/kernel'
make: *** [_dir_kernel] Error 2

Where's the site for the ppc patched kernels?

--
Mark Lin
MPI Software Technology, Inc.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
