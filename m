Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1C771A1992
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 20:54:09 +1000 (AEST)
In-Reply-To: <1436247946-16292-2-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Matt Ochs <mrochs@us.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [2/2] cxl: Fail mmap if requested mapping is larger than assigned
 problem state area
Message-Id: <20150708105409.9D407140B0E@ozlabs.org>
Date: Wed,  8 Jul 2015 20:54:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-07-07 at 05:45:46 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This patch makes the mmap call fail outright if the requested region is
> larger than the problem state area assigned to the context so the error
> is reported immediately rather than waiting for an attempt to access an
> address out of bounds.
> 
> Although we never expect users to map more than the assigned problem
> state area and are not aware of anyone doing this (other than for
> testing), this does have the potential to break users if someone has
> used a larger range regardless. I'm submitting it for consideration, but
> if this change is not considered acceptable the previous patch is
> sufficient to prevent access out of bounds without breaking anyone.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?h=fixes&id=5caaf5346892d1e7f0b8b7223062644f8538483f

cheers
