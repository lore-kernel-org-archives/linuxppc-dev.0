Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
 [216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BAD59B6F69
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 03:21:38 +1100 (EST)
Message-ID: <4ED50633.4020506@freescale.com>
Date: Tue, 29 Nov 2011 10:20:03 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/6] powerpc/85xx: consolidate of_platform_bus_probe calls
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
 <1321552581-29773-2-git-send-email-dbaryshkov@gmail.com>
 <CAOZdJXXZG38v-tgA2Ty7-uxJ3AxoFCmNxMO3dKJnJYQtJFb9DA@mail.gmail.com>
 <38BAFE03-DB17-4442-8CC2-E386E46FEB19@kernel.crashing.org>
 <4ED5058F.90004@freescale.com>
In-Reply-To: <4ED5058F.90004@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Timur Tabi wrote:

> If I move the "fsl,eloplus-dma" into mpc85xx_common_ids[], then everything works.
> 
> I suspect there's some kind of state machine in of_platform_bus_probe() that allows it to find the DMA channel nodes if it's scanned everything else first.  I'm trying to debug it now.

So why do we need mpc85xx_common_ids[] at all?  Why can't of_platform_bus_probe() just scan the entire tree?

-- 
Timur Tabi
Linux kernel developer at Freescale
