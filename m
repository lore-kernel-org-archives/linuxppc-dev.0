Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp6.wanadoo.fr (smtp6.wanadoo.fr [193.252.22.25])
	by ozlabs.org (Postfix) with ESMTP id C8E3B67AA0
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 21:48:00 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0604.wanadoo.fr (SMTP Server) with ESMTP id 24D1E1C001FA
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 13:47:56 +0200 (CEST)
Date: Fri, 26 May 2006 13:42:45 +0200
To: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH/2.6.17-rc4 10/10] bugs fix for marvell SATA on powerp c pl
	atform
Message-ID: <20060526114245.GA32330@powerlinux.fr>
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
	<1147935734.17679.93.camel@localhost.localdomain>
	<446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca>
	<20060526083931.GA23938@powerlinux.fr> <4476E964.90509@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4476E964.90509@rtr.ca>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Alexandre.Bounine@tundra.com, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 26, 2006 at 07:41:24AM -0400, Mark Lord wrote:
> Sven Luther wrote:
> >I'm trying to use a Marvell 88SX5081 based card here in my pegasos machine,
> >and i never got it working with the libata driver, even with the patches 
> >Zang
> >provided (and 2.6.16 though, maybe i should update to a newer version). The
> >marvell provided driver worked though at some time.
> >
> >Would it be possible to have access to your work, in order to not duplicate
> >effort or something ? 
> 
> All of the relevant bits of "my work" are now in Jeff's upstream libata 
> tree,
> from the recently posted sata_mv patches.

Ok. can i use this tree with a 2.6.16 base ?
 
> After struggling with bad SDRAM earlier this week, I now have Ubuntu 
> installed
> and running reliably on my G3 box here.  Next step is to upgrade the kernel
> to something modern, and add in the latest sata_mv.

Ok.
 
> After that, I'll try my own 6081 Marvell card in it, and hopefully see the 
> same failures as you.. hopefully!

I tried getting a 6081 based low profile card, but they don't seem to sell in
europe.

Friendly,

Sven Luther
