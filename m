Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A9FB2DDE2C
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 10:16:24 +1100 (EST)
Message-ID: <47AA3FC0.4000602@freescale.com>
Date: Wed, 06 Feb 2008 17:16:16 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: drivers/char/hvc_* and /Documentation/powerpc/hvcs.txt
References: <479A651F.2070109@freescale.com> <20080126010409.GA25717@lixom.net>
In-Reply-To: <20080126010409.GA25717@lixom.net>
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

Olof Johansson wrote:

> Yep, pretty much. It's real easy to write a new backend to hvc, I've got
> a couple for various bringup environments here as well.

Could you tell me which kernel options I need to set/unset in order to get my 
driver to be called?  My driver loads and initializes, but its put_char function 
is never called.  Trying to debug to the console subsystem is making me dizzy.

-- 
Timur Tabi
Linux kernel developer at Freescale
