Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 954A0B6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 10:44:37 +1100 (EST)
Date: Mon, 19 Mar 2012 00:44:33 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 4/4] powerpc, mpc5200: add options to mpc5200_defconfig
Message-ID: <20120319004433.27433fd8@wker>
In-Reply-To: <1308729311-15375-5-git-send-email-hs@denx.de>
References: <1308729311-15375-1-git-send-email-hs@denx.de>
 <1308729311-15375-5-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 22 Jun 2011 09:55:11 +0200
Heiko Schocher <hs@denx.de> wrote:

> Add the following options to the mpc5200_defconfig, needed
> for the a4m072 board support:
> 
> CONFIG_AMD_PHY=y
> CONFIG_MTD_PLATRAM=y -> this deletes CONFIG_MTD_RAM=y
> CONFIG_GPIO_SYSFS=y
> CONFIG_SENSORS_LM87=m
> CONFIG_RTC_DRV_PCF8563=m
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> cc: Wolfgang Denk <wd@denx.de>
> ---
>  arch/powerpc/configs/mpc5200_defconfig |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

I squashed both patches (3/4, 4/4) to a single patch when re-basing
and applying.

Thanks,
Anatolij
