Return-Path: <patrice.chotard@st.com>
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DAB41A02CB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 17:33:22 +1000 (AEST)
Message-ID: <552383C2.3050502@st.com>
Date: Tue, 7 Apr 2015 09:14:10 +0200
From: Patrice Chotard <patrice.chotard@st.com>
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>, Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH V2] tty: serial: Add const to struct uart_ops declarations
References: <1428169665.2775.53.camel@perches.com>	
 <a938a0e86638588e5ccff85771fa3b95@agner.ch>
 <1428258294.2775.69.camel@perches.com>
In-Reply-To: <1428258294.2775.69.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Cc: linux-ia64@vger.kernel.org, kernel@stlinux.com,
 Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>,
 Pat Gefre <pfg@sgi.com>, Laxman Dewangan <ldewangan@nvidia.com>,
 "Maciej W. Rozycki" <macro@linux-mips.org>, Daniel Walker <dwalker@fifo99.com>,
 sparclinux@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>,
 Jiri Slaby <jslaby@suse.cz>, Alexandre Courbot <gnurou@gmail.com>,
 Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>,
 =?windows-1252?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
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
 =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <kernel@pengutronix.de>,
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

Hi

On 04/05/2015 08:24 PM, Joe Perches wrote:
> These structs can be const, so make them const.
>
> Miscellanea:
>
> o Add static to struct uart_ops declaration in bfin_sport_uart
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
[...]

for
>   drivers/tty/serial/st-asc.c                 | 2 +-

Acked-by: Patrice Chotard <patrice.chotard@st.com>


Thanks
