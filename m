Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzx1GJfzDrMF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:29 +1100 (AEDT)
In-Reply-To: <1475196706-6105-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/fadump: Fix build break when CONFIG_PROC_VMCORE=n
Message-Id: <3spfzw4FwWz9t0q@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:28 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-30-09 at 00:51:46 UTC, Michael Ellerman wrote:
> The fadump code calls vmcore_cleanup() which only exists if
> CONFIG_PROC_VMCORE=y. We don't want to depend on CONFIG_PROC_VMCORE,
> because it's user selectable, so just wrap the call in an #ifdef.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/2685f826e5ffd1ab73b26fd5ac4e1f

cheers
