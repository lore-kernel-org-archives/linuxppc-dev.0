Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9EF942BDB5
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Nov 2004 08:37:26 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@austin.ibm.com>
In-Reply-To: <20041121173711.GA5692@austin.ibm.com>
References: <1100847411.25521.42.camel@gaston>
	<1100852423.3855.2.camel@gaston> <1100995268.3796.39.camel@gaston>
	<20041121173711.GA5692@austin.ibm.com>
Content-Type: text/plain
Date: Mon, 22 Nov 2004 08:36:34 +1100
Message-Id: <1101072994.3796.70.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: TEST: Sleep suppport for iBook G4 & Aluminium PowerBooks (ATI
	based)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2004-11-21 at 11:37 -0600, Olof Johansson wrote:
> On Sun, Nov 21, 2004 at 11:01:08AM +1100, Benjamin Herrenschmidt wrote:
> > > Ok, I already found a bug, occasional lockups on boot and when setting
> > > the backlight. I uploaded a new version at:
> > 
> > Here's a 3rd version. It may or may not help, as I didn't have a chance
> > to test this one on either albook or ibook g4 yet. I added saving and
> > restoring of a few more registers that may fix the Xv problem (or not...
> > depends what X does at this point) and eventually some corruption
> > problem (the bandwidth related registers weren't restored).
> 
> This one caused problems for me. Looks like the backlight got turned off
> at boot, I had to sleep it and wake it up to get it back.

There have been no change regarding backlight at boot, could just be
some latent problem... Next time it happens, test what happens if turn
the backlight all the way down to 0 (with the backlight keys), wait a
bit, then back up.

Ben.
