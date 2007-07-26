Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8B8AADDF4D
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 03:37:25 +1000 (EST)
Message-ID: <46A8DBCE.8020400@freescale.com>
Date: Thu, 26 Jul 2007 12:37:18 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [RFC][PATCH] fsl_soc: add support for fsl_spi
References: <20070726135655.GA5643@localhost.localdomain>	<20070726164508.GB28491@ld0162-tx32.am.freescale.net>
	<20070726210507.18829b9a@vitb.ru.mvista.com>
In-Reply-To: <20070726210507.18829b9a@vitb.ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> On Thu, 26 Jul 2007 11:45:08 -0500
> Scott Wood <scottwood@freescale.com> wrote:
>>Why not make the fsl spi driver an of_platform device?
> 
> Because this particular thing is not ppc-only from what I recall.

spi_mpc83xx.c isn't ppc-only?

Even if it weren't, the OF stuff has been moved out of arch, so a 
non-arch-specific driver can support both platform and of_platform 
devices directly.

-Scott
