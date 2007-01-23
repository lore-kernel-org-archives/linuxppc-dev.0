Return-Path: <MGalassi@c-cor.com>
Received: from ns1.c-cor.com (ns1.c-cor.com [12.17.0.130])
	by ozlabs.org (Postfix) with ESMTP id A8B30DDF3E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 05:46:36 +1100 (EST)
Message-Id: <200701231839.l0NId8x2024324@penguin.ncube.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: JTAG emulator for MPC8548E (v2) 
In-reply-to: <528646bc0701230956v26e34c5bx7d3fc082fe1d20c9@mail.gmail.com> 
References: <BD261180E6D35F4D9D32F3E44FD3D901062D1E42@EMPBEDEX.empirix.com>
	<528646bc0701230956v26e34c5bx7d3fc082fe1d20c9@mail.gmail.com>
Date: Tue, 23 Jan 2007 10:39:08 -0800
From: Michael Galassi <mgalassi@c-cor.com>
Cc: linuxppc-embedded@ozlabs.org, "Morrison, Tom" <tmorrison@empirix.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>On 1/23/07, Morrison, Tom <tmorrison@empirix.com> wrote:
>>
>> What do people recommend for a JTAG emulator for the MPC8548E
>>
>> (version 2 silicon).
>
>Check out the BDI-2000 from Abatron

The BDI has some shortcomings for *my* use (in no particular order):

1) you can't program cplds
2) the ethernet interface is slow
3) the configuration is arcane
4) using the serial port for console use is an iffy proposition at best
5) it is expensive
6) it's configuration relies on having a PC with a serial port

Note that these are shortcomings relative to using a PC with the Xilinx
USB platform cable, and working with ppc405s on Virtex4 FPGAs.  These
may not apply to the MPC8548E, or if they do, the BDI may none-the-less
be your best option.

As an aside, I believe that the term emulator is being used in error in
this context.

-michael
