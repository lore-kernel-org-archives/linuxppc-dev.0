Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id EA5E2DE032
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jun 2007 16:35:15 +1000 (EST)
Date: Fri, 1 Jun 2007 08:35:07 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Daniel Schnell <daniel.schnell@marel.com>
Subject: Re: Where is initial console initialized ?
Message-ID: <20070601063507.GA23294@moe.telargo.com>
References: <DD39B5C3F4963040ADC9768BE7E430CB01F550A7@is-hdq-exchange.marel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01F550A7@is-hdq-exchange.marel.net>
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

On 31/05/07 13:42 -0000, Daniel Schnell wrote:
> Hi,
>  
> I am trying to bring up 2.6.20.3 on a MPC5200B based custom board. This
> Kernel is based on the Phytec phyCore MPC5200B Mini BSP kernel and
> adapted to my board.
> So far I have troubles to get console output working when booting Linux.
> Uboot console output is fine. Linux begins to run (I can set breakpoints
> with the BDI2000 in the early initialization code) so I probably have a
> misconfiguration of the console output inside the fdt.
> 
> The major difference between the Phytec phyCore 5200B mini fdt and mine
> is that we use PSC1 instead of PSC3/6 for serial. Accordingly I changed
> the fdt (or dts) values.
> 
> To get some more insights, I would like to know, in which Linux function
> the console output is initialised ?
> 
> 
...
> If I dump the flat device tree inside uboot, I get the following
> entries: 
...
the dump with:

         reg = <8>;

in most of nodes, which looks just wrong.


	Domen
