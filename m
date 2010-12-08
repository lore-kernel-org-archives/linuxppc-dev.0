Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 84036B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 04:18:50 +1100 (EST)
Received: from mail121-tx2 (localhost.localdomain [127.0.0.1])	by
	mail121-tx2-R.bigfish.com (Postfix) with ESMTP id 62ABA670461	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  8 Dec 2010 17:18:45 +0000 (UTC)
Received: from TX2EHSMHS036.bigfish.com (unknown [10.9.14.247])	by
	mail121-tx2.bigfish.com (Postfix) with ESMTP id 2AE7468804F	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  8 Dec 2010 17:18:45 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id oB8HKshB024230	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 8 Dec 2010 10:20:55 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	oB8HIfhC024857	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 8 Dec 2010 11:18:42 -0600 (CST)
Date: Wed, 8 Dec 2010 11:18:39 -0600
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
Message-ID: <20101208111839.1cf95553@udp111988uds.am.freescale.net>
In-Reply-To: <OFF94B1B01.88594E81-ONC12577F3.002B63AA-C12577F3.002BEE0B@transmode.se>
References: <20101207031554.GA12731@postdiluvian.org>
	<20101207145153.540da45a@udp111988uds.am.freescale.net>
	<OFF94B1B01.88594E81-ONC12577F3.002B63AA-C12577F3.002BEE0B@transmode.se>
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

On Wed, 8 Dec 2010 08:59:49 +0100
Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:

> >
> > On Mon, 6 Dec 2010 22:15:54 -0500
> > Mark Mason <mason@postdiluvian.org> wrote:
> >
> > > A few months ago I ran into some performance problems involving
> > > UBI/NAND erases holding other devices off the LBC on an MPC8315.  I
> > > found a solution for this, which worked well, at least with the
> > > hardware I was working with.  I suspect the same problem affects other
> > > PPCs, probably including multicore devices, and maybe other
> > > architectures as well.
> > >
> > > I don't have experience with similar NAND controllers on other
> > > devices, so I'd like to explain what I found and see if someone who's
> > > more familiar with the family and/or driver can tell if this is
> > > useful.
> > >
> > > The problem cropped up when there was a lot of traffic to the NAND
> > > (Samsung K9WAGU08U1B-PIB0), with the NAND being on the LBC along with
> > > a video chip that needed constant and prompt attention.
> >
> > If you attach NAND to the LBC, you should not attach anything else to
> > it which is latency-sensitive.
> 
> This "feature" makes the LBC useless to us. Is there some workaround or plan
> to address this limitation?

Complain to your support or sales contact.

I've complained about it in the past, and got a "but pins are a limited
resource!" response.  They need to hear that it's a problem from
customers.

-Scott
