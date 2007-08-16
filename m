Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D6977DDE49
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Aug 2007 07:43:19 +1000 (EST)
Message-ID: <46C4C4E6.9070406@freescale.com>
Date: Thu, 16 Aug 2007 16:43:02 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: robert lazarski <robertlazarski@gmail.com>
Subject: Re: external IRQ's
References: <f87675ee0708160751u14f96dbcs3ad35a147b70a3f3@mail.gmail.com>	<46C47A1D.5030303@freescale.com>
	<f87675ee0708161434i9f38b0dg123a767822cf7402@mail.gmail.com>
In-Reply-To: <f87675ee0708161434i9f38b0dg123a767822cf7402@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

robert lazarski wrote:
> Why <1d 2 1e 2 22 2> ? I can't seem to parse these numbers

They alternate between IRQ numbers and level/sense information, and the 
IRQ numbers are the internal IRQ number plus 16.

> - how do I
> know what to use for my external interupts 1,2 for phy's 0,1 using a
> 88E1121R and for external interupts 3,4 for phy's 2,3 using a 88E1111
> ?

I thought it was interrupts 0-3, not 1-4?

If, like the CDS board, you have level-triggered active-low phy 
interrupts, then <0 1>, <1 1>, <2 1>, and <3 1>.  If not, then choose an 
appropriate value for the second cell based on booting-without-of.txt.

-Scott
