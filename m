Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B641CDDE2E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 07:09:20 +1100 (EST)
Message-ID: <47336CE7.5070807@freescale.com>
Date: Thu, 08 Nov 2007 14:09:11 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: mpc8xxx MDS board RTC fixes
References: <20071108133706.961af8d2.kim.phillips@freescale.com>
	<F67D40A1-D8C9-4F96-A526-E848FDFDEA0B@kernel.crashing.org>
In-Reply-To: <F67D40A1-D8C9-4F96-A526-E848FDFDEA0B@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> should the mpc8568mds.dts be updated?

It already has been.

> Also, what code is parsing the device tree for the rtc node?

There's code in fsl_soc.c (which should be made more generic).

-Scott
