Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 49762B6FB7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 01:38:25 +1000 (EST)
Message-ID: <4DFA2363.3060004@freescale.com>
Date: Thu, 16 Jun 2011 10:38:11 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Priyanka Jain <Priyanka.Jain@freescale.com>
Subject: Re: [PATCH][v3] Add support for RTC device: pt7c4338 in rtc-ds1307.c
References: <1308197117-3586-1-git-send-email-Priyanka.Jain@freescale.com>
In-Reply-To: <1308197117-3586-1-git-send-email-Priyanka.Jain@freescale.com>
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
> PT7C4338 chip is being manufactured by Pericom Technology Inc.
> It is a serial real-time clock which provides:
> 1)Low-power clock/calendar.
> 2)Programmable square-wave output.
> It has 56 bytes of nonvolatile RAM.
> Its register set is same as that of rtc device: DS1307.
> 
> 
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
