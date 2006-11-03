Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 77A4067CA8
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 20:12:43 +1100 (EST)
Date: Fri, 3 Nov 2006 10:12:38 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 08/16] powerpc: remove EMBEDDED6xx Kconfig entry
Message-ID: <20061103091238.GD22478@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125627.149261000@localhost.localdomain>
	<528646bc0611020658le3adc94p30f372f3a1a8b07e@mail.gmail.com>
	<20061102152527.GB4928@localhost.localdomain>
	<528646bc0611020755k5be2d2ach388e921a29663bfa@mail.gmail.com>
	<1162505588.10630.27.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1162505588.10630.27.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 03, 2006 at 09:13:08AM +1100, Benjamin Herrenschmidt wrote:
> 
> > Then perhaps Efika should also be under platforms/mpc52xx?
> 
> Classifying platforms by their processor might not be the best idea... I
> makes some sense when those platforms are basically reference designs
> for the said processor but I yet have to be convinced it's really a good
> thing in the long run :)
> 
> There will be a lot of platforms that will consist of basically once
> signle source file. I think we need a directory for those. Maybe
> platform/misc :) Or we could have them at the root of platforms/ in
> fact... 
> 

In the embedded world there are many vendors of custom boards, so
such a directory might become very big, even if there is only one
file per board. Also I like the idea that I see all affected boards at
first sight when I change something in lets say the mpc52xx interrupt
controller.
I don't know how this performs in the 'big computer world' where vendors
combine a cpu with different chipsets. In the SoC world where every SoC
has the very same interrupt controller and device layout this behaves
quite well. Things become very orthogonal with per SoC directories.
(I'm more familiar with arm, where directories are organized this way,
so you might want to look at arch/arch/mach-* to see what I mean)

Sascha

-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
