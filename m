Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B0CADE055
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 07:45:05 +1000 (EST)
Message-ID: <481B8B89.2030703@freescale.com>
Date: Fri, 02 May 2008 16:45:45 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions and
	-Os
References: <F62A680D-C2D8-42B0-B4D6-F3A00F228EB1@kernel.crashing.org>	<03e9cbca081bff8f6db9862bf3d8d028@kernel.crashing.org>	<BFB7B7A0-6EA9-467D-B23E-B0D46EF6BA54@kernel.crashing.org>
	<20080502.144220.53637856.davem@davemloft.net>
In-Reply-To: <20080502.144220.53637856.davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller wrote:
> If you link in libgcc, all of a sudden you have a whole new class of
> potential problems, don't do it.
> 
> All it takes is one of these libgcc libcalls the kernel actually
> references, needing something else in libc, to make this exercise
> futile.

What in libgcc references libc, and why isn't this a problem for 
Linux/ARM, Linux/SH, U-boot, and the many other libc-less programs that 
use libgcc?

-Scott
