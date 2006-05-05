Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (71-214-132-244.roch.qwest.net
	[71.214.132.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2945B679E6
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 May 2006 06:59:01 +1000 (EST)
Subject: Re: Calculating virtual address from physical address
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20060505132441.B30563@cox.net>
References: <445B6A80.2090202@ics-ltd.com> <445BA736.30208@246tNt.com>
	<20060505132441.B30563@cox.net>
Content-Type: text/plain
Date: Fri, 05 May 2006 15:58:52 -0500
Message-Id: <1146862732.2660.1.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: Sylvain Munaut <tnt@246tNt.com>, Chris Dumoulin <cdumoulin@ics-ltd.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2006-05-05 at 13:24 -0700, Matt Porter wrote:
> 
> There are no BATs on 4xx. However, the same conceptual thing can be
> done by wiring a fixed TLB entry to cover those LEDs temporarily
> during bringup debug.  The temporary TLB entry will be wiped out by
> normal tlb misses after things are running whenever the fixed entry
> is clobbered by the round robin replacement.

At which point you should be able to call ioremap to generate a virtual
address inside a device driver or board file.

josh
