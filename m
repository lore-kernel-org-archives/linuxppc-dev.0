Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQ6zg6G9bzDr2d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 21:24:31 +1100 (AEDT)
In-Reply-To: <1458024458-19206-1-git-send-email-oss@buserror.net>
To: Scott Wood <oss@buserror.net>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 chenhui.zhao@freescale.com
Subject: Re: powerpc/book3e-64: Use hardcoded mttmr opcode
Message-Id: <3qQ6zg5H2dz9sdQ@ozlabs.org>
Date: Wed, 16 Mar 2016 21:24:31 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-15-03 at 06:47:38 UTC, Scott Wood wrote:
> This preserves the ability to build using older binutils (reportedly <=
> 2.22).
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> Cc: chenhui.zhao@freescale.com

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7a25d91214cb22e642b9ed6e44

cheers
