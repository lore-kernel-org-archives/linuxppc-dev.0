Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 30B45DDF33
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 06:14:16 +1100 (EST)
Message-Id: <1DF998D6-4C89-4F3E-92B8-49390AB5AE88@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: =?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
In-Reply-To: <49A2D364.8090305@kontron.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: 86xx: e600 and cputable.c
Date: Mon, 23 Feb 2009 13:13:48 -0600
References: <49A2D364.8090305@kontron.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 23, 2009, at 10:48 AM, R=E9gis Odey=E9 wrote:

> Hi,
>
> On our board based on 8641D, cat /proc/cpuinfo gives:
> -bash-3.2# cat /proc/cpuinfo
> processor       : 0
> cpu             : 7448, altivec supported
> clock           : 1000.000000MHz
> revision        : 0.2 (pvr 8004 0202)
> bogomips        : 199.68
>
> processor       : 1
> cpu             : 7448, altivec supported
> clock           : 1000.000000MHz
> revision        : 0.2 (pvr 8004 0202)
> bogomips        : 199.68
>
> total bogomips  : 399.36
> timebase        : 100000000
> platform        : VM6250
> Vendor          : Kontron Modular Computers
> Machine         : VM6250
> SVR             : 0x80900121
> Memory          : 1024 MB
>
> Is there a plan to deal with e600 core as it is done for e500 in =20
> cputable.c to be able to discriminate "classic" ppc against =20
> freescale cores ?
> Already a patch ?
>

what kernel version.  I believe this is fixed:

commit a501d8f30e4fcca563e4ee462be00f96e51181d5
Author: Martin Langer <martin-langer@gmx.de>
Date:   Sun Sep 7 17:51:32 2008 +1000

     powerpc: Fix major revision number for Freescale cores

     Some 74xx cores by Freescale are using the configuration field =20
instead
     of the major revision field for their revision number.  This =20
corrects
     the wrong behaviour for those ppc cores including my one.
...

- k=
