Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 5A135DDFEF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 08:55:12 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so377704anc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 05 Sep 2007 15:55:10 -0700 (PDT)
Message-ID: <fa686aa40709051555m7f10bd95r48bd2eac7c7d0830@mail.gmail.com>
Date: Wed, 5 Sep 2007 16:55:10 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Ming Liu" <eemingliu@hotmail.com>
Subject: Re: Xilinx FX60
In-Reply-To: <BAY138-F27BF81B9795BD26A16564BB2CB0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40709051331q4a733c2dha6d182adb5778c83@mail.gmail.com>
	<BAY138-F27BF81B9795BD26A16564BB2CB0@phx.gbl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/5/07, Ming Liu <eemingliu@hotmail.com> wrote:
>
> > > Is it then possible to run two independent kernels, one on each PPC??
> >
> >Absolutely.
>
> Are you meaning two entirely seperate systems, or two ones which share a
> common HW such as memory space? Is that possible without any memory
> confliction?

You can share physical memory as long as each processor is dedicated
to separate regions.  However, Linux on power expects memory to be
based at 0.  Therefore you need to tweak the memory design so that the
second processor sees a different area of the ram based at zero.

You can even setup a shared memory region between the two processors,
but you that region should be cache-inhibited.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
