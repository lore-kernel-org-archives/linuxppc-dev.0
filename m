Return-Path: <imrek@atomki.hu>
Received: from strawberry.dnsalias.org (strawberry.diszk.unideb.hu
	[193.6.143.139]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 27203DE137
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Jan 2007 00:48:31 +1100 (EST)
Received: from localhost ([127.0.0.1])
	by strawberry.dnsalias.org with esmtp (Exim 4.54) id 1HA4ig-0007wg-Q8
	for linuxppc-embedded@ozlabs.org; Thu, 25 Jan 2007 14:32:50 +0100
Date: Thu, 25 Jan 2007 14:32:50 +0100 (CET)
From: jozsef imrek <imrek@atomki.hu>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ML403 hard Ethernet under Linux 2.6.18
In-Reply-To: <45B8A64C.4050505@omnisys.se>
Message-ID: <Pine.LNX.4.61.0701251429270.30482@strawberry.dnsalias.org>
References: <45B8A64C.4050505@omnisys.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 25 Jan 2007, Magnus Hjorth wrote:

> Hi,
>
> I'm trying to get Linux 2.6.18.6 working on an ML403 board with a basic
> EDK design with a hard_temac and uart. I've generated the BSP for
> linux_2_6, copied the drivers and twiddled a little to make it all compile.
>
> The TEMAC driver seems to find the hardware, but the speed negotiation
> seems not to work. I can see the speed LEDs first go to 100 Mbit, then
> ...

i suppose you are using plb_temac 3.00, with the corresponding driver.

did you try to uncomment #define XILINX_PLB_TEMAC_3_00A_ML403_PHY_SUPPORT
in adapter.c ?


-- 
mazsi

----------------------------------------------------------------
strawberry fields forever!                       imrek@atomki.hu
----------------------------------------------------------------
