Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xywGF2YWrzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 11:03:33 +1000 (AEST)
In-Reply-To: <1504766140.12628.14.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Russell Currey <ruscur@au1.ibm.com>
Subject: Re: [1/2] powerpc/eeh: Create PHB PEs after EEH is initialized
Message-Id: <3xywGF1mpvz9t30@ozlabs.org>
Date: Fri, 22 Sep 2017 11:03:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-09-07 at 06:35:40 UTC, Benjamin Herrenschmidt wrote:
> Otherwise we end up not yet having computed the right
> diag data size on powernv where EEH initialization
> is delayed, thus causing memory corruption later on
> when calling OPAL.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Acked-by: Russell Currey <ruscur@russell.cc>

Patch 1 applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/3e77adeea3c5393c9b624832f65441

cheers
