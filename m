Message-Id: <200007282223.XAA13499@hyperion.valhalla.net>
Date: Fri, 28 Jul 2000 23:19:43 +0100
Subject: IRQ Blocking Test 0.1.3
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well I've applied this across the machines I've got that boot linux (still
haven't commissioned the G4).

Using Ben's 2.2.17pre13ben2. + IRQ_blocking patch + dmasound patch (separate
message)

The good news - is that it's stable & OK on
G3 beige minitower,
G3 Lombard
604e 9600/233

The bad news is that there are high interrupt latencies across the board:

As Ben suggested would be the case, the Lombard is worst (it's the only one
based on ide) but
all three produce >250 us blocks quite easily (ll_rw_blk.c)

and the
9600 (which *was* until two weeks ago my studio machine - quite capable of
recording 12 channels of 44k audio direct to disk under MacOS) produces
400-700 us in scsi without really trying to load it.

Ah well.
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
