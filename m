Message-ID: <3C98CECA.E7187E8C@gmx.net>
Date: Wed, 20 Mar 2002 19:02:50 +0100
From: Oliver Amft <oam@oamx.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: initial shell respawning too fast
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to boot Linux (linuxppc_2_4_devel 2.4.19-pre1) from a
Walnut,
405GP Rev D board - All works fine till INIT starts (see screen
printout below). The root fs (nfs boot) is an older version of the
HardHat filesystem. bash crashes somehow, but unforunatly it prints no
report. An old HHL 2.4.0-test2 kernel still works with this root fs.

INIT: version 2.77 booting
INIT: Entering runlevel: 3
INIT: Id "sh" respawning too fast: disabled for 5 minutes
INIT: no more processes left in this runlevel
INIT: Id "sh" respawning too fast: disabled for 5 minutes
INIT: Id "sh" respawning too fast: disabled for 5 minutes
INIT: Id "sh" respawning too fast: disabled for 5 minutes
INIT: Id "sh" respawning too fast: disabled for 5 minutes


Probably I am missing some trivial thing - any ideas welcome!

Oliver

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
