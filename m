Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3674FDEC00
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Apr 2008 04:43:35 +1000 (EST)
Message-Id: <AE929D10-3467-4FA4-870A-65356DCDEAF6@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <47FB75BC.10400@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: TSEC3/4 broken on MPC8548?
Date: Fri, 11 Apr 2008 13:43:21 -0500
References: <47FB75BC.10400@grandegger.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 8, 2008, at 08:40, Wolfgang Grandegger wrote:

> Hello,
>
> in the dts file for the MPC8548CDS the nodes for TSEC3/4 are commented
> out because they seem to be broken:
>
>  $ grep broken arch/powerpc/boot/dts/*
>  arch/powerpc/boot/dts/mpc8548cds.dts:/* eTSEC 3/4 are currently  
> broken


It's still true for the boards for which it was true.  :)

Recent 8548 CDS systems (ones which have eTSEC3&4 exposed out the  
side, rather than the back) should be fine.  If you remove the  
comment, it should work.  Actually, I vaguely recall there might be a  
bug in the dts there.  Should be an easy fix, though.  Something like  
the wrong address for the regs, or the wrong interrupts numbers.

I will roll up a patch.

Andy
