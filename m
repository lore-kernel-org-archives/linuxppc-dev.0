Message-ID: <7283DE19D141D111AD0E00A0C95B195502581F13@mail2.aiinet.com>
From: "Gessner, Matt" <mattg@aiinet.com>
To: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Check: USB on 821/823/850 and EmbeddedPlanet boards
Date: Tue, 27 Mar 2001 14:00:30 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, folks,

We're looking into USB host side usage of one or more of the above
processors.  I've been looking at the mailling list archives for the last
few months (that I've collected) and it seems that there are some
features that work and some that don't, and it seems to depend a bit
on the transceiver you're using.

My basic question is: does this work reliably with any kind of USB
device (at least at the hardware level)?  Is there someone (Roman,
Brad) who maintains a list of things that work/don't work?

Is this transceiver tied to the MPC or is it the client-side device
transceiver that you're having trouble with?  Does anyone care
to make any suggestions?

We're not looking to talk to the whole world with this... we're going
to front end a few SIMPLE I/O devices with USB to allow more
flexibility, so we'll certainly know a lot about the devices hanging
on the bus -- i.e. they'll be ours, not just generic devices one can
buy in the store.

Would someone (Roman, Brad, anyone else doing lots with this)
kindly share a bit of what's been learned, what works, what to
stay away from, etc.?

Thanks in advance,

Matt


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
