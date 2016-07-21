Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw9zC31XPzDqYx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 21:09:43 +1000 (AEST)
In-Reply-To: <1467695057-12431-22-git-send-email-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [21/41] powerpc/pmac: Remove spurrious machine type test
Message-Id: <3rw9zC198Rz9snm@ozlabs.org>
Date: Thu, 21 Jul 2016 21:09:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-07 at 05:03:57 UTC, Benjamin Herrenschmidt wrote:
> pmac_declare_of_platform_devices() is already a machine initcall, thus
> it won't be called on a non-powermac machine. Testing for chrp there
> is pointless.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b521f576df6c49fcc06fbc06a3

cheers
