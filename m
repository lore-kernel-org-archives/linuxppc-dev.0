Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C067CDE498
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 23:50:23 +1000 (EST)
Date: Thu, 10 Apr 2008 15:50:12 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: State of the MPC5200 PSC AC97 driver
Message-ID: <20080410135012.GB13814@pengutronix.de>
References: <47FDEF9B.5000506@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <47FDEF9B.5000506@semihalf.com>
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>,
	spitzauer_77@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 10, 2008 at 12:44:43PM +0200, Marian Balakowicz wrote:
> Last year you have posted a MPC5200 PSC AC97 driver patch
> "[PATCH 9/9] sound: Add support for Freescale MPC5200 AC97 interface."
> with the following comment:
>
> > Not quite a clean driver, but it get things done (well, mostly).
> > Only included to be able to test functionalityi/usage of
> > the BestComm driver.
>
> There are various FIXMEs and commented out code here and there.
> Could you elaborate a bit on the overall state of the driver's
> functionality,
> which areas need improvement and attention?
>
> Seems that you mainly tested BestComm with this driver, what was the
> overall
> BestComm performance, any issues here? Did you use any specific test setup
> involving some dedicated application, etc.?
>
> Did anyone else tried it and/or has a updated version or can share
> experience?

Sidenote: last time we tried (2.6.23.1), the AC97 driver didn't work,
tested on the phyCORE-MPC5200B-tiny board. No sound, just a little bit
noise which can be muted with the mixer. And music finishes about 7
times as fast as it usually should. So we didn't manage to make it work
yet.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
