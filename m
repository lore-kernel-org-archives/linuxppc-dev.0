Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkQks0MyhzDqrR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 00:10:13 +1000 (AEST)
In-Reply-To: <1467297277-12494-1-git-send-email-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, stable@vger.kernel.org
Subject: Re: [v3] powerpc/boot: Add OPAL console to epapr wrappers
Message-Id: <3rkQkr52fFz9sdn@ozlabs.org>
Date: Wed,  6 Jul 2016 00:10:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-30-06 at 14:34:37 UTC, Oliver O'Halloran wrote:
> This patch adds an OPAL console backend to the powerpc boot wrapper so
> that decompression failures inside the wrapper can be reported to the
> user. This is important since it typically indicates data corruption in
> the firmware and other nasty things.
> 
> Currently this only works when building a little endian kernel. When
> compiling a 64 bit BE kernel the wrapper is always build 32 bit to be
> compatible with some 32 bit firmwares. BE support will be added at a
> later date. Another limitation of this is that only the "raw" type of
> OPAL console is supported, however machines that provide a hvsi console
> also provide a raw console so this is not an issue in practice.
> 
> Actually-written-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/656ad58ef19e2a763fa5c938b2

cheers
