Message-Id: <200007301812.TAA20476@hyperion.valhalla.net>
Date: Sun, 30 Jul 2000 19:10:43 +0100
Subject: 2.2.17pre13ben2 on Lombard
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
CC: Benjamin Herrenschmidt <bh40@calva.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I ran this version for some time on my Lombard.
at first no drama... but after a while the HD started to go beserk (good
technical statement eh?).

If you remember the old machine control labs where you used to play tunes on
servo actuators?

Well it was a bit like that only with less tuneful bursts.

Possibly this is related to the earlier discussion about problems on
sleep/wakeup.

Fortunately the disk survived (nothing worse than an fsck required and the
MacOS partitions were not touched).

However, I'm a little reluctant to make a habit of trying this (I feel that
this time I was lucky).

Is it possible to disable sleep on the PowerBooks and still have a run-able
kernel?  Although I can't be 100% sure it was sleep related - at least this
would eliminate that as a cause - it's really too nasty to want to try it
often as an experiment.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
