Message-ID: <36E62FDC.88FAB16B@wanadoo.fr>
Date: Wed, 10 Mar 1999 09:39:56 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: What a day for linuxppc!
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Yesterday should have been a great day in the life of linuxppc. Several
long-awaited things finally came out:

1) The 2.2.3 kernel from Linus. Unfortunately it doesn't compile on PPC,
because Paul's semaphore patches didn't make it. The semaphore patches
for Alpha are there, though, and they are not older, so why is this so?

2) The new R5 beta1. Unfortunately, instead of a working installer, the
old crap from 3 months ago is included. I know there have been more
recent installers on mirror.linuxppc.org. Why aren't they there? The
tired little README file makes things even worse. It is lying when it
says that the included ramdisk.image.gz will suffice for booting. This
one still demands a second floppy. And ftp doesn't work and so on. 

PLEASE PUT A WORKING INSTALLER ON THE NET! I am shouting because I am
tired of seeing (and answering) all the old questions yet again.

Another problem is that the RPMS don't show up on the mirrors. On
sunsite.doc.ic.ac.uk (which is my favorite mirror, because it is
nfs-mountable), for example, only the symbolic links were copied; the
rpms themselves are still the old ones and it doesn't look as if they
will be arriving.

3) egcs-1.1.2-prerelease3, soon to become egcs-1.1.2-release. At least
this one is good news: It bootstraps out of the box. This hasn't been
possible for a long time. Well, it still fails most of the tests in the
testsuite, so some polishing by Gary Thomas might be necessary, but it
is good to see that.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
