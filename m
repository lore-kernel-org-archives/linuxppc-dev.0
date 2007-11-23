Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0805BDDE02
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 12:26:35 +1100 (EST)
Message-ID: <47462AEA.9030500@dlasys.net>
Date: Thu, 22 Nov 2007 20:20:42 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: schardt <g.schardt@fz-juelich.de>
Subject: Re: Initramfs problem on virtex4fx
References: <47453B63.6010100@fz-juelich.de>
In-Reply-To: <47453B63.6010100@fz-juelich.de>
Content-Type: text/plain; charset=iso-8859-1
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

schardt wrote:
> Hi all,
>
> i try to run linux from flash with the initramfs as root filesystem.
> i wrote a simple hello_world as init to test the initramfs.
>
> the kernel boots normaly, but instead of the complete "Hello World" i
> see only "He"
> and the system hangs.
>
> Does anyone have similar problems ? And solved it ? ;)
>
> Regards
> Georg
>   
    The Pico Linux BSP uses initramfs.  The whole Pico Linux development
environment including busybox and an initramfs  cross compilers, Linux
source - pretty much everything you need is at
http://www.picocomputing.com/downloads/software.php, everything is
incorporated into a Colinux install, though you can just pull out the
necescary peices - the cross compiler, busy box, intramfs and linux
source if you are working completely under linux. 

   



>
> -------------------------------------------------------------------
> -------------------------------------------------------------------
> Forschungszentrum Jülich GmbH
> 52425 Jülich
>
> Sitz der Gesellschaft: Jülich
> Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498
> Vorsitzende des Aufsichtsrats: MinDirig'in Bärbel Brumme-Bothe
> Geschäftsführung: Prof. Dr. Achim Bachem (Vorsitzender),
> Dr. Ulrich Krafft (stellv. Vorsitzender), Dr. Sebastian M. Schmidt
> -------------------------------------------------------------------
> -------------------------------------------------------------------
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
