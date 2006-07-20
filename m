Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 53DBF67B7D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 15:16:38 +1000 (EST)
Subject: export-objs in spi Makefile broke in latest linuxppc_2_4_deve l [r
	eposted]?
From: Heiko Schocher <hs@denx.de>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: 
Content-Type: text/plain
Date: Thu, 20 Jul 2006 06:55:42 +0200
Message-Id: <1153371343.6004.16.camel@Zeus.EmbLux>
Mime-Version: 1.0
Cc: Chad.Rowan@thyssenkrupp.com
Reply-To: hs@denx.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Chad

> linuxppc_2_4_devel is alive and well.
> 
> http://www.denx.de/cgi-bin/gitweb.cgi?p=linuxppc_2_4_devel.git;a=shortlog

You speak from the DENX linuxppc_2_4_devel Kernel? If so, I think you are right.
I had the same problem, some days ago. I made a SPI bitbanging algorithm, but
I dont know, if this goes in the git repository from DENX ... Wolfgang?

> -----Original Message-----
> From: Kumar Gala [mailto:galak at kernel.crashing.org] 
> Sent: Wednesday, July 19, 2006 4:17 PM
> To: Rowan, Chad
> Cc: linuxppc-embedded at ozlabs.org
> Subject: Re: export-objs in spi Makefile broke in latest linuxppc_2_4_devel
> [r eposted]?
> 
> 
> > On Jul 19, 2006, at 2:13 PM, Rowan, Chad wrote:
> > 
> > Shouldn't export-objs in drivers/spi be:
> >
> > export-objs	:= spi-core.o spi-algo-mpc5xxx.o spi-algo-mpc5xxx-psc.o \
> > 		   spi-iti5200.o spi-eval.o
> >
> > instead of:
> > 	
> > export-objs	:= spi-core.o spi-algo-mpc5xxx.o spi-algo-mpc5200psc.o \
> > 		   spi-iti5200.o spi-eval.o
> >
> > I believe the spi-algo-mpc5200psc.o should be spi-algo-mpc5xxx-psc.o,
> > correct?
> 
> Are you really serious about linuxppc_2_4_devel?  I can't believe  
> linuxppc_2_4_devel has changed in months (if not over a year).

Commit: 98b663155ab7ab07dd85a8d03f437ab4fc29476b
Author: Wolfgang Denk <wd@pollux.denx.de> Thu, 13 Jul 2006 20:17:25 +0200

    MCC200: fix QuadUART I/O addressing and interrupt init on new H/W
    Patch by Johann Glaser, 13 Jul 2006

It progresses ;-)

Best regards
Heiko 
