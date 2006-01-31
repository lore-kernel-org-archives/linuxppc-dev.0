Return-Path: <embeddedxilinx@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.193])
	by ozlabs.org (Postfix) with ESMTP id 77F18681BD
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Feb 2006 08:07:53 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id z6so1491859nzd
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jan 2006 13:07:51 -0800 (PST)
Message-ID: <e4619cf30601311307p598085b2g1c7b8e3583e20196@mail.gmail.com>
Date: Tue, 31 Jan 2006 14:07:51 -0700
From: David Summers <embeddedxilinx@gmail.com>
To: Frank Bennett <bennett78@digis.net>
Subject: Re: Getting started with Xilinx V4 PPC?
In-Reply-To: <43DE76DE.2080306@digis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e4619cf30601301111u269d7842j42a8ef88623cfdf8@mail.gmail.com>
	<43DE76DE.2080306@digis.net>
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

> Interesting dev board.  What is the low volume price/power consumption
> is for the Virtex-4?


The price for a Virtex 4 FX12 FPGA  (10K flip flops, 648Kb Block RAM,
1 PPC405 core, dual 10/100/1G ethernet MACs, etc)  close to $200 each.
 Expensive if all you need is a processor, but I already have a lot of
custom interface logic in the FPGA so adding a few $$ extra for the
PPC core isn't a problem.  I also have the luxury of extremely small
production volumes, so component cost is dwarfed by the cost of
development.


Power is going to depend on what you put into the FPGA and how fast
you clock it.  Xilinx quotes 0.45mW/Mhz for the PPC only.  That equals
135mW at 300 Mhz.  My design will probably top out at 2W for the FPGA.

>
> If you are a C coder then I assume you would use Verilog I hope....VHDL i=
s
> for ADA programmers!

I use both, but this project will be in VHDL.  VHDL has some nice
features and seems to actually be gaining strength over Verilog.

-David
