To: linuxppc-dev@lists.linuxppc.org
Subject: KDB patch
From: Daniel Berlin <dberlin@redhat.com>
Date: 14 Mar 2001 10:42:58 -0500
Message-ID: <m2pufk8igt.fsf@dynamic-addr-83-177.resnet.rochester.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is now at http://www.cgsoftware.com/~dan/xfs-tree-ppc-kdb.patch.bz2

It's against the SGI Linux XFS tree, and includes stuff to bring the
XFS tree's PPC support to what the bitkeeper 2_4 tree has, among other
things.

This means it's also not too difficult to merge my kdb stuff if you
just have a 2_4 linuxppc tree, and apply the latest kdb patch from
oss.sgi.com.

However, i haven't had time to generate a patch like this, or one that
just applies to the 2_4 tree (IE includes my kdb patches, and the
kdb patch from SGI)


--Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
