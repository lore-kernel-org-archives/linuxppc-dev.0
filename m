Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 123B467C09
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 20:47:50 +1100 (EST)
Date: Fri, 3 Nov 2006 10:47:45 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 13/16] powerpc: make prom_init.o dependent on PPC_OF
Message-ID: <20061103094745.GE22478@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125629.335003000@localhost.localdomain>
	<1162506853.10630.55.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1162506853.10630.55.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 03, 2006 at 09:34:13AM +1100, Benjamin Herrenschmidt wrote:
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Note that CONFIG_PPC_OF is always set in arch/powerpc since that
> includes support for the flat device-tree... We might want to keep a
> separate option for prom_init.c, though I'm not too big about it right
> now. Maybe CONFIG_PPC_BOOT_FROM_OF :) That would allow custom kernel to
> be shrunk down if they don't need to support platforms that are known
> not to have a real OF (iSeries for example).
> 

I don't know yet where the exact boarders are in the code between real
OF and flat device tree. Maybe I can look at it once I have a proper
device tree for my board.
Out of curiosity I just disabled CONFIG_PPC_OF. There were two undefined
references to functions I didn't need at the moment. After commenting
them out the kernel compiled and booted. It saved me ~10k kernelsize,
but ok, I thought I would still have flat tree support.

Sascha

-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
