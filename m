Return-Path: <stefan@agner.ch>
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by lists.ozlabs.org (Postfix) with ESMTP id E46571A03D3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2015 09:09:56 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 06 Apr 2015 01:09:06 +0200
From: Stefan Agner <stefan@agner.ch>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V2] tty: serial: Add const to struct
 =?UTF-8?Q?uart=5Fops=20declarations?=
In-Reply-To: <1428258294.2775.69.camel@perches.com>
References: <1428169665.2775.53.camel@perches.com>
 <a938a0e86638588e5ccff85771fa3b95@agner.ch>
 <1428258294.2775.69.camel@perches.com>
Message-ID: <d55b1a1240db66ae651cb99cd713694a@agner.ch>
Cc: linux-ia64@vger.kernel.org, kernel@stlinux.com,
 Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>,
 Patrice Chotard <patrice.chotard@st.com>, Pat Gefre <pfg@sgi.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 "Maciej W. Rozycki" <macro@linux-mips.org>, Daniel Walker <dwalker@fifo99.com>,
 sparclinux@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>,
 Jiri Slaby <jslaby@suse.cz>, Alexandre Courbot <gnurou@gmail.com>,
 Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>,
 =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 linux-serial@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>,
 Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 linux-tegra@vger.kernel.org, David Brown <davidb@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org, Maxime Coquelin <maxime.coquelin@st.com>,
 Barry Song <baohua@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tony Prisk <linux@prisktech.co.nz>, Bryan Huntsman <bryanh@codeaurora.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <kernel@pengutronix.de>,
 Vineet Gupta <vgupta@synopsys.com>, nios2-dev@lists.rocketboards.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015-04-05 20:24, Joe Perches wrote:
> Still compiled only x86 and not cross-compiled or tested.

Cross-compiled with multi_v7_defconfig

> 
>  drivers/tty/serial/21285.c                  | 2 +-
>  drivers/tty/serial/altera_jtaguart.c        | 2 +-
>  drivers/tty/serial/altera_uart.c            | 2 +-
>  drivers/tty/serial/amba-pl010.c             | 2 +-
>  drivers/tty/serial/amba-pl011.c             | 2 +-
>  drivers/tty/serial/apbuart.c                | 2 +-
>  drivers/tty/serial/ar933x_uart.c            | 2 +-
>  drivers/tty/serial/arc_uart.c               | 2 +-
>  drivers/tty/serial/atmel_serial.c           | 2 +-
>  drivers/tty/serial/bcm63xx_uart.c           | 2 +-
>  drivers/tty/serial/bfin_sport_uart.c        | 2 +-
>  drivers/tty/serial/bfin_uart.c              | 2 +-
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c | 2 +-
>  drivers/tty/serial/dz.c                     | 2 +-
>  drivers/tty/serial/efm32-uart.c             | 2 +-
>  drivers/tty/serial/fsl_lpuart.c             | 4 ++--

Tested that driver on actual hardware, looks fine.

>  drivers/tty/serial/icom.c                   | 2 +-
>  drivers/tty/serial/imx.c                    | 2 +-
>  drivers/tty/serial/ioc3_serial.c            | 2 +-
>  drivers/tty/serial/ioc4_serial.c            | 2 +-
>  drivers/tty/serial/ip22zilog.c              | 2 +-
>  drivers/tty/serial/jsm/jsm_tty.c            | 2 +-
>  drivers/tty/serial/lantiq.c                 | 2 +-
>  drivers/tty/serial/lpc32xx_hs.c             | 2 +-
>  drivers/tty/serial/m32r_sio.c               | 2 +-
>  drivers/tty/serial/max3100.c                | 2 +-
>  drivers/tty/serial/men_z135_uart.c          | 2 +-
>  drivers/tty/serial/meson_uart.c             | 2 +-
>  drivers/tty/serial/mpc52xx_uart.c           | 2 +-
>  drivers/tty/serial/mpsc.c                   | 2 +-
>  drivers/tty/serial/msm_serial.c             | 2 +-
>  drivers/tty/serial/mux.c                    | 2 +-
>  drivers/tty/serial/mxs-auart.c              | 2 +-
>  drivers/tty/serial/netx-serial.c            | 2 +-
>  drivers/tty/serial/nwpserial.c              | 2 +-
>  drivers/tty/serial/omap-serial.c            | 2 +-
>  drivers/tty/serial/pch_uart.c               | 2 +-
>  drivers/tty/serial/pmac_zilog.c             | 2 +-
>  drivers/tty/serial/pnx8xxx_uart.c           | 2 +-
>  drivers/tty/serial/pxa.c                    | 2 +-
>  drivers/tty/serial/sa1100.c                 | 2 +-
>  drivers/tty/serial/samsung.c                | 2 +-

This driver seems to alter the startup function on initialization:

  CC      drivers/video/of_display_timing.o
../drivers/tty/serial/samsung.c: In function 's3c24xx_serial_init_port':
../drivers/tty/serial/samsung.c:1702:3: error: assignment of member
'startup' in read-only object
   s3c24xx_serial_ops.startup = s3c64xx_serial_startup;
   ^

>  drivers/tty/serial/serial-tegra.c           | 2 +-
>  drivers/tty/serial/serial_ks8695.c          | 2 +-
>  drivers/tty/serial/serial_txx9.c            | 2 +-
>  drivers/tty/serial/sh-sci.c                 | 2 +-
>  drivers/tty/serial/sirfsoc_uart.c           | 2 +-
>  drivers/tty/serial/sn_console.c             | 2 +-
>  drivers/tty/serial/sprd_serial.c            | 2 +-
>  drivers/tty/serial/st-asc.c                 | 2 +-
>  drivers/tty/serial/sunhv.c                  | 2 +-
>  drivers/tty/serial/sunsab.c                 | 2 +-
>  drivers/tty/serial/sunsu.c                  | 2 +-
>  drivers/tty/serial/sunzilog.c               | 2 +-
>  drivers/tty/serial/timbuart.c               | 2 +-
>  drivers/tty/serial/uartlite.c               | 2 +-
>  drivers/tty/serial/ucc_uart.c               | 2 +-
>  drivers/tty/serial/vr41xx_siu.c             | 2 +-
>  drivers/tty/serial/vt8500_serial.c          | 2 +-
>  drivers/tty/serial/xilinx_uartps.c          | 2 +-
>  drivers/tty/serial/zs.c                     | 2 +-
>  61 files changed, 62 insertions(+), 62 deletions(-)

That is the only thing which popped up with multi_v7_defconfig.

--
Stefan
