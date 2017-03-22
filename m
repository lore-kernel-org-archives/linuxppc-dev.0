Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vp7bB2M4YzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 23:02:14 +1100 (AEDT)
In-Reply-To: <20170321013802.GA21037@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: Revert "powerpc/64: Disable use of radix under a hypervisor"
Message-Id: <3vp7bB1Yd0z9s7l@ozlabs.org>
Date: Wed, 22 Mar 2017 23:02:14 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-03-21 at 01:38:02 UTC, Paul Mackerras wrote:
> This reverts commit 3f91a89d424a79f8082525db5a375e438887bb3e.
> 
> Now that we do have the machinery for using the radix MMU under a
> hypervisor, the extra check and comment introduced in 3f91a89d424a are
> no longer correct.  The result is that when booted under a hypervisor
> that only allows use of radix, we clear the MMU_FTR_TYPE_RADIX and
> then set it again, and print a warning about ignoring the
> disable_radix command line option, even though the command line does
> not include "disable_radix".
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/fc36a903265c18d124cefaba364a7f

cheers
