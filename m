Return-Path: <matvejchikov@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 416EDDDF8A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jun 2008 22:25:17 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so32148ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 04 Jun 2008 05:25:07 -0700 (PDT)
Message-ID: <8496f91a0806040525u7e137221sc4bea5466cde3161@mail.gmail.com>
Date: Wed, 4 Jun 2008 16:25:07 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: The 2.6.25 kernel dosen't run on pq2fads based board
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all!

There is a problem with 2.6.25.4 kernel on the pq2fads based board.
The board resets after "MMU:exit" called (early debuging is used).See
the attached log:

========
## Booting kernel from Legacy Image at 00200000 ...
   Image Name:   Linux-2.6.25.4
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1534783 Bytes =  1.5 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Flattened Device Tree blob at 00800000
   Booting using the fdt blob at 0x800000
   Loading Device Tree to 007fe000, end 007fffff ... OK
Xid mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
<<---- the reset was here :(

U-Boot 1.3.3-dirty (Jun  2 2008 - 15:43:45)

MPC8260 Reset Status: Check Stop, External Soft, External Hard

MPC8260 Clock Configuration
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq 100-300
 - dfbrg 1, corecnf 0x1a, busdf 4, cpmdf 1, plldf 1, pllmf 4, pcidf 3
 - vco_out  330000000, scc_clk   82500000, brg_clk   20625000
 - cpu_clk  264000000, cpm_clk  165000000, bus_clk   66000000

CPU:   MPC8260 (HiP4 Rev 14, Mask C.0 5K25A) at 264 MHz
========

Can anyone help me with this?

Thanks.
