Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw0tW47LlzDqYy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 14:20:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3rw0tW2kCVz9t2f
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Jul 2016 14:20:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] powerpc: Merge 32-bit and 64-bit setup_arch()
In-Reply-To: <1469004611-17316-1-git-send-email-mpe@ellerman.id.au>
References: <1469004611-17316-1-git-send-email-mpe@ellerman.id.au>
Date: Thu, 21 Jul 2016 14:20:00 +1000
Message-ID: <87shv38vwv.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> There is little enough differences now.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> [mpe: Add empty versions using #ifdef in setup.h rather than weak functions]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/kvm_ppc.h |   4 -
>  arch/powerpc/include/asm/rtas.h    |   3 +-
>  arch/powerpc/include/asm/setup.h   |  46 +++++++++-
>  arch/powerpc/kernel/setup-common.c | 169 +++++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/setup_32.c     |  65 +-------------
>  arch/powerpc/kernel/setup_64.c     | 178 ++-----------------------------------
>  6 files changed, 228 insertions(+), 237 deletions(-)
>
> v2: Add empty versions using #ifdef in setup.h rather than weak functions.

This breaks a SMP=n BOOK3E=y config.

New version incoming.

cheers
