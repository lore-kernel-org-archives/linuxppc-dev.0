MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16334.33020.624995.521330@cargo.ozlabs.ibm.com>
Date: Thu, 4 Dec 2003 11:34:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: the door is closing for 2.4
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Guys,

Marcelo has announced that as of 2.4.25, the official 2.4 tree is
going into maintenance-only mode.  There is still a lot of stuff in
the linuxppc-2.4 and linuxppc_2_4_devel trees which hasn't gone into
the official 2.4 tree.  Most of that is board ports for various
embedded boards, and for many of those boards, it's not clear whether
anyone cares whether they are supported by the official 2.4 or not.

So if you have a board that you want to see supported by the official
2.4 tree, and it isn't already, let me know.  I will need someone to
commit to maintaining the port on an ongoing basis before I send it to
Marcelo, though.

We also need people to start moving their embedded board ports to
2.6, along with all the related device drivers, etc.  We are already
past the point where new development should all be done in 2.5/2.6.

Paul.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
