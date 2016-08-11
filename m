Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s957j2jGpzDr0f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 21:16:49 +1000 (AEST)
In-Reply-To: <1469789289-2693-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: wei.guo.simon@gmail.com, khandual@linux.vnet.ibm.com
Subject: Re: selftests/powerpc: Specify we expect to build with std=gnu99
Message-Id: <3s957j0CxYz9t1H@ozlabs.org>
Date: Thu, 11 Aug 2016 21:16:48 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-29-07 at 10:48:09 UTC, Michael Ellerman wrote:
> We have some tests that assume we're using std=gnu99, which is fine on
> most compilers, but some old compilers use a different default.
> 
> So make it explicit that we want to use std=gnu99.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/ca49e64f0cb1368fc666a53b16

cheers
