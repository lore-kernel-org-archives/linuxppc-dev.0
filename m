Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id B2206DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 May 2008 22:21:00 +1000 (EST)
Date: Sun, 18 May 2008 14:01:04 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Albrecht =?iso-8859-15?Q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: MTD on Freescale 5200B - supported?
Message-ID: <20080518120104.GR13814@pengutronix.de>
References: <1211044665.4363.0@antares.localdomain>
	<fa686aa40805171231xa067188y443ddced0ec42030@mail.gmail.com>
	<1211055124.4363.2@antares.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1211055124.4363.2@antares.localdomain>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, May 17, 2008 at 10:12:04PM +0200, Albrecht Dreß wrote:
> Yes, that information is useful, thanks!  However, actually the answer to my
> question is that there is no MTD/NAND support in recent Linux kernels, right?

Linux supports MTD.
Linux supports NAND.
Linux supports MPC5200B.
Linux does not support MTD+NAND+MPC5200B

It's just a matter of bringing things together on your MPC5200.

rsc
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
