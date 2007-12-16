Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E19A3DDE06
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 04:46:40 +1100 (EST)
Date: Sun, 16 Dec 2007 18:46:25 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Arnon Kaufman <arnon.kaufman@gmail.com>
Message-ID: <20071216174625.GB3851@pengutronix.de>
References: <47652712.60006@gmail.com> <20071216154458.GZ3851@pengutronix.de>
	<47656048.7060809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <47656048.7060809@gmail.com>
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

On Sun, Dec 16, 2007 at 07:28:40PM +0200, Arnon Kaufman wrote:
> Robert Schwebel wrote:
> >On Sun, Dec 16, 2007 at 03:24:34PM +0200, Arnon Kaufman wrote:
> >>does any one succeed running a functional FEC and ATA (pata) running
> >>together?
> >
> >Yes, we do, on the phyCORE-MPC5200B-tiny; you can check our patches here:
> >http://www.pengutronix.de/oselas/bsp/phytec/download/phyCORE-MPC5200B-tiny/
>
> thanks, my kernels are already patched and still observing that kind of
> behavior. I'm using Domen's new FEC code and ATA from 2.6.24-rc2.
>
> playing with the XLB Master's enable and priority lead to significant
> changes (good ones) in the rate of corruption appearance. I'm afraid of
> the "new" priority I've set, as that may lead to lockups on the XLB,
> still investigating.

Do you have a reproducable test scenario we can try on our hardware?

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
