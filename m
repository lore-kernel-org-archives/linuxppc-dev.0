Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47D20DDE04
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 08:09:49 +1000 (EST)
In-Reply-To: <1191442145.21463.73.camel@ld0161-tx32>
References: <1191442145.21463.73.camel@ld0161-tx32>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C37406F3-BAFF-4468-8FAD-56B3828CF99B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/5] Add MPC8610 HPCD Base Port
Date: Wed, 3 Oct 2007 17:09:48 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2007, at 3:09 PM, Jon Loeliger wrote:

> Kumar and Paul,
>
> These five patches add the base port for the newly
> introduced MPC8610 HPCD reference board.  We would
> like to see these added to 2.6.24 if possible!
>
> Thanks,
> jdl
>
>
>  arch/powerpc/boot/dts/mpc8610_hpcd.dts      |  191 +++++
>  arch/powerpc/configs/mpc8610_hpcd_defconfig | 1023 ++++++++++++++++ 
> +++++++++++
>  arch/powerpc/platforms/86xx/Kconfig         |   13 +
>  arch/powerpc/platforms/86xx/Makefile        |    1 +
>  arch/powerpc/platforms/86xx/mpc8610_hpcd.c  |  267 +++++++
>  arch/powerpc/sysdev/fsl_pci.c               |    1 +
>  include/linux/pci_ids.h                     |    1 +
>  7 files changed, 1497 insertions(+), 0 deletions(-)

applied.

- k
