Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 24D19DDFBB
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 08:19:42 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBKLJckn029140
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 16:19:38 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBKLJcgY195806
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 16:19:38 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBKLJb8h028465
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 16:19:38 -0500
Date: Wed, 20 Dec 2006 15:19:31 -0600
To: Peter Bergner <bergner@vnet.ibm.com>
Subject: Re: Bad gcc-4.1.0 leads to Power4 crashes... and power5 too, actually
Message-ID: <20061220211931.GB16860@austin.ibm.com>
References: <20061220004653.GL5506@austin.ibm.com>
	<1166579210.4963.15.camel@otta>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1166579210.4963.15.camel@otta>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 19, 2006 at 07:46:50PM -0600, Peter Bergner wrote:
> On Tue, 2006-12-19 at 18:46 -0600, Linas Vepstas wrote:
> > Per xchat, here's the update. I'm guessing I'm using a broken
> > compiler, as per chain of evidence below ...
> [snip]
> > However, I also note that the following scrolled by:
> > init/main.c:81:2: warning: #warning gcc-4.1.0 is known to miscompile the
> > kernel. A different compiler version is recommended.
> 
> It may be due to this GCC bug which Olaf ran into a while back:
> 
>   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=24644
> 
> You can verify whether you have a broken compiler by compiling
> the minimal test case I posted in comment #15.  If you see r13
> being copied into another register and then used, then you have
> a broken compiler.

No, that's not it. I'd be surprised, as I was using the SuSE
SLES10 gcc-4.1.0-28.4.ppc.rpm compiler, which would have that fix.

I'm trying to figure out how to try a different compiler,
I'm hoping that 3.3 can still compile new kernels.

I'll try to stare at the dump a bit too, now.

--linas
