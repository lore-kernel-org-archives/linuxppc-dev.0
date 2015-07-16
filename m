Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D05D71A08AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 19:54:59 +1000 (AEST)
In-Reply-To: <1436427582-12777-1-git-send-email-jthumshirn@suse.de>
To: Johannes Thumshirn <jthumshirn@suse.de>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: cxl: Destroy afu->contexts_idr on release of an afu
Message-Id: <20150716095459.773941402C2@ozlabs.org>
Date: Thu, 16 Jul 2015 19:54:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-07 at 07:39:42 UTC, Johannes Thumshirn wrote:
> Destroy afu->contexts_idr on release of an afu, reclaiming the allocated
> memory.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bd664f892e3e2b01c791

cheers
