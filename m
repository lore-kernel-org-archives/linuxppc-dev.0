Return-Path: <schmitz@zirkon.biophys.uni-duesseldorf.de>
Received: from zirkon.biophys.uni-duesseldorf.de
	(zirkon.biophys.uni-duesseldorf.de [134.99.176.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3110667B17
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 17:22:28 +1000 (EST)
Date: Fri, 21 Apr 2006 09:22:16 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.16 backtrace at boot (Ibook G4) (related to "PowerBook5,4
	-- no sound?")
In-Reply-To: <1145566085.17087.70.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0604210918530.2603-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "\[ATR\]Dj-Death" <djdeath@gmx.fr>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > Commenting out the -ENODEV return gives me working sound; didn't I mention
> > that?
>
> There is a proper patch in paulus tree.. it's basically the patch I
> posted with an extern declaration at the beginning of the macro before
> the EXPORT_SYMBOL.

Yep, I got that right; just wanted to report that this is the only problem
with sound I have in 2.6.17 (well, sound dies after changing the volume
with gtkpbbuttons while playing something in VLC, but that's not
necessarily 2.6.17 specific. Need to try 2.6.16 with that).

> Patch isn't in yet it seems.

No sweat - seems I'll need a bigger disk anyway before pulling another
update :-)

	Michael
