Return-Path: <paubert@iram.es>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7B435B7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 21:52:42 +1000 (EST)
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 128B2DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 21:52:41 +1000 (EST)
Date: Fri, 11 Sep 2009 13:52:27 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Aggrwal Poonam-B10812 <Poonam.Aggrwal@freescale.com>
Subject: Re: [PATCH][v1] powerpc/85xx: Create dts for each core in
	CAMPmodefor P2020RDB
Message-ID: <20090911115227.GA13817@iram.es>
References: <1252573031-4157-1-git-send-email-poonam.aggrwal@freescale.com>
	<20090910093307.GA17117@iram.es>
	<1BD5CFC378ED0946B688E0C9BA2EF0951FD268@zin33exm24.fsl.freescale.net>
	<20090910160233.GA24085@iram.es>
	<1BD5CFC378ED0946B688E0C9BA2EF0951FD33A@zin33exm24.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1BD5CFC378ED0946B688E0C9BA2EF0951FD33A@zin33exm24.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 11, 2009 at 05:17:50PM +0530, Aggrwal Poonam-B10812 wrote:
>  
> 
> > -----Original Message-----
> > From: Gabriel Paubert [mailto:paubert@iram.es] 
> > Sent: Thursday, September 10, 2009 9:33 PM
> > To: Aggrwal Poonam-B10812
> > Cc: linuxppc-dev@ozlabs.org
> > Subject: Re: [PATCH][v1] powerpc/85xx: Create dts for each 
> > core in CAMPmodefor P2020RDB
> > 
> > Ok, I wrongly understood protected interrupts as reserved for 
> > one core. However, I still dislike two devices having the same name.
> > 
> > Otherwise it may work if every interrupt is delivered to both 
> > cores although statistically only one core will actually have 
> > some work to do. Doesn't the kernel complain about unhandled 
> > irqs however? 
> > 
> We don't see any such messages of unhandled interrupts, although I
> checked the corresponding files for mpc8572ds, they do not have the
> interrupts property for the serial ports at all, in both the core0 and
> core1 dts.
> Don't know the reason.

Well it may depend on the irqdebug (or actually it seems to 
be noirqdebug) kernel parameter.

But if serial is used for console, the message rate could
go ballistic.

	Gabriel
