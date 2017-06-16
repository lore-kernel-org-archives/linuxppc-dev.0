Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpgbZ5Ct3zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 10:04:42 +1000 (AEST)
Message-ID: <1497571456.2897.86.camel@kernel.crashing.org>
Subject: Re: [Oops][next-20170614][] powerpc boot fails with WARNING: CPU:
 12 PID: 0 at mm/memblock.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Rowand, Frank" <Frank.Rowand@sony.com>, Abdul Haleem
 <abdhalee@linux.vnet.ibm.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, linux-kernel <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 16 Jun 2017 10:04:16 +1000
In-Reply-To: <ED290C750E1B324E972B0017C9D4BAB02E5A7EAF@USCULXMSG03.am.sony.com>
References: <1497506437.15415.60.camel@abdul.in.ibm.com>
 <1497518696.15415.68.camel@abdul.in.ibm.com>
 <ED290C750E1B324E972B0017C9D4BAB02E5A7EAF@USCULXMSG03.am.sony.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-15 at 17:06 +0000, Rowand, Frank wrote:
> On Thursday, June 15, 2017 2:25 AM, Abdul Haleem [mailto:abdhalee@linux.vnet.ibm.com]  wrote:
> > 
> > On Thu, 2017-06-15 at 11:30 +0530, Abdul Haleem wrote:
> > > Hi,
> > > 
> > > linux-next fails to boot on powerpc Bare-metal with these warnings.
> > > 
> > > machine booted fine on next-20170613
> > 
> > Thanks Michael, Yes it is (75fe04e59 of: remove *phandle properties from
> > expanded device tree)
> > 
> > Frank, would you please take a look at the trace.
> > 
> > Thanks
> 
> < snip >
> 
> My patch series 'of: remove *phandle properties from expanded device tree'
> in -next seems to have broken boot for a significant number of powerpc
> systems.  I am actively working on understanding and fixing the problem.

I think kexec needs them in sysfs (or /proc) when building the fdt
for the target kernel.

Cheers,
Ben.
