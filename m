Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 38BC4DDEE0
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 08:29:14 +1100 (EST)
Subject: Re: Bad gcc-4.1.0 leads to Power4 crashes... and power5 too, actually
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061220211931.GB16860@austin.ibm.com>
References: <20061220004653.GL5506@austin.ibm.com>
	<1166579210.4963.15.camel@otta> <20061220211931.GB16860@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 08:28:54 +1100
Message-Id: <1166650134.6673.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-12-20 at 15:19 -0600, Linas Vepstas wrote:
> On Tue, Dec 19, 2006 at 07:46:50PM -0600, Peter Bergner wrote:
> > On Tue, 2006-12-19 at 18:46 -0600, Linas Vepstas wrote:
> > > Per xchat, here's the update. I'm guessing I'm using a broken
> > > compiler, as per chain of evidence below ...
> > [snip]
> > > However, I also note that the following scrolled by:
> > > init/main.c:81:2: warning: #warning gcc-4.1.0 is known to miscompile the
> > > kernel. A different compiler version is recommended.
> > 
> > It may be due to this GCC bug which Olaf ran into a while back:
> > 
> >   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=24644
> > 
> > You can verify whether you have a broken compiler by compiling
> > the minimal test case I posted in comment #15.  If you see r13
> > being copied into another register and then used, then you have
> > a broken compiler.
> 
> No, that's not it. I'd be surprised, as I was using the SuSE
> SLES10 gcc-4.1.0-28.4.ppc.rpm compiler, which would have that fix.
> 
> I'm trying to figure out how to try a different compiler,
> I'm hoping that 3.3 can still compile new kernels.
> 
> I'll try to stare at the dump a bit too, now.

I've been using 4.1.2 from debian/ubuntu happily lately.

Ben.
