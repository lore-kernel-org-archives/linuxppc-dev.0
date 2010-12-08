Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 090B6B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 06:59:46 +1100 (EST)
Received: from mail9-tx2 (localhost.localdomain [127.0.0.1])	by
	mail9-tx2-R.bigfish.com (Postfix) with ESMTP id D89EE18184AA	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  8 Dec 2010 19:59:36 +0000 (UTC)
Received: from TX2EHSMHS032.bigfish.com (unknown [10.9.14.243])	by
	mail9-tx2.bigfish.com (Postfix) with ESMTP id 5F551DA0052	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  8 Dec 2010 19:59:36 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oB8JxVXO002281	for
	<linuxppc-dev@lists.ozlabs.org>; Wed, 8 Dec 2010 12:59:32 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	oB8KHlcZ029450	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 8 Dec 2010 14:17:47 -0600 (CST)
Date: Wed, 8 Dec 2010 13:59:28 -0600
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
Message-ID: <20101208135928.0278f97d@udp111988uds.am.freescale.net>
In-Reply-To: <OF14047E09.664EC753-ONC12577F3.006CF507-C12577F3.006D97EA@transmode.se>
References: <20101207031554.GA12731@postdiluvian.org>
	<20101207145153.540da45a@udp111988uds.am.freescale.net>
	<OFF94B1B01.88594E81-ONC12577F3.002B63AA-C12577F3.002BEE0B@transmode.se>
	<20101208111839.1cf95553@udp111988uds.am.freescale.net>
	<OF349DC945.8BC48D34-ONC12577F3.00601D94-C12577F3.00605153@transmode.se>
	<20101208192616.GA24560@postdiluvian.org>
	<OF14047E09.664EC753-ONC12577F3.006CF507-C12577F3.006D97EA@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Mark Mason <mason@postdiluvian.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 8 Dec 2010 20:57:03 +0100
Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:

> Mark Mason <mason@postdiluvian.org> wrote on 2010/12/08 20:26:16:
> >
> > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> >
> > > Scott Wood <scottwood@freescale.com> wrote on 2010/12/08 18:18:39:
> > > >
> > > > On Wed, 8 Dec 2010 08:59:49 +0100
> > > > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > > >
> > > > > > If you attach NAND to the LBC, you should not attach anything else to
> > > > > > it which is latency-sensitive.
> > > > >
> > > > > This "feature" makes the LBC useless to us. Is there some workaround or plan
> > > > > to address this limitation?
> > > >
> > > > Complain to your support or sales contact.
> > > >
> > > > I've complained about it in the past, and got a "but pins are a limited
> > > > resource!" response.  They need to hear that it's a problem from
> > > > customers.
> > >
> > > Done, lets see what I get in return. I think this problem will be
> > > a major obstacle for our next generation boards which will be NAND
> > > based.
> >
> > It was a big problem, and a big surprise, for me too.  The next
> > generation of a couple of the chips on the bus have pcie, but those
> > are noticably more expensive.
> 
> Can you think of any workaround such as not connecting the BUSY pin at all?

Maybe connect the busy pin to a gpio?

-Scott
