Message-ID: <19990923150552.23602.rocketmail@web601.yahoomail.com>
Date: Thu, 23 Sep 1999 17:05:52 +0200 (CEST)
From: sébastien tadéoni <sebastien_tadeoni@yahoo.fr>
Subject: Questions on the MPC8xx-2.3.10 realease.
To: Simon Brendan <brendan@dgs.monash.edu.au>,
        linux ppc embedded <linuxppc-embedded@lists.linuxppc.org>,
        Graham Stoney <greyham@research.canon.com.au>,
        Scott Wood <scott@broadlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hi PPCpeople;

I worked recently on the mpc8xx-2.3.10 sources, and I
had less problem for compilation than with the 2.2.5
release, but it stays some 'undefined reference to
:kbd_pt_regs, fg_console, no_scroll.....'.

I think it is a configuration problem, but I don't
find any solution (and I wonder if I will find the
good configuration one day). I noticed like Brendan
that some parameter are configured even if you didn't
want.
I edited the autoconf.h but no really changes.

According to Dan, it seems to be tooo difficult to
cross compile on a host pentium machine (I begin to be
mainly agree with him),so I'm going to obtain a
powermac station.

However I would like to know before if someone has
already succeeded to build a zImage or zImage.initrd
configured for a MPC860 MBX board on a host pentium
(II 400) station?

Good Day.
Sébastien Tadéoni


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
