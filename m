Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62988DDE06
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 20:36:49 +1000 (EST)
Date: Wed, 11 Jul 2007 12:36:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH 1/3] powerpc clk.h interface for platforms
Message-ID: <20070711103640.GB15536@lst.de>
References: <20070711093113.GE4375@moe.telargo.com>
	<20070711093220.GF4375@moe.telargo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070711093220.GF4375@moe.telargo.com>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	Sylvain Munaut <tnt@246tNt.com>, linux-mips@linux-mips.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 11, 2007 at 11:32:20AM +0200, Domen Puncer wrote:
> clk interface for arch/powerpc, platforms should fill
> clk_functions.

Umm, this is about the fifth almost identical implementation of
the clk_ functions.  Please, please put it into common code.

And talk to the mips folks which just got a similar comment from me.
