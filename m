Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 31D62DDE0F
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 08:15:41 +1100 (EST)
Message-ID: <476989ED.50603@freescale.com>
Date: Wed, 19 Dec 2007 15:15:25 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 4/4] [POWERPC] fsl_spi_init and users: stop using
	device_type = "spi"
References: <20071219203447.GA18285@localhost.localdomain>
	<20071219203817.GD20861@localhost.localdomain>
	<47698773.1010004@freescale.com>
	<20071219211250.GA21416@localhost.localdomain>
In-Reply-To: <20071219211250.GA21416@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> I though about it. Is your device tree source out of tree? Otherwise
> it should be trivial to upgrade the dtb, instead of producing cruft in
> the kernel. I vote for less legacy code, but lets see what others will
> say. So far count is 1:1. ;-)

I just want a transition period.  Whenever I write code that works with changes 
in the device tree, I always maintain compatibility with the older versions, and 
I was under the impression that this is policy.  If you update the device tree, 
you should update the kernel.  The converse, however, should not be true.

It would be really annoying if you had to swap out your device tree if you want 
to work with different kernel versions.

Maybe if the device tree compiler were part of the kernel, and every time you 
built the kernel it also built the dtb, I could accept locking the device tree 
and kernel versions.

-- 
Timur Tabi
Linux kernel developer at Freescale
