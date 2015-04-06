Return-Path: <soren.brinkmann@xilinx.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0061.outbound.protection.outlook.com [157.56.110.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E41B31A04ED
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2015 12:07:15 +1000 (AEST)
Date: Sun, 5 Apr 2015 18:36:37 -0700
From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V2] tty: serial: Add const to struct uart_ops declarations
References: <1428169665.2775.53.camel@perches.com>
 <a938a0e86638588e5ccff85771fa3b95@agner.ch>
 <1428258294.2775.69.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <1428258294.2775.69.camel@perches.com>
Message-ID: <0838dec2-0adf-4e5e-a26c-f0752a0fd2f9@BL2FFO11FD031.protection.gbl>
Cc: linux-ia64@vger.kernel.org, kernel@stlinux.com,
 Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>,
 Stefan Agner <stefan@agner.ch>, Patrice Chotard <patrice.chotard@st.com>,
 Pat Gefre <pfg@sgi.com>, Laxman Dewangan <ldewangan@nvidia.com>,
 "Maciej W. Rozycki" <macro@linux-mips.org>, Daniel
 Walker <dwalker@fifo99.com>, sparclinux@vger.kernel.org,
 Sonic Zhang <sonic.zhang@analog.com>, Jiri Slaby <jslaby@suse.cz>,
 Alexandre Courbot <gnurou@gmail.com>, Russell King <linux@arm.linux.org.uk>,
 Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org,
 Tobias Klauser <tklauser@distanz.ch>, Stephen Warren <swarren@wwwdotorg.org>,
 linux-arm-msm@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 linux-tegra@vger.kernel.org, David Brown <davidb@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org, Maxime Coquelin <maxime.coquelin@st.com>,
 Barry Song <baohua@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tony Prisk <linux@prisktech.co.nz>, Bryan Huntsman <bryanh@codeaurora.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <kernel@pengutronix.de>,
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

On Sun, 2015-04-05 at 11:24AM -0700, Joe Perches wrote:
> These structs can be const, so make them const.
> 
> Miscellanea:
> 
> o Add static to struct uart_ops declaration in bfin_sport_uart
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
[...]

For:
>  drivers/tty/serial/xilinx_uartps.c          | 2 +-

Tested-by: Sören Brinkmann <soren.brinkmann@xilinx.com>

	Sören
