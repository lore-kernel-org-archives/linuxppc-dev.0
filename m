Message-ID: <20030415034001.20841.qmail@kunk.qbjnet.com>
Subject: XFS patches and 2.4.20-ben10
To: linuxppc-dev@lists.linuxppc.org
Date: Mon, 14 Apr 2003 22:40:01 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been using xfs for several months and I wanted to apply the
current devel xfs patches to the 2.4.20-ben10 kernel and ran into
a name clash in include/linux/sysctl.h.

In the enumeration of the CTL_VM names, the patch is trying to insert
VM_PAGEBUF=14
when there already exists a
VM_HEAP_STACK_GAP=14

VM_HEAP_STACK_GAP=14 doesn't exist in the stock 2.4.20 kernel.

Is there a preferred way to work around this until the problem is
solved? I assume that changing VM_PAGEBUF=14 to 15 would mean a
recompile of all the xfs utils as well.

Since there seem to be several patches to the 2.4 kernel
series with different values for VM_HEAP_STACK_GAP would it be
safe to assume I can change that? (sorry for the my lack of
understanding of what is going on here).

Bob
--
/~\ The ASCII
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
