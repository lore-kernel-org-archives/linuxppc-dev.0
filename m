Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34D6167BF3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Jul 2005 01:07:03 +1000 (EST)
Date: Fri, 1 Jul 2005 07:17:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jason McMullan <jason.mcmullan@gmail.com>
Message-ID: <20050701101713.GC11121@logos.cnet>
References: <42C1AAC1.4060702@gmail.com> <20050629085913.GA2153@logos.cnet>
	<faba7798050630071347d4ad63@mail.gmail.com>
	<20050701094438.GA11121@logos.cnet>
	<1120229717.21507.9.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1120229717.21507.9.camel@jmcmullan.timesys>
Cc: Anton =?iso-8859-1?Q?W=F6llert?= <a.woellert@gmail.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: mpc8xx and ld.so problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jul 01, 2005 at 10:55:16AM -0400, Jason McMullan wrote:
> On Fri, 2005-07-01 at 06:44 -0300, Marcelo Tosatti wrote:
> > Hi Anton,
> > 
> > 
> > (moving to ppc-embedded since it might be of interesting for other 
> > 8xx users)
> > 
> 
> Apply this patch to glibc, and recompile:
> 
> rm -f glibc/sysdeps/powerpc/powerpc32/memset.S
> 
> 
> The PPC32 dbcz semantics don't seem to work properly on 8xx
> in all cases. Removing the '.S' file makes glibc fall back on
> the .c implementation. 

Hi Jason, 

That was a quick response - thanks.

Two questions:

- Do you happen to know about details of dcbz's (mis)behaviour on 8xx? 

I ask that mainly because I worry about in-kernel dcbz users.

- Shouldnt upstream glibc have that fixed for 8xx by now?
