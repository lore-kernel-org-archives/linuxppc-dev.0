Return-Path: <tnt@246tNt.com>
Received: from outmx015.isp.belgacom.be (outmx015.isp.belgacom.be
	[195.238.2.87]) by ozlabs.org (Postfix) with ESMTP id E0DD72BF13
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Nov 2004 21:32:34 +1100 (EST)
Received: from outmx015.isp.belgacom.be (localhost [127.0.0.1])
	by outmx015.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id iAJAWSag023516
	for <linuxppc-embedded@ozlabs.org>; Fri, 19 Nov 2004 11:32:28 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <419DCBB4.6010201@246tNt.com>
Date: Fri, 19 Nov 2004 11:32:20 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: roger blofeld <blofeldus@yahoo.com>
References: <20041118202213.20094.qmail@web53504.mail.yahoo.com>
In-Reply-To: <20041118202213.20094.qmail@web53504.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200 FEC Driver on linux 2.6 broken? (fixed again)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

roger blofeld wrote:

>Adding a call 
>
>    flush_dcache_range((u32)skb->data, (u32)skb->data + skb->len);
>
> just before spin_lock_irq() in fec_hard_start_xmit() removes the
>remaining transmission checksum errors for me.
>-rb
>
>  
>
Mmmm.

That should not be needed.

What tree are you exactly using ?
In mainstream XLB snooping is not configured so if you have the 
mainstream + added DMA,
the problem may come from this.


    Sylvain
