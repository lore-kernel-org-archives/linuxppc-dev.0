Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB08A1A0D83
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 23:32:44 +1100 (AEDT)
In-Reply-To: <1452277810-98195-1-git-send-email-computersforpeace@gmail.com>
To: Brian Norris <computersforpeace@gmail.com>,
 Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>,
 Joe Perches <joe@perches.com>, Brian Norris <computersforpeace@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2,1/2] cxl: fix build for GCC 4.6.x
Message-Id: <20160112123244.CEA0D140662@ozlabs.org>
Date: Tue, 12 Jan 2016 23:32:44 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-08-01 at 18:30:09 UTC, Brian Norris wrote:
> GCC 4.6.3 does not support -Wno-unused-const-variable. Instead, use the
> kbuild infrastructure that checks if this options exists.
> 
> Fixes: 2cd55c68c0a4 ("cxl: Fix build failure due to -Wunused-variable behaviour change")
> Suggested-by: Michal Marek <mmarek@suse.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/aa09545589ceeff884421d8eb3

cheers
