Return-Path: <tnt@246tNt.com>
Received: from outmx009.isp.belgacom.be (outmx009.isp.belgacom.be
	[195.238.3.4]) by ozlabs.org (Postfix) with ESMTP id BB9FB2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Jan 2005 03:47:26 +1100 (EST)
Received: from outmx009.isp.belgacom.be (localhost [127.0.0.1])
	by outmx009.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j03GlCr1006197
	for <linuxppc-embedded@ozlabs.org>; Mon, 3 Jan 2005 17:47:13 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <41D97734.3070800@246tNt.com>
Date: Mon, 03 Jan 2005 17:47:48 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Mark Chambers <markc@mail.com>
References: <200412301246.48870.david.jander@protonic.nl>	<C6D7331E-5A77-11D9-AECD-003065F9B7DC@embeddededge.com>
	<061001c4eeaf$0b5e1860$0301a8c0@chuck2>
	<41D7269E.1070906@246tNt.com>
	<003c01c4f19d$98a16510$0301a8c0@chuck2>
In-Reply-To: <003c01c4f19d$98a16510$0301a8c0@chuck2>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 PCI byte-swapping
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>Thanks.  I had an older manual that didn't spell it out so
>clearly.
>
>I've been trying to interpret the PCI sections for some other
>82xx family parts, and it appears that they do NOT do this
>byte lane swapping, so this make the 5200 non-standard in
>this regard, which is unfortunate.  If I'm understanding this
>right, one would have to have different drivers for a PCI
>device on a 5200 and an 8270, for instance.
>  
>
Mmmm ...
Still I use the intel eepro driver without problems or modifications.
As long as the driver uses the proper readl/writel that should do
it or am I mistaken ?

I have a FPGA mounted with pci interface, I'll try to see what happens on
the bus

>Also, I note that when doing simple block reads from pre-
>fetchable PCI space, it appears the 5200 does not prefetch,
>but does each read individually.  This is using stock ELDK
>u-boot and 2.4.24 so I haven't yet determined if it's a
>configuration matter, (or ruled out target disconnects)
>but I'm suspecting that you can't get burst mode from the 
>5200 without using DMA.
>  
>
Last time I checked, the 2.4 from denx didn't create a pci
window for prefetchable memory so prefetch mem zone
were mapped as non-prefetchable, so no burst for sure.



Sylvain
