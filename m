Return-Path: <khali@linux-fr.org>
Received: from bamako.nerim.net (bamako.nerim.net [62.4.17.28])
	by ozlabs.org (Postfix) with ESMTP id B8D0AB6F0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  5 Jul 2010 17:29:35 +1000 (EST)
Date: Mon, 5 Jul 2010 09:22:31 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH] rtc: add support for DS3232 RTC
Message-ID: <20100705092231.2780a1b8@hyperion.delvare>
In-Reply-To: <1278312326-19022-1-git-send-email-tie-fei.zang@freescale.com>
References: <1278312326-19022-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Mingkai.hu@freescale.com, linuxppc-dev@lists.ozlabs.org,
	linux-i2c@vger.kernel.org, srikanth.srinivasan@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Roy,

On Mon,  5 Jul 2010 14:45:26 +0800, Roy Zang wrote:
> This patch adds the driver for RTC chip DS3232 via I2C bus
> 
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> Signed-off-by: Jingchang Lu <b22599@freescale.com>
> Signed-off-by: Srikanth Srinivasan <srikanth.srinivasan@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> Tested on MPC8536DS and P4080DS board
> 
>  drivers/rtc/Kconfig      |   11 +
>  drivers/rtc/Makefile     |    1 +
>  drivers/rtc/rtc-ds3232.c |  466 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 478 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/rtc/rtc-ds3232.c

You're sending this patch to the wrong list. Please read MAINTAINERS
again.

-- 
Jean Delvare
