Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF9E0DDFB4
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 23:52:00 +1000 (EST)
Message-ID: <48B7FED5.2010203@freescale.com>
Date: Fri, 29 Aug 2008 08:51:17 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [82xx] powerpc: Add support for mpc8247 based	board	MGCOGE
	from keymile.
References: <20080612153215.GB2756@loki.buserror.net>	<4852A144.6090204@denx.de>
	<20080616072625.GB28470@yookeroo.seuss>	<4856350E.4080602@denx.de>	<20080616164915.GA14020@loki.buserror.net>	<4858C988.1000405@denx.de>
	<B7142E81-8992-4F05-BCAA-A4AAA41C0689@kernel.crashing.org>
In-Reply-To: <B7142E81-8992-4F05-BCAA-A4AAA41C0689@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

>> arch/powerpc/boot/dts/mgcoge.dts      |  174 +++++++
>> arch/powerpc/configs/mgcoge_defconfig |  900 
>> +++++++++++++++++++++++++++++++++
>> arch/powerpc/platforms/82xx/Kconfig   |    8 +
>> arch/powerpc/platforms/82xx/Makefile  |    1 +
>> arch/powerpc/platforms/82xx/mgcoge.c  |  129 +++++
>> 5 files changed, 1212 insertions(+), 0 deletions(-)
>> create mode 100644 arch/powerpc/boot/dts/mgcoge.dts
>> create mode 100644 arch/powerpc/configs/mgcoge_defconfig
>> create mode 100644 arch/powerpc/platforms/82xx/mgcoge.c
> 
> 
> applied to powerpc-next.
> 
> - k

This is a bit ambiguous.  Do you mean your galak next branch?
Or the Ben/Paul powerpc next branch?

Thanks,
jdl
