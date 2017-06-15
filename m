Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpdxp4fRKzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 08:50:22 +1000 (AEST)
In-Reply-To: <1497399565.2897.23.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Ellerman <michaele@au1.ibm.com>
Subject: Re: powerpc/xive: Fix offset for store EOI MMIOs
Message-Id: <3wpdxp3ncdz9s4q@ozlabs.org>
Date: Fri, 16 Jun 2017 08:50:22 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-14 at 00:19:25 UTC, Benjamin Herrenschmidt wrote:
> Architecturally we should apply a 0x400 offset for these. Not doing
> it will break future HW implementations.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/25642705b2359a705784bbbf1655c2

cheers
