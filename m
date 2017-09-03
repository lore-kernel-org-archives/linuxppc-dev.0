Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xlWpj6YWZzDqkh
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Sep 2017 22:03:41 +1000 (AEST)
Message-ID: <1504440154.2250.1.camel@kernel.crashing.org>
Subject: Re: [PATCH] devicetree: Remove remaining references/tests for
 "chosen@0"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: devicetree@vger.kernel.org, linux-mips@linux-mips.org, monstr@monstr.eu,
 Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>
Date: Sun, 03 Sep 2017 22:02:34 +1000
In-Reply-To: <alpine.LFD.2.21.1709030637090.24875@localhost.localdomain>
References: <alpine.LFD.2.21.1709020416130.13598@localhost.localdomain>
 <1504390854.4974.108.camel@kernel.crashing.org>
 <alpine.LFD.2.21.1709030637090.24875@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-09-03 at 06:43 -0400, Robert P. J. Day wrote:
>   however, given the diff stat of the change to remove every single
> reference to that node name in the current kernel source:
> 
>  arch/microblaze/kernel/prom.c | 3 +--
>  arch/mips/generic/yamon-dt.c  | 4 ----
>  arch/powerpc/boot/oflib.c     | 7 ++-----
>  drivers/of/base.c             | 2 --
>  drivers/of/fdt.c              | 5 +----
>  5 files changed, 4 insertions(+), 17 deletions(-)
> 
> it seems inconsistent that three architectures would be testing for
> that node, but none of the rest. consistency suggests that every
> architecture should take it into account, or none should.
> 
>   anyway, not a big deal, i'm fine with any decision.

powerpc is the only one of the 3 who has an actual open firmware
implementation afaik.

In any case, I think you can probably remove from microblaze and
possibly mips but I'm a bit worried about the generic case and powerpc
boot.

Cheers,
Ben.
