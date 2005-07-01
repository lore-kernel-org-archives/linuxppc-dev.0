Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CBE567BAD
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Jul 2005 00:03:07 +1000 (EST)
In-Reply-To: <42C4F50D.3050405@anagramm.de>
References: <42C40BD0.8040408@anagramm.de>
	<658739DB-540F-4AFC-80DC-BBF0C2AD70F4@freescale.com>
	<42C4162E.4030602@anagramm.de>
	<427c70958bb995dad4fbad2e6ff121bc@embeddededge.com>
	<42C4F50D.3050405@anagramm.de>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d946affc11510f7116710026d2a8d1f3@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 1 Jul 2005 10:02:54 -0400
To: Clemens Koller <clemens.koller@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC85xx DMA support for Kernel 2.6?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 1, 2005, at 3:47 AM, Clemens Koller wrote:

> .... And currently, when I access (memcopy) the SRAM on my
> Local Bus via UPM I cannot get it to generate bursts yet, so I hope the
> DMA will speed up those things, too.

If the CPU won't do it, the DMA won't either.  You better get that
UPM working first :-)


	-- Dan
