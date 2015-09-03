Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 84E011A1E5F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 15:18:03 +1000 (AEST)
Message-ID: <1441257482.29016.6.camel@ellerman.id.au>
Subject: Re: [PATCH] purgatory/arch/ppc64: Reset primary cpu endian to
 big-endian
From: Michael Ellerman <mpe@ellerman.id.au>
To: Simon Horman <horms@verge.net.au>
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Date: Thu, 03 Sep 2015 15:18:02 +1000
In-Reply-To: <20150902010251.GC30886@verge.net.au>
References: <1440125476-9420-1-git-send-email-sam.mj@au1.ibm.com>
 <20150902010251.GC30886@verge.net.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-02 at 10:02 +0900, Simon Horman wrote:
> [CC linuxppc-dev]
> 
> On Fri, Aug 21, 2015 at 12:51:16PM +1000, Samuel Mendoza-Jonas wrote:
> > Older big-endian ppc64 kernels don't include the FIXUP_ENDIAN check,
> > meaning if we kexec from a little-endian kernel the target kernel will
> > fail to boot.
> > Returning to big-endian before we enter the target kernel ensures that
> > the target kernel can boot whether or not it includes FIXUP_ENDIAN.
> > 
> > This mirrors commit 150b14e7 in kexec-lite.
> > 
> > Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
> 
> I would value a review from one of the PPC folks.

The diff looks good to me, and I've also tested it, so take your pick:

Tested-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
