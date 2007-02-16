Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EA189DDDE6
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 00:25:45 +1100 (EST)
In-Reply-To: <45D4C8AF.80607@freescale.com>
References: <1171408247467-git-send-email-timur@freescale.com>
	<1171411219.20192.118.camel@localhost.localdomain>
	<01b23edfa0a058ae8a119594abb51e01@kernel.crashing.org>
	<45D4C8AF.80607@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d31154b8a4b63cac9aec9a93382ef06c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add of_get_mac_address() and update fsl_soc.c to
	use it
Date: Fri, 16 Feb 2007 14:25:38 +0100
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> There are trees in the kernel today that have 'address' in them.  
> Before I can fix the trees, though, I need to update U-Boot and the 
> kernel to support local-mac-address *without* breaking support for 
> older trees.  That's why this patch is written the way it is.

Yes I understand.  My suggestion was to somehow recognise
those trees and only for those try the "address" thing.

Not too important in this case I guess, since almost all
correct trees will have a "local-mac-address" property,
and the correct (standard-conform) use of "address" is
pretty much obsoleted.

Since you are planning to at a later date (hopefully soon :-) )
remove this handling of "address" completely again, I'm sure I
can live with it -- objection withdrawn ;-)


Segher
