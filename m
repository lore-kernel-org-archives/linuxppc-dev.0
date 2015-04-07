Return-Path: <tklauser@sym2.noone.org>
Received: from sym2.noone.org (sym2.noone.org [178.63.92.236])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 969861A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 18:00:16 +1000 (AEST)
Date: Tue, 7 Apr 2015 09:49:57 +0200
From: Tobias Klauser <tklauser@distanz.ch>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V2] tty: serial: Add const to struct uart_ops declarations
Message-ID: <20150407074957.GA25696@distanz.ch>
References: <1428169665.2775.53.camel@perches.com>
 <a938a0e86638588e5ccff85771fa3b95@agner.ch>
 <1428258294.2775.69.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428258294.2775.69.camel@perches.com>
Cc: linux-ia64@vger.kernel.org, kernel@stlinux.com,
 Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>,
 Stefan Agner <stefan@agner.ch>, Patrice Chotard <patrice.chotard@st.com>,
 Pat Gefre <pfg@sgi.com>, Laxman Dewangan <ldewangan@nvidia.com>,
 "Maciej W. Rozycki" <macro@linux-mips.org>, Daniel Walker <dwalker@fifo99.com>,
 sparclinux@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>,
 Jiri Slaby <jslaby@suse.cz>, Alexandre Courbot <gnurou@gmail.com>,
 Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>,
 =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 linux-serial@vger.kernel.org, David Brown <davidb@codeaurora.org>,
 Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Maxime Coquelin <maxime.coquelin@st.com>, Barry Song <baohua@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tony Prisk <linux@prisktech.co.nz>, Bryan Huntsman <bryanh@codeaurora.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>,
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

On 2015-04-05 at 20:24:54 +0200, Joe Perches <joe@perches.com> wrote:

[...]

>  drivers/tty/serial/altera_jtaguart.c        | 2 +-
>  drivers/tty/serial/altera_uart.c            | 2 +-

For these two drivers:

Acked-by: Tobias Klauser <tklauser@distanz.ch>
