Message-ID: <3CE99643.B7188518@ixiacom.com>
Date: Mon, 20 May 2002 17:35:15 -0700
From: Dan Kegel <dkegel@ixiacom.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Cc: dank@kegel.com
Subject: bitkeeper, the 2_4_devel tree, and branches
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


My naive assumption, looking at the changesets listed at
http://ppc.bkbits.net:8080/linuxppc_2_4_devel/
was that if I cloned the repository as of two adjacent
changesets, and exported from those repositories,
the result would differ by exactly the second changeset.

That's probably true at some level, but when I tried
it with the two tags 1.899 and v2.4.18 (aka 1.2.2.131),
which are adjacent in the changeset list on that web page,
I got two entirely different trees.  It seems many branches
exist in the linuxppc_2_4_devel tree, and that bk names
branches using the godawful SCCS/CVS branch naming scheme.
(Hrmf- after getting used to Perforce's branch naming, it's
hard to go back to the
branch-name-is-suffix-on-version-number-of-each-file
way of life.)

Bitkeeper's doc is a bit thin on branches; for instance,
http://www.bitkeeper.com/manpages/bk-terms-1.html doesn't
have a definition for 'branch'.

So it seems that, unless one knows what one is doing,
one should avoid any revisions with more than one dot
in their name, and one should shun the tags 'v2.4.xx',
which are probably just mirrors of the Linus kernels.

Can someone confirm this, say a couple words on the use
of branches in the 2_4_devel tree, and explain how the
v2.4.xx tags are useful to linux ppc kernel hackers?
Thanks!
- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
