Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrKbg5x8FzDqdX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 23:39:11 +1000 (AEST)
In-Reply-To: <20160407215914.8404.10459.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [v4,3/3] ppc64/book3s: remove __end_handlers marker
Message-Id: <3qrKbf5S85z9t5c@ozlabs.org>
Date: Thu, 21 Apr 2016 23:39:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-07-04 at 22:00:34 UTC, Hari Bathini wrote:
> __end_handlers marker was intended to mark down upto code that gets
> called from exception prologs. But that hasn't kept pace with code
> changes. Case in point, slb_miss_realmode being called from exception
> prolog code but isn't below __end_handlers marker. So, __end_handlers
> marker is as good as a comment but could be misleading at times if
> it isn't in sync with the code, as is the case now. So, let us avoid
> this confusion by having a better comment and removing __end_handlers
> marker altogether.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/057b6d7e62ea4e6b1809e29469

cheers
