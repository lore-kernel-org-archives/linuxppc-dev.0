Message-ID: <383C1032.9C117E07@denise.shiny.it>
Date: Wed, 24 Nov 1999 17:20:02 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Floppy problems
References: <199911201327.OAA17266@appel.flower>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>     I've never gotten my floppy drive to work under Linuxppc, it works fine
>     under MacOS.  When accessing the floppy, it sounds ok, but the close ()
>     system call doesn't return.  After this, the fd0 device can't be accessed
>     again because it's busy.  The process can't be killed.
> 
>     [...]

Same problem here, mainly on write accesses.

Pmac 7300 with all kernels.

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
