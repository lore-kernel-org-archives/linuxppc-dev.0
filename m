Subject: Re: Fix for autonegotiation of ppc 40x ethernet driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ronald Wahl <rwa@peppercon.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <m365j0863r.fsf@gandalf.peppercon.de>
References: <m3brss87p4.fsf@gandalf.peppercon.de>
	 <1065602490.30751.84.camel@gaston>  <m365j0863r.fsf@gandalf.peppercon.de>
Content-Type: text/plain
Message-Id: <1065603389.30756.88.camel@gaston>
Mime-Version: 1.0
Date: Wed, 08 Oct 2003 10:56:29 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I wont force a single mode. I want to limit the advertising to a
> limited _range_. So autonegotiation is still enabled - just with a
> limited range. The forcing of a mode (i.e. disabling autonegotiation)
> is working already without this patch.

Ah ok. Well... we indeed need to and the two masks then, though it
should be possible to find a phy-specific way to get the exact
speed that was actually selected...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
