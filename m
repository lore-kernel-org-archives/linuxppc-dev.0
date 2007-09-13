Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4DDB3DDDD8
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 00:52:52 +1000 (EST)
Date: Thu, 13 Sep 2007 09:52:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5] Add Freescale DMA and DMA channel to
	Documentation/powerpc/booting-without-of.txt file.
Message-ID: <20070913145236.GC32043@ld0162-tx32.am.freescale.net>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
	<3b29878a7d3d1b14f84b5d3b182cdb98@kernel.crashing.org>
	<20070910032529.GA27828@localhost.localdomain>
	<46B96294322F7D458F9648B60E15112C85D61B@zch01exm26.fsl.freescale.net>
	<20070911141907.GF1932@ld0162-tx32.am.freescale.net>
	<46B96294322F7D458F9648B60E15112C85D755@zch01exm26.fsl.freescale.net>
	<20070912151938.GA15561@ld0162-tx32.am.freescale.net>
	<fd81b53021e39a13ea65c0a0319aab77@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fd81b53021e39a13ea65c0a0319aab77@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Zhang Wei-r63237 <Wei.Zhang@freescale.com>,
	paulus@samba.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2007 at 04:09:29AM +0200, Segher Boessenkool wrote:
> >>I have a strange issue here. If I rename 'fsl,dma' to 
> >>'fsl,mpc8540-dma',
> >>the 'fsl,mpc8540-dma-channel' will be also regarded as DMA device not
> >>DMA channel.
> >
> >What tree are you using?  Commit 
> >804ace8881d211ac448082e871dd312132393049
> >in Paul's git tree should have fixed that.
> 
> Strange, I don't see that commit -- maybe gitweb is broken, or
> maybe the patch was superseded, or maybe it just disappeared?
> It's still shown in patchworks with this commit id fwiw.

I see it here:
http://git.kernel.org/?p=linux/kernel/git/paulus/powerpc.git;a=commit;h=804ace8881d211ac448082e871dd312132393049

-Scott
