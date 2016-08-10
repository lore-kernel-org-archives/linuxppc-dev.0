Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8W9m0fcMzDqJ4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 22:46:36 +1000 (AEST)
In-Reply-To: <147071935386.31859.2652230204782393894.stgit@jupiter.in.ibm.com>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Subject: Re: [v2] powerpc/book3s: Fix MCE console messages for unrecoverable
 MCE.
Message-Id: <3s8W9l5PqDz9t1q@ozlabs.org>
Date: Wed, 10 Aug 2016 22:46:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-08 at 05:09:13 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> When machine check occurs with MSR(RI=0), it means MC interrupt is
> unrecoverable and kernel goes down to panic path. But the console
> message still shows it as recovered. This patch fixes the MCE console
> messages.
> 
> Fixes: 36df96f8acaf ("powerpc/book3s: Decode and save machine check event.")
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c74dd88e77d3ecbc9e55c78796

cheers
