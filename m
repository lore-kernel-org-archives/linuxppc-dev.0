Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 22CF12C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 00:18:38 +1000 (EST)
Message-ID: <1377181107.5029.91.camel@snotra.buserror.net>
Subject: Re: [PATCH 3/4] powerpc/booke64: Use appropriate -mcpu
From: Scott Wood <scottwood@freescale.com>
To: Rojhalat Ibrahim <imr@rtschenk.de>
Date: Thu, 22 Aug 2013 09:18:27 -0500
In-Reply-To: <1753626.1M86qx3vEi@pcimr>
References: <1377051162-2588-1-git-send-email-scottwood@freescale.com>
 <1377051162-2588-4-git-send-email-scottwood@freescale.com>
 <1753626.1M86qx3vEi@pcimr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Catalin Udma <catalin.udma@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-22 at 15:56 +0200, Rojhalat Ibrahim wrote:
> Just out of curiosity: What's the difference (if any) between -mcpu=e500mc64 
> and -mcpu=e5500? AFAIK -mcpu=e500mc64 is supported by gcc since at least 
> version 4.6 whereas -mcpu=e5500 is only supported since gcc 4.8. But is there 
> actually any difference?

I had asked our compiler person that before sending...  the answer
wasn't very clear, but when I asked whether there was any benefit for
the kernel specifying e5500 (requiring an extra fallback check) he said
"probably not".  Eventually they'll probably just become aliases for the
same thing.  Currently they do have separate .md files though, so
they're not identical.

-Scott
