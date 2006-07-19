Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B9ED67B7C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 07:16:24 +1000 (EST)
In-Reply-To: <86EC6E02268B3D4BA41C1B0C61FB14E60B3C8335@mdcexc01.na.ops.local>
References: <86EC6E02268B3D4BA41C1B0C61FB14E60B3C8335@mdcexc01.na.ops.local>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <76B8BEDF-4DDE-47BE-AF9D-664544AA1B4A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: export-objs in spi Makefile broke in latest linuxppc_2_4_devel [r
	eposted]?
Date: Wed, 19 Jul 2006 16:16:37 -0500
To: "Rowan, Chad" <Chad.Rowan@thyssenkrupp.com>
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
