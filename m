Message-Id: <200003140918.JAA19674@hyperion.valhalla.net>
Date: Tue, 14 Mar 2000 09:18:17 +0000
Subject: Different Mac Models.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello All,
I new to the list so apologies if this is a bit dumb.

Is there a cross-reference matrix anywhere between Mac Machine IDs (the one
you can get out of system profiler) and the required kernel build config
flags?  Preferably ;) by kernel version.

I have G3 minitower (Apple UW scsi), G3 PB (although if it's a "1999" or
"lombard" beats me) & a 9600/233 604.

I succeeded (by trial & error) to find the right combinations to build
2.2.14p9 on both G3 & PB (but never got the USB mouse working on the PB, and
the trackpad is frustratingly fast to say the least)... and then had to
spend some time of paid work - restarted last week...

I am about to (if it hasn't been claimed already) think about doing an ALSA
driver for pmac internal sound.

I have (just about) succeeded in getting the latest (yesterday) rsyncs
(2.3.51) from linuxcare to build and boot on the G3 minitower - although I
had to leave a lot of PB stuff in to get it to build.

However, (I appreciate this is not going to be helpful so I don't expect an
answer) once X (Xpmac rev 6) is up the machine stops dead after a few
minutes... three finger salute required to get anywhere :(

Would I be better off sticking with the 2.2.XX tree for ALSA driver
development - or should I be in amongst the 2.3.xx tree?
I think this is a PPC rather than ALSA question (?).

regards,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
