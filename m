Return-Path: <Chad.Rowan@thyssenkrupp.com>
Received: from mail003.thyssenkrupp.com (mail003.thyssenkrupp.com
	[149.211.153.64])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D567A67B78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 08:00:44 +1000 (EST)
Message-ID: <86EC6E02268B3D4BA41C1B0C61FB14E60B4551B8@mdcexc01.na.ops.local>
From: "Rowan, Chad" <Chad.Rowan@thyssenkrupp.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: export-objs in spi Makefile broke in latest linuxppc_2_4_deve
	l [r eposted]?
Date: Wed, 19 Jul 2006 17:02:00 -0500
MIME-Version: 1.0
Content-Type: text/plain
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

linuxppc_2_4_devel is alive and well.

http://www.denx.de/cgi-bin/gitweb.cgi?p=linuxppc_2_4_devel.git;a=shortlog

-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org] 
Sent: Wednesday, July 19, 2006 4:17 PM
To: Rowan, Chad
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: export-objs in spi Makefile broke in latest linuxppc_2_4_devel
[r eposted]?


On Jul 19, 2006, at 2:13 PM, Rowan, Chad wrote:

> Shouldn't export-objs in drivers/spi be:
>
> export-objs	:= spi-core.o spi-algo-mpc5xxx.o spi-algo-mpc5xxx-psc.o \
> 		   spi-iti5200.o spi-eval.o
>
> instead of:
> 	
> export-objs	:= spi-core.o spi-algo-mpc5xxx.o spi-algo-mpc5200psc.o \
> 		   spi-iti5200.o spi-eval.o
>
> I believe the spi-algo-mpc5200psc.o should be spi-algo-mpc5xxx-psc.o,
> correct?

Are you really serious about linuxppc_2_4_devel?  I can't believe  
linuxppc_2_4_devel has changed in months (if not over a year).

- k
