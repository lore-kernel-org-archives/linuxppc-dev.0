Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 86E58DE3A0
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 10:47:27 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so114249anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 16:47:25 -0700 (PDT)
Message-ID: <fa686aa40803281647y4ccc4605n1507f9c1868d4c0f@mail.gmail.com>
Date: Fri, 28 Mar 2008 17:47:25 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [PATCH 1/9] [POWERPC] mv64x60: change FDT compatible prefix to
	mrvl
In-Reply-To: <20080328234241.GA30214@farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080328233954.GA29499@farnsworth.org>
	<20080328234241.GA30214@farnsworth.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 28, 2008 at 5:42 PM, Dale Farnsworth <dale@farnsworth.org> wrote:
> From: Dale Farnsworth <dale@farnsworth.org>
>
>  Follow the convention that compatible names are prefixed by the
>  vendor's stock ticker symbol.  For Marvell Technology Group Ltd.,
>  that's MRVL.
>
>  Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
>  Acked-by: Mark A. Greer <mgreer@mvista.com>

Are there any boards "in the wild" using the old string?  If so are
does changing this string risk complicating upgrades to a new kernel
version?

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
