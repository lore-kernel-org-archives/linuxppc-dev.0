From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15468.64269.8252.644104@argo.ozlabs.ibm.com>
Date: Fri, 15 Feb 2002 23:11:57 +1100 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.5 development
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Now that Linus has started using BK for 2.5 development, I have set up
a new linuxppc-2.5 tree on ppc.bkbits.net.  Its parent is Linus' tree,
which means that we can pull in Linus' changes using BK, instead of
having to apply patches.  The linux_2_5 and linuxppc_2_5 trees are
dead, and I will remove them once we are sure we have all the changes
from linuxppc_2_5 committed to the linuxppc-2.5 tree.

The linuxppc-2.5 tree is intended to be a working tree for us in the
same way that the linuxppc_2_4_devel tree was.  I have checked in
most of the changes from linuxppc_2_4_devel into linuxppc-2.5.

The current limitations of BK mean that we will not be able to take
changesets directly from the linuxppc-2.5 tree and send them to
Linus.  I would suggest that if any of you are working on stuff which
can be isolated as a discrete unit, you can set up a clone of
linux-2.5 where you check in all of the changes for that stuff.  Then
pull from there into your linuxppc-2.5 clone to compile and test, and
push to the linuxppc-2.5 tree on ppc.bkbits.net when you are ready for
the rest of us to look at it.  When it is time for those changes to go
to Linus, we can get Linus to pull from your repository which has just
those changes (or I can pull and get Linus to pull from my tree).

I have also created for-linus-ppc and for-linus-ppcdrivers trees which
I will use to send stuff to Linus, so I don't want anyone except
myself pushing to those trees.  There is also a for-linus-ppc64 tree
which Anton Blanchard will be using to send ppc64 stuff to Linus, so
please don't push to that one either.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
