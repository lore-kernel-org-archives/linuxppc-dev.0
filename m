Return-Path: <rsass@uncc.edu>
Received: from rsass-homer.uncc.edu (rsass-homer.uncc.edu [152.15.91.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 73380DDECB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Feb 2008 06:40:23 +1100 (EST)
Message-Id: <200802111939.m1BJdSbU009176@rsass-homer.uncc.edu>
To: Nicholas Mc Guire <hofrat@hofr.at>
Subject: Re: looking for 3U system with FPGA support 
In-reply-to: <Pine.LNX.4.58.0802111025100.1608@vlab.hofr.at> 
References: <Pine.LNX.4.58.0802111025100.1608@vlab.hofr.at>
Date: Mon, 11 Feb 2008 14:39:28 -0500
From: Ron Sass <rsass@uncc.edu>
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


I'm not sure why you are keen on a 3U form factor but
the Xilinx ML-410 board is an ATX form factor and fits
in various 1U chassis.  We have a couple in off-the-shelf
chassis and some in a chassis that Xilinx sells.

  http://www.xilinx.com/ml410
 
The chassis is part number HW-MLX10-RACK-G.  Coincidentally,
the board has all of the features you mentioned.

Ron

> 
> Hi !
> 
>  hope this is ok for this list - after searching quite some time for a
>  3U board with a PPC on it + more or less any FPGA - I only could find the
>  MEN F12 (5200) and F13 (8540) - does naybody know of other 3U systems ?
> 
>  Basically a FPGA based system like an ML405 would be of interest but I
>  could not locate any 3U products.
> 
>  Roughly:
> 
>   PPC roughly equivalent to a 500 MHz PIII/Celeron
>   2++ Ethernets
>   2 Seriell
>   4++ GPIO (via FPGA)
>   Linux available
>   U-boot if posible
> 
>  Any pointers would be appreciated.
> 
> thx!
> hofrat
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
