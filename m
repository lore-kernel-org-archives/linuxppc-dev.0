Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B26ADDFA4
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 00:36:11 +1000 (EST)
Message-Id: <B178F135-5A41-456C-A482-0089C6517EC7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <48B7FED5.2010203@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] [82xx] powerpc: Add support for mpc8247
	based	board	MGCOGE from keymile.
Date: Fri, 29 Aug 2008 09:35:52 -0500
References: <20080612153215.GB2756@loki.buserror.net>	<4852A144.6090204@denx.de>
	<20080616072625.GB28470@yookeroo.seuss>	<4856350E.4080602@denx.de>	<20080616164915.GA14020@loki.buserror.net>	<4858C988.1000405@denx.de>
	<B7142E81-8992-4F05-BCAA-A4AAA41C0689@kernel.crashing.org>
	<48B7FED5.2010203@freescale.com>
Cc: linuxppc-dev@ozlabs.org, hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 29, 2008, at 8:51 AM, Jon Loeliger wrote:

> Kumar Gala wrote:
>
>>> arch/powerpc/boot/dts/mgcoge.dts      |  174 +++++++
>>> arch/powerpc/configs/mgcoge_defconfig |  900 ++++++++++++++++++++++ 
>>> +++++++++++
>>> arch/powerpc/platforms/82xx/Kconfig   |    8 +
>>> arch/powerpc/platforms/82xx/Makefile  |    1 +
>>> arch/powerpc/platforms/82xx/mgcoge.c  |  129 +++++
>>> 5 files changed, 1212 insertions(+), 0 deletions(-)
>>> create mode 100644 arch/powerpc/boot/dts/mgcoge.dts
>>> create mode 100644 arch/powerpc/configs/mgcoge_defconfig
>>> create mode 100644 arch/powerpc/platforms/82xx/mgcoge.c
>> applied to powerpc-next.
>> - k
>
> This is a bit ambiguous.  Do you mean your galak next branch?
> Or the Ben/Paul powerpc next branch?

seeing as the email is from me, it means its applied to my powerpc- 
next branch.

- k
