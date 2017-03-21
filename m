Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnW3X27MmzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 22:36:08 +1100 (AEDT)
In-Reply-To: <1473501690-11987-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linux-pcmcia@lists.infradead.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: drivers/pcmcia: NO_IRQ removal for electra_cf.c
Message-Id: <3vnW3X13S2z9s7t@ozlabs.org>
Date: Tue, 21 Mar 2017 22:36:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-09-10 at 10:01:30 UTC, Michael Ellerman wrote:
> We'd like to eventually remove NO_IRQ on powerpc, so remove usages of it
> from electra_cf.c which is a powerpc-only driver.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/6c8343e82bec46ece4fe773304a84c

cheers
