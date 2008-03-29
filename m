Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id B988DDE01F
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 11:12:20 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so116395anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 17:12:19 -0700 (PDT)
Message-ID: <fa686aa40803281712q12ababc9hdb8f0ae69a34a493@mail.gmail.com>
Date: Fri, 28 Mar 2008 18:12:19 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [PATCH 1/9] [POWERPC] mv64x60: change FDT compatible prefix to
	mrvl
In-Reply-To: <20080329000047.GA31116@farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080328233954.GA29499@farnsworth.org>
	<20080328234241.GA30214@farnsworth.org>
	<fa686aa40803281647y4ccc4605n1507f9c1868d4c0f@mail.gmail.com>
	<20080329000047.GA31116@farnsworth.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 28, 2008 at 6:00 PM, Dale Farnsworth <dale@farnsworth.org> wrote:
> On Fri, Mar 28, 2008 at 05:47:25PM -0600, Grant Likely wrote:
>  > On Fri, Mar 28, 2008 at 5:42 PM, Dale Farnsworth <dale@farnsworth.org> wrote:
>  > > From: Dale Farnsworth <dale@farnsworth.org>
>  > >
>  > >  Follow the convention that compatible names are prefixed by the
>  > >  vendor's stock ticker symbol.  For Marvell Technology Group Ltd.,
>  > >  that's MRVL.
>  > >
>  > >  Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
>  > >  Acked-by: Mark A. Greer <mgreer@mvista.com>
>  >
>  > Are there any boards "in the wild" using the old string?  If so are
>  > does changing this string risk complicating upgrades to a new kernel
>  > version?
>
>  I don't think this complicates things much, since all these boards boot
>  a dtbImage, with an embedded dtb file built from the kernel source.
>  So the dts and code don't have much opportunity to get out of sync.

Cool; then looks good to me!  :-)

Acked-by: Grant Likely <grant.likely@secretlab.ca>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
