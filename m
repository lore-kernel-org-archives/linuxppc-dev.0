Date: Wed, 29 Sep 1999 16:43:07 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: BootX app w/o dialog
Message-ID: <Pine.LNX.3.96L.990929163345.7639E-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm talking with someone in charge of an iMac cluster who needs to use Linux
by night and the Mac OS by day and have everything automated. When the
machines reboot (from a cron job) in the morning they need to come up into the
Mac OS. Since the drives are HFS+ formatted switching BootX preference files
in the cron job won't work.

The deal is I'm going to be looking into a BootX application (not extension)
with the dialog hacked out of it so it automatically starts Linux with the
default settings when launched. I looked a little at the BootX code and I
don't think it would be that hard. I think I have an old CodeWarrior (10) I'm
willing to install and play with, but I'm pretty busy so I wanted to see if
anyone (other than BenH, who's busy kernel hacking :) could take a look and
hopefully produce a binary.

Let me know if you're game.

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
