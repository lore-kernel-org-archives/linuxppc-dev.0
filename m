Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EFE12DEF5D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 02:45:24 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3EGjJue026973
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 09:45:20 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m3EGjJZG026412
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 11:45:19 -0500 (CDT)
Date: Mon, 14 Apr 2008 11:45:18 -0500
From: Scott Wood <scottwood@freescale.com>
To: =?iso-8859-1?Q?Andr=E9?= Schwarz <Andre.Schwarz@matrix-vision.de>
Subject: Re: Flash on LocalBus @ MPC8343
Message-ID: <20080414164518.GB7061@ld0162-tx32.am.freescale.net>
References: <47FF802B.5020708@matrix-vision.de>
	<20080411153849.GB2588@loki.buserror.net>
	<47FFC2DE.80808@matrix-vision.de> <47FFC397.9040200@freescale.com>
	<480079CA.5040000@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <480079CA.5040000@matrix-vision.de>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 12, 2008 at 10:58:50AM +0200, André Schwarz wrote:
> thanks , but ... can't find "of_bus_ids[]" entry.

That means your platform likely isn't calling of_platform_bus_probe() at
all.  Look at other platforms, such as mpc831x_rdb, for an example.

> I'm obviously out of sync. My last git-pull from denx is 3 days old, now 
> - need to update on monday.

For Denx-specific support, please contact Denx.

This certainly isn't something that was added in the past 3 days.

-Scott
