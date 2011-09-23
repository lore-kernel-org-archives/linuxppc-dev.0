Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40882B6F76
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2011 10:16:11 +1000 (EST)
Subject: Re: Please pull 'next' branch of 5xxx tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anatolij Gustschin <agust@denx.de>
In-Reply-To: <20110923012000.31d4e38d@wker>
References: <20110923012000.31d4e38d@wker>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Sep 2011 10:15:53 +1000
Message-ID: <1316736953.7975.193.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-09-23 at 01:20 +0200, Anatolij Gustschin wrote:
> Hi Ben,
> 
> please pull some mpc5xxx updates and mpc8xxx/512x gpio driver
> move patches for next.

Thanks, pulled & pushed out to github.

Cheers,
Ben.

> Anatolij
> 
> The following changes since commit a120db06c3f435c37d028b6e5a1968dad06b7df0:
> 
>   perf events, powerpc: Add POWER7 stalled-cycles-frontend/backend events (2011-09-20 16:12:56 +1000)
> 
> are available in the git repository at:
>   git://git.denx.de/linux-2.6-agust.git next
> 
> Anatolij Gustschin (4):
>       powerpc/5200: mpc5200b.dtsi: add spi node address- and size-cells properties
>       powerpc/5200: dts: digsy_mtc.dts: update to add can, pci, serial and spi
>       powerpc/5200: dts: digsy_mtc.dts: add timer0 and timer1 gpio properties
>       powerpc/5200: dts: digsy_mtc.dts: enable both MSCAN nodes
> 
> Timur Tabi (1):
>       powerpc/5200: enable audio in the defconfig
> 
> Wolfram Sang (2):
>       gpio: move mpc8xxx/512x gpio driver to drivers/gpio
>       powerpc: update 512x-defconfig
> 
>  arch/powerpc/boot/dts/digsy_mtc.dts                |   59 +++++++++++++++++---
>  arch/powerpc/boot/dts/mpc5200b.dtsi                |    2 +
>  arch/powerpc/configs/85xx/p1023rds_defconfig       |    2 +-
>  arch/powerpc/configs/85xx/xes_mpc85xx_defconfig    |    2 +-
>  arch/powerpc/configs/mpc512x_defconfig             |   19 ++++---
>  arch/powerpc/configs/mpc5200_defconfig             |   12 ++++
>  arch/powerpc/configs/mpc85xx_defconfig             |    2 +-
>  arch/powerpc/configs/mpc85xx_smp_defconfig         |    2 +-
>  arch/powerpc/configs/ppc6xx_defconfig              |    2 +-
>  arch/powerpc/platforms/512x/Kconfig                |    1 +
>  arch/powerpc/platforms/83xx/Kconfig                |    9 ++-
>  arch/powerpc/platforms/85xx/Kconfig                |   12 +++-
>  arch/powerpc/platforms/86xx/Kconfig                |    1 +
>  arch/powerpc/platforms/Kconfig                     |   10 ---
>  arch/powerpc/sysdev/Makefile                       |    1 -
>  drivers/gpio/Kconfig                               |    8 +++
>  drivers/gpio/Makefile                              |    1 +
>  .../mpc8xxx_gpio.c => drivers/gpio/gpio-mpc8xxx.c  |    0
>  18 files changed, 106 insertions(+), 39 deletions(-)
>  rename arch/powerpc/sysdev/mpc8xxx_gpio.c => drivers/gpio/gpio-mpc8xxx.c (100%)
