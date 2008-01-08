Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E89FDDF2B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 04:50:38 +1100 (EST)
Date: Tue, 8 Jan 2008 11:48:09 -0600
From: Scott Wood <scottwood@freescale.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/4] nand base: Give drivers a chance to do late
	initialization.
Message-ID: <20080108174809.GB5188@loki.buserror.net>
References: <20071213171551.GA4459@loki.buserror.net>
	<1199779069.4111.379.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1199779069.4111.379.camel@shinybook.infradead.org>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 08, 2008 at 07:57:49AM +0000, David Woodhouse wrote:
> 
> On Thu, 2007-12-13 at 11:15 -0600, Scott Wood wrote:
> > Some nand controllers, such as the Freescale enhanced local bus controller,
> > need to do late initialization based on details of the chip that has been
> > probed, such as chip size, large/small pages, etc.  A late_init() callback
> > method is added to allow this.
> 
> Do you really need this so late? Can't it be done between
> nand_scan_ident() and nand_scan_tail()? That's why we split nand_scan()
> into two in the first place...

Yeah, that'd work.  I'll send an updated driver soon.

-Scott
