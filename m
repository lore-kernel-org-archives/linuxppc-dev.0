Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ACC58DDEF2
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 01:31:28 +1000 (EST)
Date: Fri, 7 Sep 2007 10:31:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5] Add Freescale DMA and DMA channel to
	Documentation/powerpc/booting-without-of.txt file.
Message-ID: <20070907153116.GA15770@ld0162-tx32.am.freescale.net>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
	<3b29878a7d3d1b14f84b5d3b182cdb98@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3b29878a7d3d1b14f84b5d3b182cdb98@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2007 at 04:43:35PM +0200, Segher Boessenkool wrote:
> Those don't agree.  It's probably best to describe the whole
> DMA controller register block in this node.  Why do you need
> subnodes for the channels at all?

The channels have separate registers and sometimes separate interrupts --
it's simpler to bind to a channel at a time than to parse a list of reg
blocks and interrupts.  It's also more flexible in case a new chip comes
out with more/fewer channels, or if certain channels are not general
purpose.

-Scott
