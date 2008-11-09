Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2FECCDDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Nov 2008 14:26:54 +1100 (EST)
Message-ID: <4916587C.3010108@billgatliff.com>
Date: Sat, 08 Nov 2008 21:26:52 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: Using DMA
References: <OF36982726.7A11F196-ON882574FA.00798551-882574FA.0079F330@selinc.com>
	<4914C0FB.60101@freescale.com>
In-Reply-To: <4914C0FB.60101@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: timur.tabi@gmail.com, Bruce_Leonard@selinc.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Bruce_Leonard@selinc.com wrote:
> 
>> So it sounds like the async dma is the way to go, since I want to off load 
>> as much as possible from the core.  As you say, though, it's new and not 
>> in LDD3.  Is .../drivers/dma/dmaengine.c what everyone is refering to as 
>> async dma?
> 
> Yes.
> 
>>  If not, what is?  And what in the kernel is already using it
>> so I can look at some example code.
> 
> There's some network stuff that uses it for optimization.  If CONFIG_NET_DMA is
> enabled, that will turn on some kind of TCP/IP offloading.  I don't really know
> much about that.  There's also a dmatest.c testing driver.

I think some md (RAID) stuff uses it, too.

> It would definitely be nice to see a third client driver.

Why stop at three?  :)


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
