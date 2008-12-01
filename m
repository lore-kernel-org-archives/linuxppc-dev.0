Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 91771DDD0B
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2008 19:12:45 +1100 (EST)
Subject: Re: ppc4xx: u-boot sees PCIe endpoint, linux does not.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
In-Reply-To: <c384c5ea0811280450t3e199da6s1fcdf903f63f9622@mail.gmail.com>
References: <c384c5ea0811280450t3e199da6s1fcdf903f63f9622@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 01 Dec 2008 19:12:32 +1100
Message-Id: <1228119152.7356.118.camel@pasglop>
Mime-Version: 1.0
Cc: u-boot@lists.denx.de, Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-11-28 at 13:50 +0100, Leon Woestenberg wrote:
> Hello,
> 
> AMCC PPC460EX canyonlands board with an FPGA PCIe end point:
> 
> u-boot sees the end point, but Linux does not:
> 
> U-Boot 1.3.3-00249-ga524e11 (Jun 30 2008 - 16:05:51)
> CPU:   AMCC PowerPC 460EX Rev. A at 800 MHz (PLB=200, OPB=100, EBC=100 MHz)
> <...>
> Board: Canyonlands - AMCC PPC460EX Evaluation Board, 2*PCIe, Rev. 16
> <...>
> PCIE1: successfully set as root-complex
>         02  00  2071  2071  00ff  00
> 
> 
> Now, if I re-program the end-point FPGA during the u-boot boot
> time-out, Linux will recognize the end-point.
> 
> Any takers on what I should start looking for?

It's possible that either the reset in between goes bonkers or something
else causes your FPGA to stop responding. It looks like a programming
problem with the FPGA to me.

Ben.
