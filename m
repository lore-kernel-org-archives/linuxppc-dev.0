Date: Mon, 26 Mar 2001 08:24:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Benjamin Herrenschmidt <benjamin.herrenschmidt@wanadoo.fr>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: dmasound hangs on new G4s (2)
Message-ID: <20010326082448.J16672@opus.bloom.county>
References: <20010326120026.59A232EFC1@apollo.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010326120026.59A232EFC1@apollo.valhalla.net>; from iain@sandoe.co.uk on Mon, Mar 26, 2001 at 01:00:22PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Mar 26, 2001 at 01:00:22PM +0100, Iain Sandoe wrote:
>
> >>Okay, dmasound compiled in hangs the new G4s, but this change had no effect
> >>on it otherwise (I also have a few Bogus interrupts, w/ or w/o this).
> >
> > One of those new G4s that have the new "digital sound" chip ?
> >If I remember correctly, they have no AWACS, but an ibook-like chip on the
> > I2S bus. I beleive it's normal dmasound doesn't work properly with it.
>
> "Tumbler" audio (whatever that is ;-))) [WWDC, Ben?]
>
> OK - could you send me the device-tree stuff? - and I'll compare it with
> what we've got.

It's whatever is in the new G4s.  And I do believe there was an i2s bus in
OF when I was poking around before.

> http://tibit.org/ppc/ has a nice (if somewhat slow) script that turns the
> dev-tree into html.

I'll shoot this off to you privately in a bit.

> With the BK _2_4 tree (and no other patches) i2s-a is checked and connected
> for output - *but* there may be a 'mixer-related' issue (because that's
> different too).  I've fixed that up for the iBook (so that it doesn't try
> and do any AWACS-related stuff).... but that won't work for the new G4
> necessarily.

Okay.  I'll see what happens when I enable modules in a bit as well...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
