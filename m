Date: Wed, 24 Nov 1999 12:41:56 -0700 (MST)
From: Jeff Hubbach <hubbach@esus.cs.montana.edu>
To: Giuliano Pochini <pochini@denise.shiny.it>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Floppy problems
In-Reply-To: <383C1032.9C117E07@denise.shiny.it>
Message-ID: <Pine.OSF.3.95.991124123858.9528B-100000@esus.cs.montana.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I finally got my floppy working on a 8500 running LinuxPPC '99 Q3, but if
I try a mkfs /dev/fd0 on my 9600 with the same Linux, it gets to the part
where it's "writing superblock" and just hangs. I don't understand why it
would work on the 8500, but not on the 9600. Same install, same kernel,
maybe it's the different motherboard?

Any input would be greatly appreciated...

------------------------------------
Jeff Hubbach                       |
Computer Science Student           |   
Montana State University           |      
http://www.cs.montana.edu/~hubbach |
------------------------------------

On Wed, 24 Nov 1999, Giuliano Pochini wrote:
> >     I've never gotten my floppy drive to work under Linuxppc, it works fine
> >     under MacOS.  When accessing the floppy, it sounds ok, but the close ()
> >     system call doesn't return.  After this, the fd0 device can't be accessed
> >     again because it's busy.  The process can't be killed.
> >     [...]
> Same problem here, mainly on write accesses.
> 
> Pmac 7300 with all kernels.
> 
> Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
