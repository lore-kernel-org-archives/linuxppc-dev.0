Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF0B568660
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2005 08:49:36 +1100 (EST)
Date: Tue, 1 Nov 2005 14:33:12 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20051101163312.GB5095@logos.cnet>
References: <20051026133648.GA10373@logos.cnet>
	<20051026220205.GH26475@smtp.west.cox.net>
	<20051028085224.GA17520@logos.cnet>
	<20051028161054.GB22245@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051028161054.GB22245@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Makefile check for older binutils broken?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Yep, that does the trick. Is it good now?
> 
> Er, that's odd.  I was using writing parens, not shell parens :)   Can
> you test the failure case here by changing dssall to garbage?  Also,
> that's not a clean patch, but vs your last one that wasn't valid.

Problem is specific to invocation of "make" inside a (particular) Makefile.

Again, sorry for you wasting your time.
