Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shWzz0SskzDrPJ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 13:00:15 +1000 (AEST)
In-Reply-To: <1472797046-3505-1-git-send-email-rui.teng@linux.vnet.ibm.com>
To: Rui Teng <rui.teng@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Rui Teng <rui.teng@linux.vnet.ibm.com>, paulus@samba.org
Subject: Re: [v2] powerpc: Clean up tm_abort duplication in hash_utils_64.c
Message-Id: <3shWzy1Fz2z9sf6@ozlabs.org>
Date: Sun, 25 Sep 2016 13:00:13 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-02-09 at 06:17:26 UTC, Rui Teng wrote:
> The same logic appears twice and should probably be pulled out into a function.
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Rui Teng <rui.teng@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f1a55ce0544251746d9b52fb85

cheers
