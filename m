Date: Sat, 1 Mar 2003 15:29:16 -0500
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: ibook2 will not wake from sleep on 2.4.20-ben7
Message-ID: <20030301202916.GA6120@paco.resnet.purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have an iBook 2 (PowerBook 4,1) and I rsync'd my kernel to
2.4.20-ben7 last night (I had previously been running 2.4.20-pre7-ben0
with no trouble).  The lid latch does not seem to put the machine to
sleep any more, and when I put it to sleep with the power button,
waking the machine up shuts it off rather than waking it.  I then have
to depress the power button for a few seconds, release it, and press
it briefly in order to power the machine back up.

The machine is not losing its time/etc, merely shutting down.

I'm running pbbuttonsd-0.5.2 in pmud replacement mode.

Ethan

--
Happiness is a belt-fed weapon.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
