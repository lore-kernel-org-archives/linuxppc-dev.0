Date: Wed, 10 Mar 1999 15:20:46 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: What a day for linuxppc!
In-Reply-To: <36E62FDC.88FAB16B@wanadoo.fr>
Message-ID: <Pine.LNX.4.05.9903101517560.21662-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 10 Mar 1999, Martin Costabel wrote:

> 1) The 2.2.3 kernel from Linus. Unfortunately it doesn't compile on PPC,
> because Paul's semaphore patches didn't make it. The semaphore patches
> for Alpha are there, though, and they are not older, so why is this so?

Paul didn't send them on.  Linus doesn't go and pick up patches..

> 2) The new R5 beta1. 

Ah shit.  What timing...  Just as we start a build w/ rpm 2.9x, feh.

> Unfortunately, instead of a working installer, the
> old crap from 3 months ago is included. I know there have been more
> recent installers on mirror.linuxppc.org. Why aren't they there? The

Well, the current installer works for FTP/HTTP installs, but I forget
weather disk/cdrom works ATM.

> PLEASE PUT A WORKING INSTALLER ON THE NET! I am shouting because I am
> tired of seeing (and answering) all the old questions yet again.

Soon enough, hopefully...

> Another problem is that the RPMS don't show up on the mirrors. On
> sunsite.doc.ic.ac.uk (which is my favorite mirror, because it is
> nfs-mountable), for example, only the symbolic links were copied; the
> rpms themselves are still the old ones and it doesn't look as if they
> will be arriving.

linuxppc.slackers.cx has a current mirror of the build box.  Might not be
NFS able, but it's current. :)

> 3) egcs-1.1.2-prerelease3, soon to become egcs-1.1.2-release. At least
> this one is good news: It bootstraps out of the box. This hasn't been
> possible for a long time. Well, it still fails most of the tests in the
> testsuite, so some polishing by Gary Thomas might be necessary, but it
> is good to see that.

1.1.2 pre 3 seems to be working rather well.  Don't forget to thank Franz
Sirl. :)

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
