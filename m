Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 13D33B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Nov 2009 05:48:00 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Alan Nishioka <alan@nishioka.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Date: Fri, 6 Nov 2009 11:47:51 -0700
Subject: RE: DMA to User-Space
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F03310AF823@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330F9DC29@midas.usurf.usu.edu>
	<4AF0E4A0.30802@windriver.com>
	<BB99A6BA28709744BF22A68E6D7EB51F03310302E2@midas.usurf.usu.edu>
	<BB99A6BA28709744BF22A68E6D7EB51F033103030E@midas.usurf.usu.edu>
	<4AF3BCC4.6070702@nortel.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0331031240@midas.usurf.usu.edu>
	<4AF457D1.2040607@nishioka.com>
In-Reply-To: <4AF457D1.2040607@nishioka.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> you can also reserve some physical memory at the top of memory and
> dma
> into that.
> of course, this means you have to know how much memory you need
> before
> booting the kernel.

I had thought about that, however can I mmap into memory that area if I hav=
e set mem=3D250M in the boot arguments?  I would plan to DMA to above 250M =
(up to 256M).  I know that would keep the kernel out of it, but will /dev/m=
em be able to "see" that memory if I had told the kernel it was not there?

Thanks for the help!

Jonathan
