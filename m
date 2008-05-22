Return-Path: <suvidh.kankariya@ntigo.com>
Received: from nti1.com (unknown [65.243.248.10])
	by ozlabs.org (Postfix) with ESMTP id 08084DE270
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 06:49:51 +1000 (EST)
Received: from [65.243.248.64] (host64.networktechinc.com [65.243.248.64] (may
	be forged)) by nti1.com (8.14.1/8.14.1) with ESMTP id m4MKeEuB006337
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 16:40:17 -0400 (EDT)
Message-ID: <4835DA6E.2020709@ntigo.com>
Date: Thu, 22 May 2008 16:41:18 -0400
From: Suvidh Kankariya <suvidh.kankariya@ntigo.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: adding external interrupt support for MPC8313e bsp
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
I have mpc8313e local bus connected to a external UART. and the 
interrupt is connected to EXT_INT2.
I am able to communicate to UART if I disable IRQ i.e IRQ = 0 in port 
structure.

I am not able to understand how to tell kernel to use external IRQ -2.
Should I put the external interrupts in device tree and if so how?

or can I use the interrupt directly in the driver  and in that case do I 
need to map the interrupt.



Any help or pointer is highly appreciated.

Thanks in advance.


Suvidh

 
