Return-Path: <schmitz@zirkon.biophys.uni-duesseldorf.de>
Received: from zirkon.biophys.uni-duesseldorf.de
	(zirkon.biophys.uni-duesseldorf.de [134.99.176.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45A252BDF2
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 04:10:46 +1100 (EST)
Date: Mon, 22 Nov 2004 18:04:52 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1101083578.13597.5.camel@gaston>
Message-ID: <Pine.LNX.4.44.0411221758220.2076-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, gentoo-ppc-user@gentoo.org,
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

> Ok, here's the 4th iteration of the patch. It includes John Steele Scott fixes for
> cpufreq and the sound driver and fixes a problem where memory refresh wouldn't properly
> be re-enabled on the video chip upon wakeup. I also cleaned a bit more the MDLL reset
> code for r300, plus a couple of other things.
>
> http://gate.crashing.org/~benh/albook-ibookg4-sleep-4.diff

Sorry for coming late to the party ... the current code works nicely on
the 17" PB. On the first boot with that code, I had the PLL freak out (or
so it looked like) but I couldn't reproduce that. Needless to say, the
new PLL fixup code produces the same dividers as the hardcoded fixup
before, so it should work :-)

	Michael
