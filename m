Return-Path: <schmitz@zirkon.biophys.uni-duesseldorf.de>
Received: from zirkon.biophys.uni-duesseldorf.de
	(zirkon.biophys.uni-duesseldorf.de [134.99.176.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 54F342BDF2
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 19:05:42 +1100 (EST)
Date: Tue, 23 Nov 2004 09:05:35 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1101160237.13598.121.camel@gaston>
Message-ID: <Pine.LNX.4.44.0411230900020.6419-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: TEST: Sleep patch #4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > > http://gate.crashing.org/~benh/albook-ibookg4-sleep-4.diff
> >
> > Sorry for coming late to the party ... the current code works nicely on
> > the 17" PB. On the first boot with that code, I had the PLL freak out (or
> > so it looked like) but I couldn't reproduce that. Needless to say, the
> > new PLL fixup code produces the same dividers as the hardcoded fixup
> > before, so it should work :-)
>
> It reads them from OF at boot. What do you mean by "freak out" ? the
> usual problem with those models where the display gets all fuzzy ? I'm

Yep - the display get totally unreadable, worse than before when the PLL
wouldn't lock properly. When I turned down the backlight (using the
f-keys), it would switch off and not come back up until X had fully
started. Though that might be a bug in pbbuttonsd as well, to be honest (I
turned the backlight off before pbbuttonsd started, perhaps).

> not completely sure what's up, I tend to blame the panel power sequence
> nowadays ...

Anything I can do to test that?

	Michael
