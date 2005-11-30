Return-Path: <ctz001@email.mot.com>
Received: from motgate7.mot.com (motgate7.mot.com [129.188.136.7])
	by ozlabs.org (Postfix) with ESMTP id AAAAE68820
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 11:35:32 +1100 (EST)
Date: Tue, 29 Nov 2005 18:35:11 -0600 (Central Standard Time)
From: T Ziomek <ctz001@email.mot.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20051125214126.15F9E6884D@ozlabs.org>
Message-ID: <Pine.WNT.4.61.0511291821320.3620@holyoke.labs.mot.com>
References: <20051125214126.15F9E6884D@ozlabs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: re: Is there some articles discussing how to change bare-board code
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

>    Where can i find them?thanks.

In addition to LDD3 (for 2.6 kernels, or the freely available LDD2 for 2.4 
kernels), you might want to look at some existing Linux drivers that are
based on "bare metal" / "no OS" drivers.  The ones I know of are for Xilinx
peripherals, for example (within the Linux kernel tree),
- ./drivers/net/xilinx_enet
- ./drivers/char/xilinx_uartlite
- ./drivers/char/xilinx_gpio

Tom
-- 
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
