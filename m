Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by ozlabs.org (Postfix) with ESMTP id 901CBDDE38
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 01:07:04 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i23so923878wra
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 08:07:03 -0700 (PDT)
Message-ID: <fa686aa40707230807k450ff82dv11201ca3a4ce4c9b@mail.gmail.com>
Date: Mon, 23 Jul 2007 09:07:02 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Someone broke my allmodconfig build
In-Reply-To: <46A4A9DC.6010602@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070722001212.5007001d.sfr@canb.auug.org.au>
	<18082.42674.651685.720737@cargo.ozlabs.ibm.com>
	<20070722115354.0c28d704.sfr@canb.auug.org.au>
	<46A4A9DC.6010602@freescale.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/23/07, Timur Tabi <timur@freescale.com> wrote:
> Stephen Rothwell wrote:
>
> >> Hmmm, we should be shipping .dtb files with the tree, so people don't
> >> have to have dtc installed.
> >
> > Unless, of course, we ship dtc ...
>
> I like that idea.
>
> I don't know much about the kernel build process, but is it normal to ship C files and have kbuild build them and then use the executables to build the rest of the kernel?

That's how Kconfig is built.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
