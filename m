Return-Path: <jbe@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 6D1E0475C8
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 08:14:57 +1100 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Wed, 21 Jan 2009 22:13:03 +0100
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
	<20090121205512.31232.99373.stgit@localhost.localdomain>
In-Reply-To: <20090121205512.31232.99373.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901212213.04001.jbe@pengutronix.de>
Subject: Re: [PATCH 2/8] powerpc/5200: Stop using device_type and port-number
	properties
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Mittwoch, 21. Januar 2009 21:55 schrieb Grant Likely:
> [...]
> The whole 'port-number' scheme for assigning numbers to PSC uarts was
> always rather half baked and just adds complexity. =A0Remove it from the
> driver. =A0After this patch is applied, PSC UART numbers are simply
> assigned from the order they are found in the device tree (just like
> all the other devices). =A0Userspace can query sysfs to determine what
> ttyPSC number is assigned to each PSC instance.

Arrghh, the next time we have to touch every oftree of our supported boards=
 to=20
keep it work. Does it ever end?

Juergen
=2D-=20
Pengutronix e.K.                           | Dipl.-Ing. Juergen Beisert  |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Vertretung Sued/Muenchen, Germany          | Phone: +49-5121-206917-7    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
