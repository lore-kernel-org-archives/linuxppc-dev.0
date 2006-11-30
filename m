Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id CE8B767B92
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Dec 2006 07:26:41 +1100 (EST)
Message-ID: <456F3E74.9070405@freescale.com>
Date: Thu, 30 Nov 2006 14:26:28 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Leonid <Leonid@a-k-a.net>
Subject: Re: 2 PCI devices behind PCI bridge on Yosemite board.
References: <406A31B117F2734987636D6CCC93EE3C99D709@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C99D709@ehost011-3.exch011.intermedia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Balajee Premraj <balajee@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Leonid wrote:
> On Dreamchip board itself I couldn't find how to mask the interrupt, but
> I'll search more. Can you recommend example for "real" IRQ handler for
> Dreamchip? I just don't what the system crash.

The IRQ handler must clear whatever event triggered the interrupt.

> BTW, what will happen if
> Dreamchip and Silicon Image will assert interrupt simultaneously?

Nothing special.  Both handlers run every time either device interrupts; 
if they both have events pending, then both handlers handle them.

-Scott
