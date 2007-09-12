Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B60C2DDEC9
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 01:19:51 +1000 (EST)
Date: Wed, 12 Sep 2007 10:19:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
Subject: Re: [PATCH 1/5] Add Freescale DMA and DMA channel to
	Documentation/powerpc/booting-without-of.txt file.
Message-ID: <20070912151938.GA15561@ld0162-tx32.am.freescale.net>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
	<3b29878a7d3d1b14f84b5d3b182cdb98@kernel.crashing.org>
	<20070910032529.GA27828@localhost.localdomain>
	<46B96294322F7D458F9648B60E15112C85D61B@zch01exm26.fsl.freescale.net>
	<20070911141907.GF1932@ld0162-tx32.am.freescale.net>
	<46B96294322F7D458F9648B60E15112C85D755@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46B96294322F7D458F9648B60E15112C85D755@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 12, 2007 at 03:13:09AM -0700, Zhang Wei-r63237 wrote:
> I have a strange issue here. If I rename 'fsl,dma' to 'fsl,mpc8540-dma',
> the 'fsl,mpc8540-dma-channel' will be also regarded as DMA device not
> DMA channel.

What tree are you using?  Commit 804ace8881d211ac448082e871dd312132393049
in Paul's git tree should have fixed that.

-Scott
