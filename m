Date: Wed, 19 May 1999 13:19:20 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Mark Lin <mlin@MPI-Softtech.Com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.3 compile error on ppc
In-Reply-To: <Pine.SOL.4.05.9905191112430.18118-100000@mpi.mpi-softtech.com>
Message-ID: <Pine.LNX.3.96L.990519131538.1355C-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 19 May 1999, Mark Lin wrote:
> 
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -c -o fork.o fork.c
> fork.c: In function `mm_alloc':
> fork.c:306: warning: implicit declaration of function `init_MUTEX_LOCKED'
> fork.c: In function `do_fork':
> fork.c:539: warning: implicit declaration of function `DECLARE_MUTEX_LOCKED'
> fork.c:539: `sem' undeclared (first use in this function)
> fork.c:539: (Each undeclared identifier is reported only once
> fork.c:539: for each function it appears in.)
> make[2]: *** [fork.o] Error 1
> make[2]: Leaving directory `/usr/src/linux/kernel'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory `/usr/src/linux/kernel'
> make: *** [_dir_kernel] Error 2
> 
> Where's the site for the ppc patched kernels?

I think it was Cort who said to stay away from 2.3.x for now, because it will
be broken for us for a little. Were you having problems with 2.2.x?

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
