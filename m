Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3F271DDF1C
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 04:03:35 +1100 (EST)
Message-ID: <494930D8.4050505@freescale.com>
Date: Wed, 17 Dec 2008 11:03:20 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/5] powerpc/83xx: Add USB Host/Gadget support for
	MPC8360E-MDS boards
References: <20081203192644.GA6145@oksana.dev.rtsoft.ru>
	<20081203192743.GC13035@oksana.dev.rtsoft.ru>
	<8CFD0641-F9CD-4961-A1B3-C702E8E5DFB7@kernel.crashing.org>
In-Reply-To: <8CFD0641-F9CD-4961-A1B3-C702E8E5DFB7@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> Of these are they all in the kernel tree already?  What I mean is QE  
> usb bindings in linus's tree?  I know GTM timers is and this patch  
> series had the bcsr gpio.  Similar question for qe par io.  I think we  
> are good but clearly I leave much of QE to you & timur.

These QE GPIO and USB patches have been floating around so long, that I think
it's important to get them in so that the functionality is available.  I
reviewed them a while go and gave them my thumbs up, and I trust Anton, so I'm
sure these latest patches are OK.

-- 
Timur Tabi
Linux kernel developer at Freescale
