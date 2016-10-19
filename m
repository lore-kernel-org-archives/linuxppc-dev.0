Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szFvh6BG0zDt1d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 13:17:36 +1100 (AEDT)
In-Reply-To: <1475644977-24133-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kselftest@vger.kernel.org
Subject: Re: selftests/powerpc: Fix build break caused by EXPORT_SYMBOL changes
Message-Id: <3szFvh46LNz9s9c@ozlabs.org>
Date: Wed, 19 Oct 2016 13:17:36 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-05-10 at 05:22:57 UTC, Michael Ellerman wrote:
> The changes to make EXPORT_SYMBOL work in asm, specifically commit
> 9445aa1a3062 ("ppc: move exports to definitions"), in the kbuild tree,
> breaks some of our selftests.
> 
> That is because we symlink the kernel code into the selftest, and shim
> the required headers, and we are now missing asm/export.h
> 
> So create a minimal export.h to keep the tests building once powerpc and
> the kbuild trees are merged.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/8321564a11bbeadffcc7d6335bcf3c

cheers
