Date: Mon, 26 Mar 2001 13:00:22 +0100
Subject: dmasound hangs on new G4s (2)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <benjamin.herrenschmidt@wanadoo.fr>,
	Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010326120026.59A232EFC1@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>Okay, dmasound compiled in hangs the new G4s, but this change had no effect
>>on it otherwise (I also have a few Bogus interrupts, w/ or w/o this).
>
> One of those new G4s that have the new "digital sound" chip ?
>If I remember correctly, they have no AWACS, but an ibook-like chip on the
> I2S bus. I beleive it's normal dmasound doesn't work properly with it.

"Tumbler" audio (whatever that is ;-))) [WWDC, Ben?]

OK - could you send me the device-tree stuff? - and I'll compare it with
what we've got.

http://tibit.org/ppc/ has a nice (if somewhat slow) script that turns the
dev-tree into html.

With the BK _2_4 tree (and no other patches) i2s-a is checked and connected
for output - *but* there may be a 'mixer-related' issue (because that's
different too).  I've fixed that up for the iBook (so that it doesn't try
and do any AWACS-related stuff).... but that won't work for the new G4
necessarily.

Iain

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
