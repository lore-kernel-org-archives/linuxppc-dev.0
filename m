Date: Wed, 6 Oct 1999 16:47:22 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: ADB probing
Message-ID: <Pine.LNX.4.10.9910061626290.10804-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all.

I've run into a wierd problem with ADB stuff, and I wonder if anyone has
an idea on how to work/fix this.  What I'm trying to do right now is fix
up kudzu so it can probe for things on the ADB bus.  Right now it does
what all the other old config tools did, and pokes at /dev/adbmouse.  The
problem is right now this works if there's any adb device present (one of
the machines I checked only has an adb kbd, tho adbmouse suport is
compiled in).  Also, is there any way to see if the machine has an adb
keyboard installed?  Thanks..

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
