Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 31B102C009F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 01:49:01 +1000 (EST)
Message-ID: <1377532129.3033.4.camel@snotra.buserror.net>
Subject: Re: Pull request: scottwood/linux.git next
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Date: Mon, 26 Aug 2013 10:48:49 -0500
In-Reply-To: <20130824010733.GA6116@home.buserror.net>
References: <20130824010733.GA6116@home.buserror.net>
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

On Fri, 2013-08-23 at 20:07 -0500, Scott Wood wrote:
> The following changes since commit afbcdd97bf117bc2d01b865a32f78f662437a4d8:
> 
>   powerpc/wsp: Fix early debug build (2013-08-16 10:59:27 +1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
> 
> for you to fetch changes up to 622e03eb3498c32ee29de5c1d6d381f443e58fad:
> 
>   powerpc/85xx: Add C293PCIE board support (2013-08-23 19:43:24 -0500)
> 
> ----------------------------------------------------------------
> Chunhe Lan (1):
>       powerpc/85xx: Add P1023RDB board support
> 
> Haijun.Zhang (1):
>       powerpc/85xx: Add support for 85xx cpu type detection
> 
> Mingkai Hu (3):
>       powerpc/85xx: Add SEC6.0 device tree
>       powerpc/85xx: Add silicon device tree for C293
>       powerpc/85xx: Add C293PCIE board support
> 
> Scott Wood (5):
>       powerpc/fsl-booke: Work around erratum A-006958
>       powerpc: Convert some mftb/mftbu into mfspr
>       powerpc/85xx: Remove -Wa,-me500
>       powerpc/booke64: Use appropriate -mcpu
>       powerpc/e500: Set -mcpu flag for 32-bit e500
> 
> Wang Dongsheng (1):
>       powerpc: add Book E support to 64-bit hibernation

Oh, forgot again: Highlights include changes in compiler flag settings
on e500 family cores, booke64 hibernation support, support for two new
boards, and an erratum workaround.

-Scott
