From: nsheeley@austin.rr.com
Date: Wed, 24 Feb 1999 16:34:23 -0600 (CST)
Reply-To: nsheeley@austin.rr.com
Subject: semaphore-helper.h
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Message-ID: <013092421221829FE5@mail5.austin.rr.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I just checked out the current CVS from 

:pserver:cvs@cvs.samba.org:/cvsroot

All seems well until I try to do a make:

make[2]: Entering directory `/local/src/CVS_kernel/linux/kernel'
gcc -D__KERNEL__ -I/local/src/CVS_kernel/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -fno-omit-frame-pointer -c -o sched.o sched.c
sched.c:39: asm/semaphore-helper.h: No such file or directory

Hmm.. only three arch's asm-includes have semaphore-helper.h
(i386, sparc, sparc64), but its not ifdef'ed in any way in
sched.c

So my question are:
		
	a.  Should I expect to be able to CVS checkout and
	    make a working kernel?  I am wondering about the stability 
	    of the tree -- what's my percent chance that I won't have
	    to debug anything? 

	b.  If yes to a., does anyone have a patch for the above problem.

Thanks.

Nate








[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
