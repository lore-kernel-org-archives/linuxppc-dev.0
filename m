Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 88A38DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 08:57:31 +1000 (EST)
Message-ID: <46AE6D24.1030801@mvista.com>
Date: Mon, 30 Jul 2007 15:58:44 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 2/2] powerpc: MPC85xx EDAC device driver
References: <20070726222225.GB10427@blade.az.mvista.com>
	<200707302046.10010.arnd@arndb.de> <46AE3C06.5060100@mvista.com>
	<200707302158.16530.arnd@arndb.de> <46AE4764.7020101@mvista.com>
	<20070730214404.GE4884@austin.ibm.com>
In-Reply-To: <20070730214404.GE4884@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	norsk5@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> On Mon, Jul 30, 2007 at 01:17:40PM -0700, Dave Jiang wrote:
>> Arnd Bergmann wrote:
>>> The best solution may be to look at how it's structured at the
>>> register level. If the PCI EDAC registers are implemented separately
>>> from the regular PCI registers, a device tree entry would be appropriate.
>>> If not, your idea of registering a platform_device from fsl_add_bridge
>>> is probably more sensible.
>>>
>> We can probably do either. From looking at the 8560 and 8548 manuals, the PCI
>> error registers are 0xe00 offset of the start of PCI registers. For example,
>> the PCI registers would start at 0x8000 offset. And the PCI error registers
>> would be at 0xe00 offset from there and would be the very last block of
>> registers. 
> 
> Anywhere I can easily get an overview of these "PCI error registers"?

http://www.freescale.com/files/32bit/doc/ref_manual/MPC8548ERM.pdf?fsrch=1
Page 966. Section 16.3.1.4.
Is this what you mean?
