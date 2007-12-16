Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2EA49DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 02:45:14 +1100 (EST)
Date: Sun, 16 Dec 2007 16:44:58 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Arnon Kaufman <arnon.kaufman@gmail.com>
Message-ID: <20071216154458.GZ3851@pengutronix.de>
References: <47652712.60006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <47652712.60006@gmail.com>
Subject: Re: [MPC5200] problem running FEC and ATA
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 16, 2007 at 03:24:34PM +0200, Arnon Kaufman wrote:
> does any one succeed running a functional FEC and ATA (pata) running
> together?

Yes, we do, on the phyCORE-MPC5200B-tiny; you can check our patches here:
http://www.pengutronix.de/oselas/bsp/phytec/download/phyCORE-MPC5200B-tiny/

We've recently made the -6 release which supports ATA; although I'm not
sure if the tests were done with networking & ATA at the same time I
assume yes (at least while doing nfsroot). We'll re-check your scenario.

Note that there has been quite some activity wrt. MPC5200, bestcom and
fec in the mainline recently. You should test the latest 2.6.24-rc
kernel.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
