Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A2C9DE2D6
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 11:00:57 +1100 (EST)
Date: Fri, 28 Mar 2008 17:00:47 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Grant Likely <grant.likely@secretlab.ca>
Message-ID: <20080329000047.GA31116@farnsworth.org>
References: <20080328233954.GA29499@farnsworth.org>
	<20080328234241.GA30214@farnsworth.org>
	<fa686aa40803281647y4ccc4605n1507f9c1868d4c0f@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <fa686aa40803281647y4ccc4605n1507f9c1868d4c0f@mail.gmail.com>
Subject: Re: [PATCH 1/9] [POWERPC] mv64x60: change FDT compatible prefix to
	mrvl
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 28, 2008 at 05:47:25PM -0600, Grant Likely wrote:
> On Fri, Mar 28, 2008 at 5:42 PM, Dale Farnsworth <dale@farnsworth.org> wrote:
> > From: Dale Farnsworth <dale@farnsworth.org>
> >
> >  Follow the convention that compatible names are prefixed by the
> >  vendor's stock ticker symbol.  For Marvell Technology Group Ltd.,
> >  that's MRVL.
> >
> >  Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> >  Acked-by: Mark A. Greer <mgreer@mvista.com>
> 
> Are there any boards "in the wild" using the old string?  If so are
> does changing this string risk complicating upgrades to a new kernel
> version?

I don't think this complicates things much, since all these boards boot
a dtbImage, with an embedded dtb file built from the kernel source.
So the dts and code don't have much opportunity to get out of sync.

-Dale
