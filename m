Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by lists.ozlabs.org (Postfix) with ESMTP id 2E08A1A0725
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2015 19:47:42 +1000 (AEST)
Date: Fri, 4 Sep 2015 18:47:35 +0900
From: Simon Horman <horms@verge.net.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] purgatory/arch/ppc64: Reset primary cpu endian to
 big-endian
Message-ID: <20150904094735.GB30724@verge.net.au>
References: <1440125476-9420-1-git-send-email-sam.mj@au1.ibm.com>
 <20150902010251.GC30886@verge.net.au>
 <1441257482.29016.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441257482.29016.6.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 03, 2015 at 03:18:02PM +1000, Michael Ellerman wrote:
> On Wed, 2015-09-02 at 10:02 +0900, Simon Horman wrote:
> > [CC linuxppc-dev]
> > 
> > On Fri, Aug 21, 2015 at 12:51:16PM +1000, Samuel Mendoza-Jonas wrote:
> > > Older big-endian ppc64 kernels don't include the FIXUP_ENDIAN check,
> > > meaning if we kexec from a little-endian kernel the target kernel will
> > > fail to boot.
> > > Returning to big-endian before we enter the target kernel ensures that
> > > the target kernel can boot whether or not it includes FIXUP_ENDIAN.
> > > 
> > > This mirrors commit 150b14e7 in kexec-lite.
> > > 
> > > Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
> > 
> > I would value a review from one of the PPC folks.
> 
> The diff looks good to me, and I've also tested it, so take your pick:
> 
> Tested-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks, I took the latter.
