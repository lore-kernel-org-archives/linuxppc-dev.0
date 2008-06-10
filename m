Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EBDD3DDFCC
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 01:55:46 +1000 (EST)
Message-Id: <67EC8BE5-3BF0-4107-8FA9-A058283E7EB5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080429190049.GE21203@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 5/6] [POWERPC] 83xx: new board support: MPC8360E-RDK
Date: Tue, 10 Jun 2008 10:55:39 -0500
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190049.GE21203@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 29, 2008, at 2:00 PM, Anton Vorontsov wrote:

> This is patch adds board file, device tree, and defconfig for the new
> board, made by Freescale Semiconductor Inc. and Logic Product  
> Development.
>
> Currently supported:
> 1. UEC{1,2,7,4};
> 2. I2C;
> 3. SPI;
> 4. NS16550 serial;
> 5. PCI and miniPCI;
> 6. Intel NOR StrataFlash X16 64Mbit PC28F640P30T85;
> 7. Graphics controller, Fujitsu MB86277.
>
> Not supported in this patch:
> 1. StMICRO NAND512W3A2BN6E, 512 Mbit (supported with FSL UPM NAND  
> driver);
> 2. FHCI USB (supported with FHCI driver).
> 3. QE Serial UCCs (tested to not work with ucc_uart driver, reason
>   unknown, yet);
> 4. ADC AD7843 (tested to work, but support via device tree depends on
>   major SPI rework, GPIO API, etc);
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc836x_rdk.dts           |  397 +++++++++
> arch/powerpc/configs/83xx/mpc836x_rdk_defconfig | 1090 ++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/83xx/Kconfig             |   11 +
> arch/powerpc/platforms/83xx/Makefile            |    1 +
> arch/powerpc/platforms/83xx/mpc836x_rdk.c       |  111 +++
> 5 files changed, 1610 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/mpc836x_rdk.dts
> create mode 100644 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
> create mode 100644 arch/powerpc/platforms/83xx/mpc836x_rdk.c

Can you do me a favor and update mpc83xx_defconfig and make sure that  
boots and provide that in a separate patch.  I want to start making  
sure we have whatever features boards need enabled in the  
mpc83xx_defconfig.

thanks

- k
