Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36B0CDDEDD
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 04:47:06 +1000 (EST)
Message-ID: <46A79AA1.3030608@freescale.com>
Date: Wed, 25 Jul 2007 13:46:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] [POWERPC] MPC8349E-mITX: use platform IDE driver
	for CF	interface
References: <20070725165318.5331.23795.stgit@localhost.localdomain>
	<20070725165326.5331.19920.stgit@localhost.localdomain>
	<46A78322.3080607@ru.mvista.com> <46A78E3F.1030904@ru.mvista.com>
	<20070725180145.GA29689@ld0162-tx32.am.freescale.net>
	<46A7968D.3070707@ru.mvista.com>
In-Reply-To: <46A7968D.3070707@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:
>    I acn undertand your complaint in the context of an OF driver (which 
> we don't have yet) but "mmio-ide" just means nothing to the current 
> driver, and it doesn't convery enough info on the programming interface 
> for the conceivable OF driver, it also does need to know at least 
> "reg-stride" (and maybe "reg-size" in case only 16/32-bit accesses can 
> be used).  Well, if such driver will be written, I/O mapping support 
> will probably be dropped from it, so indeed, calling it mmio-ide.c would 
> make sense.  But that can be added when this driver is done, and for now 

I don't think the details of what Linux code currently exists should 
drive the device tree binding.  That the current patches use 
platform_device glue code is an implementation detail (and one I'd 
rather see go away, in favor of a driver that supports both 
platform_device and of_device).

> I'd really prefer the board name to appear in the "compatible" prop (to 
> which "mmio-ide" can be appended)...

Sure, that's always good...  it was the "instead" that I objected to.

-Scott
