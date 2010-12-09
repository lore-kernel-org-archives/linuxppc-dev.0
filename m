Return-Path: <hs@denx.de>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id 39CBBB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 17:44:07 +1100 (EST)
Date: Thu, 09 Dec 2010 07:43:52 +0100
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2] powerpc, 5200: add support for charon board
In-reply-to: <20101208154911.GE4641@pengutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Message-id: <4D007AA8.9050101@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
References: <1291450906-22445-1-git-send-email-hs@denx.de>
	<1291705135-26805-1-git-send-email-hs@denx.de>
	<20101208154911.GE4641@pengutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Wolfram,

Wolfram Sang wrote:
> On Tue, Dec 07, 2010 at 07:58:55AM +0100, Heiko Schocher wrote:
>> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks!

One more defconfig question:

Is it possible to add to the mpc5200_defconfig, what is needed for
this board to compile a kernel which contains all features it needs?

I need:

CONFIG_HWMON
CONFIG_SENSORS_LM80
CONFIG_RTC_LIB
CONFIG_RTC_CLASS
CONFIG_RTC_HCTOSYS
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_INTF_SYSFS
CONFIG_RTC_INTF_PROC
CONFIG_RTC_INTF_DEV
CONFIG_RTC_DRV_DS1374

I think, to have a DTS in kernel for a board, and no defconfig, which
builds a kernel with all features for it, is suboptimal, or?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
