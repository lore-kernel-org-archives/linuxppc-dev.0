Message-ID: <20000307081925.14102.qmail@www0p.netaddress.usa.net>
Date: 7 Mar 00 02:19:25 CST
From: jeramy b smith <ultrapenguin@netscape.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Kernel Bug Report-Jeram
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I wrote to linuxppc user to get some feedback on a kernel error I was running
into. Specifically, when booting 2.2.15pre3 directly (yaboot); my Lombard 333
hangs when it enables multiword dma for hda. It gives the message that it
enables multiword dma , gives the specs of the drive twice, and duly hangs.

1. If I boot from a a linuxppc cdrom this does not occur.

2. If I warm reboot after booting from a Linux cdrom and mounting the drives
or booting from a macos cdrom, then the direct boot succeeds.

3. If I boot from a bootx extension, this does not occur.

4. If I direct boot the newer kernel in cs 1.2 (pre8?), multiword dma is
successfully initialized for hda but then I get two messages that multiword is
enabled for hdc followed by a nice hang.

-Jeramy


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
