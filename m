Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 88288DE0AA
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Feb 2008 01:58:37 +1100 (EST)
Message-ID: <47A32CB4.6010309@ru.mvista.com>
Date: Fri, 01 Feb 2008 17:29:08 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Marco Stornelli <marco.stornelli@coritel.it>
Subject: Re: External Interrupt
References: <47A2D424.3090903@coritel.it>
In-Reply-To: <47A2D424.3090903@coritel.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linuxppc Embedded Mailing List <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

Marco Stornelli wrote:

> I used the linux kernel 2.6.10 with a processor MPC8548E. I wrote a
> driver for a device connected with the local bus. This device has an
> external interrupt. In the local bus driver I have used the macro
> MPC85xx_IRQ_EXT<X> to get the interrupt number and pass it to the
> driver and after that register the ISR. Now with a kernel 2.6.21 this
> macro isn't available because in the header file irq.h there is the
> option CONFIG_PPC_MERGE that disable those options. I think this
> problem is related to the migration of ppc code towards powerpc. I
> know that now there is the new device tree source file where I can add
> a device and its interrupt number  but I think in this file I should
> describe only the platform device, and this device is not a platform
> device.

    How comes that it's not platform device if it hangs off the local bus?

> Then, how can I get now this  value? Is there some function to
> call? How can I perform this operation?

    Probably irq_alloc_virt()...

WBR, Sergei
