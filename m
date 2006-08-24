Return-Path: <bwarren@qstreams.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id 123C167D79
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 04:43:15 +1000 (EST)
Subject: Re: Platform device style question
From: Ben Warren <bwarren@qstreams.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20060824220625.515d9b3c@vitb.ru.mvista.com>
References: <1156441997.17977.44.camel@saruman.qstreams.net>
	<20060824220625.515d9b3c@vitb.ru.mvista.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 14:43:12 -0400
Message-Id: <1156444992.17977.66.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Vitaly,

On Thu, 2006-08-24 at 22:06 +0400, Vitaly Bordug wrote:

> I'd suggest to make a look at LDD concerning linux device model...
Thanks.  I'll read it again.  My little brain absorbs this stuff very
slowly.
> For platform device, there's no need to cope with u-boot at all. You'll prolly need to 
> register the respective platform device from the board-specific code, with proper name 
> and driver's board-specific platform info. You may have a look at arch/ppc/syslib/ppc_sys.c about static
> PD definitions usage.

My particular platform (MPC8349) gets its hardware info (CPU, IMMBAR,
PCI, I2C, SPI resources etc.) from an OF device tree that is generated
alongside U-boot and I guess embedded in the uImage file.  (I apologize
if I'm getting my jargon mixed up here)  The OF device tree idea seemed
like a slick way to abstract away some HW settings from Linux.  I was
imagining writing board-side platform device registration that gets its
settings from the device tree, allowing a bit of re-use between similar
but not identical boards.
> 

> I'd make sense to figure out the platform device bus before digging into device trees. It's slightly 
> different stuff, for similar aim, but anyway... Actually you do not strictly need devtree to cope with 
> your case afaiu.

I definitely have much learning to do.  Thanks very much for the
pointers!

regards,
Ben
