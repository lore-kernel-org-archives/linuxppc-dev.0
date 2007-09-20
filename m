Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0C7CDDEFF
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 03:03:13 +1000 (EST)
Message-ID: <46F2A7CC.1040106@freescale.com>
Date: Thu, 20 Sep 2007 12:03:08 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] [POWERPC] Fix QEIC->MPIC cascading
References: <20070920130244.GA18043@localhost.localdomain>
In-Reply-To: <20070920130244.GA18043@localhost.localdomain>
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
> set_irq_chained_handler overwrites MPIC's handle_irq function
> (handle_fasteoi_irq) thus MPIC never gets eoi event from the
> cascaded IRQ. This situation hangs MPIC on MPC8568E.

I'm not familiar with the differences between IPIC and MPIC.  What is this 
patch not needed for 83xx?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
