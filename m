Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgL425VwzDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:35:56 +1000 (AEST)
In-Reply-To: <20170601053440.28976-3-rashmica.g@gmail.com>
To: Rashmica Gupta <rashmica.g@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org, npiggin@gmail.com, bsingharora@gmail.com, oohall@gmail.com,
 khandual@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Subject: Re: [v3, 3/3] Add documentation for the powerpc memtrace debugfs files
Message-Id: <3xjgL36pvJz9t2R@ozlabs.org>
Date: Thu, 31 Aug 2017 21:35:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-01 at 05:34:40 UTC, Rashmica Gupta wrote:
> CONFIG_PPC64_HARDWARE_TRACING must be set to use this feature. This can only
> be used on powernv platforms.
> 
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1f84c2624a2d75c9f69214ed83f11d

cheers
