Date: Sat, 2 Dec 2000 00:22:27 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: No Backlight Control in 2.2.18pre21
In-Reply-To: <200012010559.XAA05749@lists.linuxppc.org>
Message-ID: <Pine.SOL.3.95.1001202001239.8001A-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Subject says it: with current linux-pmac-stable kernels, the backlight
control via [Fn-]F{1,2} does not work, neither dimming nor turning off
the LCD altogether, on a PB Lombard at least.
Might have been this way since the CONFIG_PMAC section appeared, in any
case, in 2.4.0-test11 there is a CONFIG_PMAC_BACKLIGHT option, and backlight
control is working (I've set it to "=y", of course).
It also seems that my PB suffers very frequently from increased battery
discharge during sleep, but I can't note any difference here between
-stable, -benh and -devel.

Cheers,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
