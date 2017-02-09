Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJzG353bmzDqJX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 00:20:11 +1100 (AEDT)
In-Reply-To: <1486427731.4850.102.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <pmac@au1.ibm.com>
Subject: Re: [1/2] powerpc/powernv: Fix CPU hotplug to handle waking on HVI
Message-Id: <3vJzG32lpZz9s7N@ozlabs.org>
Date: Fri, 10 Feb 2017 00:20:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-07 at 00:35:31 UTC, Benjamin Herrenschmidt wrote:
> The IPIs come in as HVI not EE, so we need to test the appropriate
> SRR1 bits. The encoding is such that it won't have false positives
> on P7 and P8 so we can just test it like that. We also need to handle
> the icp-opal variant of the flush.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/9b256714979fad61ae11d90b53cf67

cheers
