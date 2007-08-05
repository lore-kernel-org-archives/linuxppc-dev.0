Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 00803DDDFB
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Aug 2007 17:55:10 +1000 (EST)
Message-ID: <46B5824B.1000103@s5r6.in-berlin.de>
Date: Sun, 05 Aug 2007 09:54:51 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2.6.22.y] ieee1394: revert "sbp2: enforce 32bit
	DMA	mapping"
References: <fa.Qn3Snqoik3hhnxcA6HqjGV0Yzck@ifi.uio.no>	
	<46B4B3DC.7020609@shaw.ca> <46B4B7C6.1040107@s5r6.in-berlin.de>
	<1186272926.938.8.camel@localhost.localdomain>
In-Reply-To: <1186272926.938.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Robert Hancock <hancockr@shaw.ca>, linuxppc-dev@ozlabs.org,
	stable@kernel.org, linux-kernel@vger.kernel.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>>> If setting 32-bit DMA mask fails on ppc64, that sounds like a problem
>>> with the DMA implementation on that architecture. There are enough cards
>>> out there that only support 32-bit DMA that this really needs to work..
>> Yes, could the PPC folks please have a look at it?  Thanks.
> 
> Smells like we may have a bug there. No worries though, all current PPC
> machines have an iommu that will not give out addresses above 32 bits
> anyway, but I'll double check what's up.
> 
> Do you see something in dmesg when that happens ?

There was nothing in Olaf's report, except for trouble in sbp2 _after_
the failure.  http://lkml.org/lkml/2007/8/1/344  (I don't have a PMac.)
-- 
Stefan Richter
-=====-=-=== =--- --=-=
http://arcgraph.de/sr/
