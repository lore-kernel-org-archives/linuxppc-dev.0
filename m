Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D8CE3DE005
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 14:18:27 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0A3IKSD021626
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 22:18:20 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0A3IKYe443682
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 22:18:20 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0A3IKnR024577
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 22:18:20 -0500
Date: Wed, 9 Jan 2008 21:17:58 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 2/5] Warp Base Platform - dts
Message-ID: <20080109211758.26c8e235@zod.rchland.ibm.com>
In-Reply-To: <47858D89.4070706@pikatech.com>
References: <47852C41.8000506@pikatech.com> <47852CB3.3000208@pikatech.com>
	<20080110024753.GC17816@localhost.localdomain>
	<47858D89.4070706@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 09 Jan 2008 22:14:17 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> David Gibson wrote:
> > On Wed, Jan 09, 2008 at 03:21:07PM -0500, Sean MacLennan wrote:
> >   
> >> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> >> ---
> >> --- /dev/null	2005-11-20 22:22:37.000000000 -0500
> >> +++ arch/powerpc/boot/dts/warp.dts	2008-01-08 12:04:10.000000000 -0500
> >>     
> >
> > [snip]
> >   
> >> +	plb {
> >> +		compatible = "ibm,plb-440ep", "ibm,plb-440gp", "ibm,plb4";
> >> +		#address-cells = <2>;
> >> +		#size-cells = <1>;
> >> +		ranges;
> >> +		clock-frequency = <0>; /* Filled in by zImage */
> >> +
> >> +		SDRAM0: sdram {
> >> +			compatible = "ibm,sdram-440ep", "ibm,sdram-405gp";
> >> +			dcr-reg = <010 2>;
> >> +		};
> >> +
> >> +		DMA0: dma {
> >> +			compatible = "ibm,dma-440ep", "ibm,dma-440gp";
> >> +			dcr-reg = <100 027>;
> >> +		};
> >> +
> >> +		FPGA0: fpga {
> >>     
> >
> > Surely this must be off the EBC, not directly of the PLB...?
> >   
> Could be, I don't really know :( I will move it if it makes more sense.

Well, "making more sense" would be finding out where it is on the board
and putting it in the proper place :).

josh
