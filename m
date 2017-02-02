Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDdTm6ctszDq9P
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 22:45:16 +1100 (AEDT)
In-Reply-To: <1485915824-14546-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/debug: PTDUMP should depend on DEBUG_FS
Message-Id: <3vDdTm5K1wz9s7N@ozlabs.org>
Date: Thu,  2 Feb 2017 22:45:16 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-01 at 02:23:44 UTC, Michael Ellerman wrote:
> CONFIG_PPC_PTDUMP currently selects CONFIG_DEBUG_FS. But CONFIG_DEBUG_FS
> is user-selectable, so we shouldn't select it. Instead depend on it.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/1c877f71b7b9c0a5144e29d599eac2

cheers
