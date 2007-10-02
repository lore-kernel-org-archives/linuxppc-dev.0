Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A7C7DDF93
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Oct 2007 01:46:21 +1000 (EST)
Date: Tue, 2 Oct 2007 17:46:02 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Domen Puncer <domen@coderock.org>
Message-ID: <20071002154602.GV23573@pengutronix.de>
References: <20070810095153.GC13994@moe.telargo.com>
	<20070902074143.GB2642@nd47.coderock.org>
	<20071002124939.GC10481@pengutronix.de>
	<20071002143202.GQ32628@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20071002143202.GQ32628@nd47.coderock.org>
Subject: Re: [RFC PATCH v0.2] net driver: mpc52xx fec
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Oct 02, 2007 at 04:32:02PM +0200, Domen Puncer wrote:
> The patch looks ok to me.

Short update: even with the patch, the driver doesn't work on an
rt-preempt enabled kernel, or at least not reliable. It survives normal
traffic and ping -f, but dies when running nmap against the box, with a
set RFIFO_ERROR flag.

More research needs to be done.

Robert
-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
