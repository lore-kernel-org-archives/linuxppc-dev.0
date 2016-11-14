Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzd4z5RzDvcm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:17 +1100 (AEDT)
In-Reply-To: <1478157487-1533-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anton@samba.org
Subject: Re: powerpc/configs: Drop REISERFS from pseries & powernv
Message-Id: <3tHTzd1YfNz9t1h@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:16 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-03-11 at 07:18:07 UTC, Michael Ellerman wrote:
> No one uses reiserfs much these days, or is likely to in future. So drop
> it from pseries and powernv defconfigs to save time and space. It's
> still enabled in ppc64_defconfig so we get some build coverage.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/7a53ef5ebe80bc15f70d060dc45484

cheers
