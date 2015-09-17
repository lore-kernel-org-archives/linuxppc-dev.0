Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A08B1A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 15:13:29 +1000 (AEST)
In-Reply-To: <1442280257.9229.28.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/boot: Specify ABI v2 when building an LE boot wrapper
Message-Id: <20150917051328.EE02414029E@ozlabs.org>
Date: Thu, 17 Sep 2015 15:13:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-15-09 at 01:24:17 UTC, Benjamin Herrenschmidt wrote:
> The kernel does it, not the boot wrapper, which breaks with some
> cross compilers that still default to ABI v1.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: stable@vger.kernel.org

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/655471f54c2e395ba29ae415

cheers
