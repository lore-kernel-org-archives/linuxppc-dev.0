Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by ozlabs.org (Postfix) with ESMTP id CE5DEDDF2D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 05:37:59 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1388069rvf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Oct 2007 12:37:59 -0700 (PDT)
Message-ID: <fa686aa40710161237t54688b71g9c7cf9acdac2b744@mail.gmail.com>
Date: Tue, 16 Oct 2007 13:37:58 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: aauer1 <aauer1@gmx.at>
Subject: Re: Linux booting problem on Xilinx ppc
In-Reply-To: <13239003.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12694083.post@talk.nabble.com>
	<fa686aa40709152009k2b27ffc9kfb3fd0848f6b16d@mail.gmail.com>
	<12696686.post@talk.nabble.com> <13219154.post@talk.nabble.com>
	<000901c81006$7303b490$bb3ca688@LGE.NET>
	<13239003.post@talk.nabble.com>
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

On 10/16/07, aauer1 <aauer1@gmx.at> wrote:
>
> The on-chip memories are disabled. Only the BRAM is enabled. Now, we also use
> the ELDK 4.1 from Denx and the included cross compiler. The result is the
> same... the Kernel stops at "Now booting the kernel". Now, we also have an
> USB JTAG cable. So, we can debug the memory.
> Probably, anyone has another idea.

There are two common reasons for this behaviour:
1. kernel crashes before the console is configured
2. the console is not configured correctly.

In both cases; finding a way to look at __log_buf is the fastest way
to figure out what is going on.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
