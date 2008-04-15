Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 36A1BDE338
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 00:22:22 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3FEMH4k028276
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 07:22:17 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m3FELxw9028391
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 09:22:02 -0500 (CDT)
Date: Tue, 15 Apr 2008 09:21:59 -0500
From: Scott Wood <scottwood@freescale.com>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: Flash on LocalBus @ MPC8343
Message-ID: <20080415142159.GA25682@ld0162-tx32.am.freescale.net>
References: <47FF802B.5020708@matrix-vision.de>
	<20080411153849.GB2588@loki.buserror.net>
	<47FFC2DE.80808@matrix-vision.de> <47FFC397.9040200@freescale.com>
	<480079CA.5040000@matrix-vision.de>
	<20080414164518.GB7061@ld0162-tx32.am.freescale.net>
	<48049754.8010008@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48049754.8010008@matrix-vision.de>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 15, 2008 at 01:53:56PM +0200, Andre Schwarz wrote:
> Scott,
> 
> there has been a "compatible=soc" in my of_bus_id[] ...
> It was taken from mpc834x_mds some weeks ago.
> 
> I changed to :
> 
> static struct of_device_id __initdata of_bus_ids[] = {
>        { .compatible = "fsl,pq2pro-localbus", },
>        {},
> };

Don't get rid of the soc line, though -- both should be present.

-Scott
