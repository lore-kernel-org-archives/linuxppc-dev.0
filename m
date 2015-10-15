Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B63021A067C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 22:10:53 +1100 (AEDT)
In-Reply-To: <77516a018529fe23ca466db2ea513f7f03d820ec.1444265419.git.sam.bobroff@au1.ibm.com>
To: Sam bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: khandual@linux.vnet.ibm.com
Subject: Re: [v3,1/2] powerpc/xmon: Paged output for paca display
Message-Id: <20151015111053.9E2FD1402B3@ozlabs.org>
Date: Thu, 15 Oct 2015 22:10:53 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-08-10 at 00:50:23 UTC, Sam bobroff wrote:
> The paca display is already more than 24 lines, which can be problematic
> if you have an old school 80x24 terminal, or more likely you are on a
> virtual terminal which does not scroll for whatever reason.
...
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/958b7c80507a6eb847777b0d

cheers
