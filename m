Date: Wed, 3 Sep 2003 14:39:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: KGDB behavior in 2.4.23-pre2 / 2.6.0-test4+
Message-ID: <20030903213938.GA19846@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all.  In 2.4.23-pre2 and 2.6.0-test4 the default behavior of KGDB
in the PPC kernel changed.  Previously, if KGDB was selected, it would
default to a breakpoint early on, and passing 'nokgdb' would stop it.
It has been changed to match what the docs on
http://kgdb.sourceforge.net/ say (as well as a few other arches), and
KGDB will only have a default breakpoint if 'gdb' is passed on as a
parameter.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
