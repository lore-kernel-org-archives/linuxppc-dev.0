Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D6EFC2C021D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 04:41:29 +1000 (EST)
Message-ID: <1378406443.12204.102.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc: Add I2C bus multiplexer node for B4 and T4240QDS
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian-B29983 <B29983@freescale.com>
Date: Thu, 5 Sep 2013 13:40:43 -0500
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B15056D07@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1378194704-29909-1-git-send-email-hongtao.jia@freescale.com>
 <52268C7E.4040209@windriver.com>
 <D07C73A334FF604B95B3CBD2A545D07B15056D07@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Yang,
 Wei" <Wei.Yang@windriver.com>, Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-09-03 at 22:30 -0500, Tang Yuantian-B29983 wrote:
> Hi,
> 
> These eeproms are never used by kernel. So no need to add them.

The device tree describes the hardware, not what Linux does with it.

-Scott
