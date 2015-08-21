Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21C971A005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 17:43:36 +1000 (AEST)
In-Reply-To: <1437544251-19016-2-git-send-email-sam.mj@au1.ibm.com>
To: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Subject: Re: [V4,
 1/2] powerpc/kexec: Reset secondary cpu endianess before kexec
Message-Id: <20150821074335.D24651402C8@ozlabs.org>
Date: Fri, 21 Aug 2015 17:43:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-22-07 at 05:50:50 UTC, Samuel Mendoza-Jonas wrote:
> If the target kernel does not inlcude the FIXUP_ENDIAN check, coming
> from a different-endian kernel will cause the target kernel to panic.
> All ppc64 kernels can handle starting in big-endian mode, so return to
> big-endian before branching into the target kernel.
> 
> This mainly affects pseries as secondaries on powernv are returned to
> OPAL.
> 
> Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ffebf5f391dfa9da3e08

cheers
