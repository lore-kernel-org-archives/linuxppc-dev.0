From: Paul Mackerras <paulus@linuxcare.com>
To: linuxppc-dev@lists.linuxppc.org, Kevin Hendricks <khendricks@ivey.uwo.ca>
Subject: Re: Kernel debugging??
Date: Fri, 19 Nov 1999 10:29:20 +1100
Content-Type: text/plain
References: <99111813382301.00618@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <99111912073001.09736@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 19 Nov 1999, Kevin Hendricks wrote:

> By the way, I updated from the samba site after the linuxcare site went up (I
> didn't know about the linuxcare site).  To get a good source tree I had to do
> the following:
> 
> -arv --delete
> 
> The -u update kept thinking my samba version was newer than the linuxcare
> version and wouldn't get the new version and there were lots of files that
> needed to be deleted.

If you have done a compilation in the tree, it may have touched some of
the header files.  The way the kernel Makefiles take care of header
dependencies is that if a.h includes b.h, and b.h is newer than a.h, it
will touch a.h.

I usually keep separate trees and only compile in one of them.  I use
dirdiff to keep track of the differences between the trees.  Dirdiff is a
tool I wrote for seeing the differences between directory trees.  It can
handle up to 5 directory trees.  It's a tcl/tk script and it's available
at ftp://ftp.linuxcare.com.au/pub/ppclinux/dirdiff.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
