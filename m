Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3CEC92C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 09:34:23 +1100 (EST)
Message-ID: <1381271655.7979.290.camel@snotra.buserror.net>
Subject: Re: Elbc device driver
From: Scott Wood <scottwood@freescale.com>
To: Mercier Ivan <ivan.mercier@gmail.com>
Date: Tue, 8 Oct 2013 17:34:15 -0500
In-Reply-To: <CAMc2ieqYDBE8HYzmEvfKxw8o7AdYVGN_ew6tvsn_TsRcpEgL8g@mail.gmail.com>
References: <CAMc2ieqYDBE8HYzmEvfKxw8o7AdYVGN_ew6tvsn_TsRcpEgL8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-10-08 at 16:06 +0200, Mercier Ivan wrote:
> Hi,
> 
> I'm working on a powerpc qoriq p3041 and trying to communicate with a
> device by elbc bus in gpmc mode.
> 
> I 've integrated CONFIG_FSL_LBC in Linux which provide the basic functions.
> 
> Now I'm wondering how can I do read and write operations on the
> bus.Where is mapped my device?

You'll need to use ioremap() or of_iomap() to map it.

> Should I code .read and .write driver functions?How can I start?
> 
> How integrates my device in the device tree?

See Documentation/devicetree/bindings/powerpc/fsl/lbc.txt and examples
such as "board-control" in various device trees.

-Scott
