Return-Path: <l.fu@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D71FFB70CF
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 20:26:23 +1100 (EST)
Message-ID: <4B1F6D3A.3030500@pengutronix.de>
Date: Wed, 09 Dec 2009 10:26:18 +0100
From: Luotao Fu <l.fu@pengutronix.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: 2.6.33 -next tree
References: <fa686aa40911042210q5bbbca2fi82911b7245d17588@mail.gmail.com>
In-Reply-To: <fa686aa40911042210q5bbbca2fi82911b7245d17588@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

Grant Likely wrote:
> Hi Ben, Stephen.
> 
> I just prepared my next branch for 2.6.33:
> git://git.secretlab.ca/git/linux-2.6 next
> 

Just for curiosity: I noticed that you keep so far the further patches for the
dedicated spi controller on mpc5200 in the next-spi tree. Any plan when they
will be merged to the -next tree? Like mentioned before, some of them are
essential, without which the driver doesn't work (at least on my board)

sorry for nagging. ;-)

thanks

cheers
Luotao Fu
-- 
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
