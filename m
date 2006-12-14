Return-Path: <bwarren@qstreams.com>
Received: from web314.biz.mail.mud.yahoo.com (web314.biz.mail.mud.yahoo.com
	[68.142.199.14]) by ozlabs.org (Postfix) with SMTP id D0A9567C82
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 07:19:06 +1100 (EST)
Date: Thu, 14 Dec 2006 12:12:24 -0800 (PST)
From: Ben Warren <bwarren@qstreams.com>
Subject: Re: [spi-devel-general] [PATCH] Adapt spi_mpc83xx SPI driver for 832x
To: Reeve Yang <yang.reeve@gmail.com>, joakim.tjernlund@transmode.se
In-Reply-To: <198592450612141159u6ad69302m86f1678ca5e1e62b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <859707.81440.qm@web314.biz.mail.mud.yahoo.com>
Cc: David Brownell <david-b@pacbell.net>,
	spi-devel-general@lists.sourceforge.net,
	linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Reeve,

--- Reeve Yang <yang.reeve@gmail.com> wrote:

> Hello, I'm working on the same thing but our board
> is using MPC8343E
> processor. Should the same patch be applied? If so
> could someone post
> a complete and clean patch? Though our kernel is
> 2.6.13, I back ported
> spi_mpc83xx but it's not working (the fsl controller
> cannot be
> detected). I'm hoping this patch could help on that
> ...
> 

I had the mpc83xx driver working on an MPC8349
processor under 2.6.14 a while ago.  The driver's very
small but requires a fair amount of board specific
initialization code.  Are you sure you added the
proper platform resources, etc?

regards,
Ben
