Date: Mon, 25 Jun 2001 15:15:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-commit@ppcbk.mvista.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: rsync access up for BK trees
Message-ID: <20010625151539.T26686@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Okay, rsync access for the 2_4, 2_4_devel and 2_2 BK trees are up
and should be working.  These shouldn't be more than 10-15 minutes
behind the BK mirrors (exporting a tree takes time).  Things _should_
be OK if you're rsycing when the tree gets updated, but if not let me
know and I'll work on something.

$ rsync source.mvista.com::
linuxppc_2_4    LinuxPPC 2.4 BitKeeper tree, stable branch
linuxppc_2_4_devel      LinuxPPC 2.4 BitKeeper tree, development branch
linuxppc_2_2    LinuxPPC 2.2 BitKeeper tree

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
