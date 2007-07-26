Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9AF9DDDECA
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 03:31:28 +1000 (EST)
Date: Thu, 26 Jul 2007 21:21:18 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] [POWERPC] MPC8349E-mITX: use platform IDE driver
	for CF	interface
Message-ID: <20070726212118.7fe7abd3@localhost.localdomain>
In-Reply-To: <46A79AA1.3030608@freescale.com>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<20070725165326.5331.19920.stgit@localhost.localdomain>
	<46A78322.3080607@ru.mvista.com> <46A78E3F.1030904@ru.mvista.com>
	<20070725180145.GA29689@ld0162-tx32.am.freescale.net>
	<46A7968D.3070707@ru.mvista.com> <46A79AA1.3030608@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 25 Jul 2007 13:46:57 -0500
Scott Wood wrote:

> Sergei Shtylyov wrote:
> >    I acn undertand your complaint in the context of an OF driver
> > (which we don't have yet) but "mmio-ide" just means nothing to the
> > current driver, and it doesn't convery enough info on the
> > programming interface for the conceivable OF driver, it also does
> > need to know at least "reg-stride" (and maybe "reg-size" in case
> > only 16/32-bit accesses can be used).  Well, if such driver will be
> > written, I/O mapping support will probably be dropped from it, so
> > indeed, calling it mmio-ide.c would make sense.  But that can be
> > added when this driver is done, and for now 
> 
> I don't think the details of what Linux code currently exists should 
> drive the device tree binding.  That the current patches use 
> platform_device glue code is an implementation detail (and one I'd 
> rather see go away, in favor of a driver that supports both 
> platform_device and of_device).
> 
> > I'd really prefer the board name to appear in the "compatible" prop
> > (to which "mmio-ide" can be appended)...
> 
> Sure, that's always good...  it was the "instead" that I objected to.
> 

Hmmm. So what is finally suggested devicetree node for this beast - can somebody refine?

I am a little bit confused about decided device_type and compatible fields...

-- 
Sincerely, Vitaly
