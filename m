From: "Elan Feingold" <elan@nxnetworks.com>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: VisionXD crashes
Date: Thu, 9 Aug 2001 18:34:35 -0500
Message-ID: <NDBBLJKOJGKDOFBHNPGEGEGNCEAA.elan@nxnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

This may be a very stupid question, but I'm a newbie.  We have Linux 2.4.4
booting, thanks to the VisionXD app and a BDM pod, using Limon as a
bootloader.  We have telnetted in and played around a bit.

The problem is that when we run strace on the inetd process and telnet in,
for example (or run 'crashme' for just a second), the kernel hangs solidly
(in the case of strace, it locks up right after printing out 'fork(...)').
If we leave VisionXD up, it pops up a 'critical error' dialog; if we don't
the kernel just hangs.  We think it might have something to do with the
interaction between the BDM pod and the processor, but we really have no
clue.

We are using the EST 8260 eval board, which Limon supports, so I assume all
our memory settings are correct.  The fact that we can telnet in and run
various programs (including our TCP/IP intensive application for quite a few
hours) leads me to believe that it's *almost* working correctly...

Any ideas?  Help!!!

Many thanks,

-elan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
