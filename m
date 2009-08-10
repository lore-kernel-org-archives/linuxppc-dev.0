Return-Path: <dedekind@infradead.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6A984B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 02:28:05 +1000 (EST)
Subject: Re: [PATCH] mtd/maps: add mtd-ram support to physmap_of
From: Artem Bityutskiy <dedekind@infradead.org>
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <20090810161942.GA27833@pengutronix.de>
References: <1247834363-28198-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40908072243x56d2160fk688149f4b7b912ae@mail.gmail.com>
	<1249795043.9157.37.camel@localhost>
	<20090810161942.GA27833@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 10 Aug 2009 19:25:56 +0300
Message-Id: <1249921556.19638.16.camel@localhost>
Mime-Version: 1.0
Cc: devicetree-discuss@ozlabs.org, Vitaly Wool <vwool@ru.mvista.com>,
	Albrecht =?ISO-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Ken MacLeod <ken@bitsko.slc.ut.us>, David Woodhouse <dwmw2@infradead.org>
Reply-To: dedekind@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-08-10 at 18:19 +0200, Wolfram Sang wrote:
> On Sun, Aug 09, 2009 at 08:17:23AM +0300, Artem Bityutskiy wrote:
> > On Fri, 2009-08-07 at 23:43 -0600, Grant Likely wrote:
> > > On Fri, Jul 17, 2009 at 6:39 AM, Wolfram Sang<w.sang@pengutronix.de> wrote:
> > > > Use physmap_of to access RAMs as mtd and add documenation for it. This approach
> > > > is a lot less intrusive as adding an of-wrapper around plat-ram.c. As most
> > > > extensions of plat-ram.c (e.g. custom map-functions) can't be mapped to the
> > > > device tree anyhow, extending physmap_of seems to be the cleanest approach.
> > > >
> > > > Tested with a phyCORE-MPC5121e.
> > > >
> > > > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > > 
> > > Looks good to me.
> > > 
> > > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> > 
> > This patch is sitting in my l2-mtd-2.6.git tree.
> 
> Great, thanks a lot (and for your l2-tree in general!). One question: Are the
> additional Acked-bys added later? I could think they might be useful for
> David's review...

Well, I do not bother maintaining nice history there, so rebase it
freely, which means I can add your ack. Will do tomorrow.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
