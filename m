Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2CEA9B70D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 11:16:50 +1100 (EST)
In-Reply-To: <20101208162559.26e40cf2@udp111988uds.am.freescale.net>
References: <20101207145153.540da45a@udp111988uds.am.freescale.net>	<OFF94B1B01.88594E81-ONC12577F3.002B63AA-C12577F3.002BEE0B@transmode.se>
	<20101208111839.1cf95553@udp111988uds.am.freescale.net>	<OF349DC945.8BC48D34-ONC12577F3.00601D94-C12577F3.00605153@transmode.se>
	<20101208192616.GA24560@postdiluvian.org>	<OF14047E09.664EC753-ONC12577F3.006CF507-C12577F3.006D97EA@transmode.se>
	<20101208135928.0278f97d@udp111988uds.am.freescale.net>	<OFC37E86C9.59866BED-ONC12577F3.006E8F8D-C12577F3.006EE1FA@transmode.se>
	<20101208142551.19ea2333@udp111988uds.am.freescale.net>	<OF6F049A4C.3AEB4068-ONC12577F3.00751175-C12577F3.0075D3F5@transmode.se>
	<20101208220245.GB26836@postdiluvian.org>
	<20101208162559.26e40cf2@udp111988uds.am.freescale.net>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OFB1C92294.474C1855-ONC12577F4.0000B901-C12577F4.00018859@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 9 Dec 2010 01:16:44 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Mark Mason <mason@postdiluvian.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 2010/12/08 23:25:59:
>
> On Wed, 8 Dec 2010 17:02:45 -0500
> Mark Mason <mason@postdiluvian.org> wrote:
>
> > I don't think that using a software NAND controller instead of the LBC
> > FCM mode is all that bad.  Again, I haven't actually done it, so check
> > the MTD docs, but I'm pretty sure the software is meant to do that, so
> > it doesn't even really constitute a "fix".  Assuming that it is
> > supported then I doubt that configuring the NAND layer to use your
> > setup would be any harder than configuring the FCM.
>
> The MTD layer supports some really simple NAND controllers, but what do
> you mean by not having a controller at all?  Hooking everything up to
> GPIO?  Using UPM?
>
> There is already a UPM NAND driver, BTW.
>
> You would lose hardware ECC and the ability to be interrupt-driven (the
> latter should be possible with SW changes, using GPIO interrupts).

Good, using SW ECC isn't really a choice, I rather switch to another CPU that
can do NAND in HW(are any other Freescale CPU:s that can do this ?).
We haven't started our design yet so we still have this option. I would need to
know if the GPIO solution works well enough with the NAND controller though.
I will ask our Freescale contact about that.

Thanks for sharing this info,
                                Jocke
