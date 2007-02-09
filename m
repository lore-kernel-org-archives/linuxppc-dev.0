Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 21AE5DDE2C
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 09:51:09 +1100 (EST)
Message-ID: <45CCFAD6.5070807@freescale.com>
Date: Fri, 09 Feb 2007 16:51:02 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Discussion about iopa()
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
	<1170969965.2620.345.camel@localhost.localdomain>
	<0640B069-F05E-4A08-A8EB-C277BEF1466E@embeddedalley.com>
	<1171058780.6578.4.camel@localhost.localdomain>
	<1EFFAE36-7396-45B5-B8F2-DD7348FBE385@kernel.crashing.org>
In-Reply-To: <1EFFAE36-7396-45B5-B8F2-DD7348FBE385@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> My feeling is to leave the code alone until we have the dma mapping api 
> setup to handle MURAM.  If we can't do alloc/map/free with the same 
> mechanism I dont see the value in just doing 'map'.  It just makes the 
> code more confusing w/o any big gain.

So you don't want to see a patch where we store the physical address in our own 
data structures when the memory is mapped (or allocated if it's regular RAM)?



-- 
Timur Tabi
Linux Kernel Developer @ Freescale
