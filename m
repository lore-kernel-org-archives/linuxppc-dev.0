From: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>
Message-Id: <199909212155.OAA15362@falcon.csc.calpoly.edu>
Subject: Re: USB driver not detecting mouse? (lots of detail)
To: hay@colorado.edu
Date: Tue, 21 Sep 1999 14:55:13 -0700 (PDT)
Cc: linuxppc-dev@lists.linuxppc.org (linuxdev)
In-Reply-To: <19990921193653.14861.rocketmail@web125.yahoomail.com> from "David Hay" at Sep 21, 99 12:36:53 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 
> I got the 2.3 USB code from cvs.on.openprojects.net.  I had to update it a
> bit to include the 2.2 spinlock.h since it seems to have moved in the 2.3
> kernel.  If I think of it, I'll try to make some patches once I get home...

Right...  And you had to change the pci_dev structure access to the old struct
correct?

Ok I decided to do it your way and I get things working sort of.  My machine
does not crash, which is a HUGE milestone for me.  ;-)  (knock on wood at least
not crashed yet.

> 
> Where are these patches you speak of?  From reading the docs in the USB
> driver, these patches have made it into the USB tree...or are there non-USB
> patches that need to be applied?
> 

I don't think you need the patches.  You got the source from the same place I
did.  I was getting some data access exceptions/crashes and that was because I
got my source from kernel.org BEFORE.

The cvs source should be good.  Now why it does not work?  I don't know.  I had
my fiance try the mouse but I think I may have XF86 set up wrong?  I have to
get home to try it.  But when she (un)pluged the mouse in the software
recongnized it and printed associated messages in my kernel.log so that is
good.

I will let you do the patches.  I can't figure patches out...  ;-0

Sorry
Ira Weiny

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
