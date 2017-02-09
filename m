Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJzCT1vNRzDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 00:17:57 +1100 (AEDT)
In-Reply-To: <1486427848.4850.105.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/opal-lpc: Remove unneeded include
Message-Id: <3vJzCT0LWrz9s7d@ozlabs.org>
Date: Fri, 10 Feb 2017 00:17:56 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-07 at 00:37:28 UTC, Benjamin Herrenschmidt wrote:
> We don't need asm/xics.h
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/86f7ce4b4751aaf51ebcff6dc21e38

cheers
