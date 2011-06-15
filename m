Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 42346B6F9D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jun 2011 01:05:39 +1000 (EST)
Message-ID: <4DF8CA38.4010802@freescale.com>
Date: Wed, 15 Jun 2011 10:05:28 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Priyanka Jain <Priyanka.Jain@freescale.com>
Subject: Re: [PATCH][v2] Add support for RTC device: pt7c4338 in rtc-ds1307.c
References: <1308128390-23347-1-git-send-email-Priyanka.Jain@freescale.com>
In-Reply-To: <1308128390-23347-1-git-send-email-Priyanka.Jain@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com, p_gortmaker@yahoo.com,
	galak@gate.crashing.org, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Priyanka Jain wrote:
>  config RTC_DRV_DS1307
> -	tristate "Dallas/Maxim DS1307/37/38/39/40, ST M41T00, EPSON RX-8025"
> +	tristate "Dallas/Maxim DS1307/37/38/39/40, ST M41T00, EPSON RX-8025, PT7C4338"
>  	help
>  	  If you say yes here you get support for various compatible RTC
>  	  chips (often with battery backup) connected with I2C. This driver
>  	  should handle DS1307, DS1337, DS1338, DS1339, DS1340, ST M41T00,
> -	  EPSON RX-8025 and probably other chips. In some cases the RTC
> -	  must already have been initialized (by manufacturing or a
> +	  EPSON RX-8025, PT7C4338 and probably other chips. In some cases 
> +	  the RTC  must already have been initialized (by manufacturing or a
>  	  bootloader).

I think you should probably drop the Kconfig change, too.  It already says, "and
probably other chips", and you're also just bloating the summary line.  We can't
list every possible Dallas-compatible RTC chip here.

-- 
Timur Tabi
Linux kernel developer at Freescale
