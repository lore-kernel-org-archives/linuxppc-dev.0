Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BFB081A0035
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 22:05:22 +1100 (AEDT)
In-Reply-To: <1456278905-4824-1-git-send-email-jk@ozlabs.org>
To: Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/3] powerpc/powernv: Add powernv_defconfig
Message-Id: <20160229110522.A518E140324@ozlabs.org>
Date: Mon, 29 Feb 2016 22:05:22 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-24-02 at 01:55:03 UTC, Jeremy Kerr wrote:
> This change adds a defconfig for the non-virtualised power platforms,
> based on pseries_defconfig, but without pseries, and little-endian,
> and no OF trampoline.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Acked-by: Joel Stanley <joel@jms.id.au>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/31b1108bcfcaa16a83f9dcb1f4

cheers
