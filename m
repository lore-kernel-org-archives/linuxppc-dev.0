Return-Path: <dhlii@comcast.net>
Received: from sccrmhc13.comcast.net (unknown [63.240.77.83])
	by ozlabs.org (Postfix) with ESMTP id 547886884B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 13:08:53 +1100 (EST)
Message-ID: <438D0878.30503@comcast.net>
Date: Tue, 29 Nov 2005 21:03:36 -0500
From: "David H. Lynch Jr" <dhlii@comcast.net>
MIME-Version: 1.0
To: T Ziomek <ctz001@email.mot.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <20051125214126.15F9E6884D@ozlabs.org>
	<Pine.WNT.4.61.0511291821320.3620@holyoke.labs.mot.com>
In-Reply-To: <Pine.WNT.4.61.0511291821320.3620@holyoke.labs.mot.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: Is there some articles discussing how to change bare-board code
 to linux driver?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Where can I find the ./drivers/net/xilinx_enet, ... etc files.
I can not find them in the 2.6.14.2 tree

T Ziomek wrote:
>>    Where can i find them?thanks.
>
> In addition to LDD3 (for 2.6 kernels, or the freely available LDD2 for 
> 2.4 kernels), you might want to look at some existing Linux drivers 
> that are
> based on "bare metal" / "no OS" drivers.  The ones I know of are for 
> Xilinx
> peripherals, for example (within the Linux kernel tree),
> - ./drivers/net/xilinx_enet
> - ./drivers/char/xilinx_uartlite
> - ./drivers/char/xilinx_gpio
>
> Tom
