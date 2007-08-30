Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BC59CDDE29
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 06:15:12 +1000 (EST)
Date: Thu, 30 Aug 2007 15:15:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 3/9] cpm2: Add SCCs to cpm2_clk_setup(),
	and cpm2_smc_clk_setup().
Message-ID: <20070830201500.GB5144@ld0162-tx32.am.freescale.net>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201922.GC24329@ld0162-tx32.am.freescale.net>
	<20070830022548.6e0ce296@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070830022548.6e0ce296@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 02:25:48AM +0400, Vitaly Bordug wrote:
> I would have it in the same patch, that adds clocking stuff to 8xx.

I was trying to keep the 8xx and 82xx patchsets reasonably separate.

> And maybe in the same, segregate source rather then having it in the
> foo_common.c, to ease fix/update/rework.

I'm not sure I understand what you mean -- where do you want the code to
go?

-Scott
