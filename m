Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E339CDDDF3
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 22:45:59 +1100 (EST)
Message-Id: <9999C671-C483-45CC-AB88-9DF8854AF2D1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <49C64413.605@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v2] powerpc/85xx: Add support for the "socrates" board
	(MPC8544).
Date: Fri, 27 Mar 2009 06:45:48 -0500
References: <49C64413.605@grandegger.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 22, 2009, at 8:58 AM, Wolfgang Grandegger wrote:

> Supported are Ethernet, serial console, I2C, I2C-based RTC and
> temperature sensors, NOR and NAND flash, PCI, USB, CAN and Lime
> display controller.
>
> The multiplexing of FPGA interrupts onto PowerPC interrupt lines is
> supported through our own fpga_pic interrupt controller driver.
>
> For example the SJA1000 controller is level low sensitive connected to
> fpga_pic line 2 and is routed to the second (of three) irq lines to
> the CPU:
>
>   can@3,100 {
>           compatible = "philips,sja1000";
>           reg = <3 0x100 0x80>;
>           interrupts = <2 2>;
>           interrupts = <2 8 1>;   // number, type, routing
>           interrupt-parent = <&fpga_pic>;
>   };
>
> Signed-off-by: Sergei Poselenov <sposelenov@emcraft.com>
> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Signed-off-by: Dmitry Rakhchev <rda@emcraft.com>
> ---
> arch/powerpc/boot/dts/socrates.dts              |  338 +++++
> arch/powerpc/configs/85xx/socrates_defconfig    | 1410 ++++++++++++++ 
> ++++++++++
> arch/powerpc/platforms/85xx/Kconfig             |    6
> arch/powerpc/platforms/85xx/Makefile            |    1
> arch/powerpc/platforms/85xx/socrates.c          |  133 ++
> arch/powerpc/platforms/85xx/socrates_fpga_pic.c |  327 +++++
> arch/powerpc/platforms/85xx/socrates_fpga_pic.h |   16
> 7 files changed, 2231 insertions(+)
> create mode 100644 arch/powerpc/boot/dts/socrates.dts
> create mode 100644 arch/powerpc/configs/85xx/socrates_defconfig
> create mode 100644 arch/powerpc/platforms/85xx/socrates.c
> create mode 100644 arch/powerpc/platforms/85xx/socrates_fpga_pic.c
> create mode 100644 arch/powerpc/platforms/85xx/socrates_fpga_pic.h
> create mode 100644 drivers/mtd/nand/socrates_nand.c

applied to next

- k
