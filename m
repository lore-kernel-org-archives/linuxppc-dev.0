Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id B58792BF0C
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Nov 2004 06:08:08 +1100 (EST)
Date: Thu, 4 Nov 2004 12:08:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Message-ID: <20041104190805.GF13456@smtp.west.cox.net>
References: <1093602389.1862.54.camel@localhost>
	<20040827221204.GB30360@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040827221204.GB30360@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [PATCH,RFC] PPC32 Machine Check Handling
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 27, 2004 at 03:12:04PM -0700, Tom Rini wrote:
> On Fri, Aug 27, 2004 at 11:26:29AM +0100, Adrian Cox wrote:
> > The attached patch rearranges PPC32 machine check handling in order to
> > test for internal CPU failures before signalling user processes. This
> > makes the behaviour match that of i386.
> >
> > The patch currently only changes behaviour for 6xx processors. It does
> > not enable any extra causes of machine check, but it will turn internal
> > CPU faults into kernel panics rather than signals.
> >
> > The PowerMac and Qspan specific code is moved into platform files. There
> > don't seem to be any boards in the tree that actually use Qspan PCI. I'd
> > like to hear test reports for PowerMac machines that take machine checks
> > on I/O faults.
> >
> > Paul, Tom: This isn't the finished version, but is there any chance of
> > something like this going mainstream?  The current behaviour makes it
> > very hard to separate chip failures and cooling problems from
> > application bugs.
> 
> This seems like a fine idea to me.

This get cleaned up anymore, etc?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
