Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdjhm1fX0zDsfj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 23:07:20 +1000 (AEST)
In-Reply-To: <566929FA.2050409@linux.vnet.ibm.com>
To: xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Andrzej Hajda <a.hajda@samsung.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 tglx@linutronix.de, Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: powerpc/nvram: Fix an incorrect partition merge
Message-Id: <3sdjhm0b28z9t0m@ozlabs.org>
Date: Tue, 20 Sep 2016 23:07:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-10-12 at 07:30:02 UTC, xinhui wrote:
> From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> 
> When we merge two contiguous partitions whose signatures are marked
> NVRAM_SIG_FREE, We need update prev's length and checksum, then write it
> to nvram, not cur's. So lets fix this mistake now.
> 
> Also use memset instead of strncpy to set the partition's name. It's
> more readable if we want to fill up with duplicate chars .
> 
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/11b7e154b132232535befe51c5

cheers
