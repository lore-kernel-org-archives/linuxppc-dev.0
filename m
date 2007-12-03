Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 6A941DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Dec 2007 21:20:37 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Maximum ioremap size for ppc arch?
Date: Mon, 3 Dec 2007 11:20:22 +0100
References: <36D7B34A3A79F84F82FA0C154F299F2505FE26D2@E03MVX1-UKDY.domain1.systemhost.net>
In-Reply-To: <36D7B34A3A79F84F82FA0C154F299F2505FE26D2@E03MVX1-UKDY.domain1.systemhost.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712031120.22988.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 03 December 2007, michael.firth@bt.com wrote:
> I'm trying to get am MPC834x system running that has 256MBytes of NOR
> flash connected.
> 
> The physmap flash driver is failing to ioremap() that amount of space,
> while on a similar system with 128Mbytes of flash, there are no
> problems.
> 
> Is this a known limitation of ioremap() on the ppc architecture, or
> specifically the MPC834x family, and is there any (hopefully easy) way
> to increase this limit?

The amount of ioremap space is very limited on 32bit systems in general,
since most people are more interested in having a large physical address
space without highmem. Look at the definition of VMALLOC_START and
VMALLOC_END if you want to change the settings on your system.

	Arnd <><
