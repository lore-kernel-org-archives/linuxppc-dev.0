Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5F9ADDDED
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 06:03:27 +1000 (EST)
Date: Tue, 8 Apr 2008 21:45:17 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Question on mpc52xx_common.c
Message-ID: <20080408194517.GX13814@pengutronix.de>
References: <m21w5map5f.fsf@ohwell.denx.de>
	<fa686aa40804031200n4cd7aeb4g330ab3e2620680e@mail.gmail.com>
	<47FAA0A8.7050602@genesi-usa.com>
	<200804080414.42867.arnd@arndb.de>
	<fa686aa40804071925v6c7d28edna529e6122fdc9cf7@mail.gmail.com>
	<23d2e4300804071926n57746a3cj551ef38bf10486c7@mail.gmail.com>
	<47FB3CD6.2090706@genesi-usa.com>
	<fa686aa40804080752g595196det8f576df1884bac5d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <fa686aa40804080752g595196det8f576df1884bac5d@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 08, 2008 at 08:52:55AM -0600, Grant Likely wrote:
> It may be ideal, but I don't think it is realistic.  I'm now of the
> firm opinion that device trees and firmware are *never* perfect.
> Especially when the definition of perfect is a moving target.

Well observed; isn't this the prove of the assumption that the whole
device tree idea is not working? It is *always* inconsistent and it is
*maintenance hell* because out-of-tree ports do *always* breakt because
of string inconsistencies. We have just ported a 8260 board from 2.6.22
to 2.6.25 and it is almost 100% oftree porting. And you do not even have
a single point of a parser, because all this string parsing is
completely scattered all over the tree.

The ARM method of using just a device number is so much easier ...

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
