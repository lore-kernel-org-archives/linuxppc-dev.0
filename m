Date: Sun, 7 Nov 1999 10:14:48 -0600 (CST)
From: Mark Hatle <devel@gate.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.3.x and Blue G3
Message-ID: <Pine.LNX.4.10.9911071013160.7166-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is anyone working on getting 2.3.x working on Blue G3 (or newer)?

The current version fails in head.S after the MMU_init.  I don't know
enough about the MMU and such to see if things are going wrong or what.
The rfi after the MMU_init seems to jump to never never land and the
computer needs a reboot.

Thanks
Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
