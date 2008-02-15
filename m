Return-Path: <pkiryukhin@ru.mvista.com>
Received: from smtp02.mtu.ru (smtp02.mtu.ru [62.5.255.49])
	by ozlabs.org (Postfix) with ESMTP id D0003DDF55
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 04:39:20 +1100 (EST)
Message-ID: <47B5CEAF.8030705@ru.mvista.com>
Date: Fri, 15 Feb 2008 20:41:03 +0300
From: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
MIME-Version: 1.0
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] booting-without-of: add Xilinx uart 16550.
References: <47B59631.10908@ru.mvista.com>
	<20080215170844.9D21610081@mail40-dub.bigfish.com>
In-Reply-To: <20080215170844.9D21610081@mail40-dub.bigfish.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Neuendorffer wrote:
>> +       - reg-shift : registers offset shift (standard uart_port
> field).
>> +         Property is optional if regshift is zero.
> 
> I was hoping to get an idea of what is required here, or when I might
> use it?
> 
> It looks like the ARCH=ppc code instantiates this with a reg-shift of
> 2...  Is this the expected value?  

Yes, reg-shift = 2 should be set for Xilinx 16550 uart. 
Should I add this to patch?

BTW regshift=2 is hardcoded for uartlite.

> When would it be not zero? or not
> two?
Sorry, it seems I don't follow here. 
--
Regards,
Pavel
