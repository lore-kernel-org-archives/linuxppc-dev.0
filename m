Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC4631A08BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 19:55:00 +1000 (AEST)
In-Reply-To: <1434680779-20194-2-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [1/4] powerpc/powernv: Allow to reserve one PE for multiple times
Message-Id: <20150716095500.5B4C81409F8@ozlabs.org>
Date: Thu, 16 Jul 2015 19:54:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-19-06 at 02:26:16 UTC, Gavin Shan wrote:
> The PE numbers are reserved according to root port's M64 window,
> which is aligned to M64 segment finely. So one PE shouldn't be
> reserved for multiple times. We will reserve PE numbers according
> to the M64 BARs of PCI device in subsequent patches, which aren't
> aligned to M64 segment size finely. It means one particular PE
> could be reserved for multiple times.
> 
> The patch allows one PE to be reserved for multiple times and we
> print the warning message at debugging level.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e9dc4d7f72a375020ecb

cheers
