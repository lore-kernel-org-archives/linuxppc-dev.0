Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93E77DDE20
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 10:49:23 +1100 (EST)
Date: Sat, 10 Nov 2007 02:48:13 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: On-going 4xx porting
Message-ID: <20071110024813.5cada553@kernel.crashing.org>
In-Reply-To: <1194645701.3207.17.camel@localhost.localdomain>
References: <1194645701.3207.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 09 Nov 2007 16:01:41 -0600
Josh Boyer wrote:

> Hi All,
> 
> For those interested, I have a few things I'd like to focus on for
> 2.6.25 in regards to the current arch/powerpc 4xx porting effort.
> Below is a brief list of drivers in no particular order:
> 
> PCI support
I'll look at that stuff once again. maybe it worths to head fir compromise solution in favor of replacing 32/64 
ranges parsing func + a bunch of other things in one single step.

> USB (440EP(x), etc)
looks like we have code ready for that...

> I2C
Stefan's approach seems pretty close

> GPIO
> NDFC
I'd rather follow platform device wrapper way.. Big NDFC of_device rework can be done anytime later.

> RTC
> 
> I'd also like to try and get the larger page size patches ported and
> merged.  If another hugetlbfs type patch shows up, that would be good
> too.  There is also the HW watchpoint support patch, and of course new
> board ports.
> 
> At some point we should really be able to have a single vmlinux be
> wrapped with different zImage wrappers and .dts files and have it boot
> on those various boards just fine.  So I'll be looking at
> accomplishing that as well.  That should make new board ports fairly
> easy to do.
> 

just my $0.02...

> josh
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


-- 
Sincerely, Vitaly
