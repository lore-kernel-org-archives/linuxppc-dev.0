From: Roland Riegel <roland.riegel.maillist@gmx.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: iBook G4 LCD backlight misbehaviours
Date: Sat, 3 Jan 2004 00:15:55 +0100
MIME-Version: 1.0
Message-Id: <200401030014.07254.roland.riegel.maillist@gmx.de>
Content-Type: text/plain;
  charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everybody!

Recently I bought an iBook G4 and installed Linux on it. I am using
linux-2.4.23-ben1 and have the following problem:

When configured with CONFIG_PMAC_BACKLIGHT=y, on startup the screen switches
completely off (it took me some time to notice that the kernel does not crash
but only the screen turns dark and the system keeps booting).

To get in control of the keys at the top of the keyboard (for adjusting sound,
the lcd backlight and ejecting the cd drive), I installed pbbuttonsd so I now
can influence the lcd backlight and tune it up again.

But the minimum and maximum brightness does not seem correct. The screen
switches off to early when darkening or lightening the screen. The direction
(up and down) seems to be inversed. When pressing the up key, brightness goes
down. I am sure the correct keys are configured in /etc/pbbuttonsd.conf.

Is it possible that someone looks into this? I am not a kernel hacker, but I
can help with testing and answering any questions you should have.

Thank you!

Roland


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
