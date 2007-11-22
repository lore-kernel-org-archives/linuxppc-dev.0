Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id 9CF27DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Nov 2007 21:02:05 +1100 (EST)
Message-ID: <47455393.7050905@fz-juelich.de>
Date: Thu, 22 Nov 2007 11:01:55 +0100
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: schardt <g.schardt@fz-juelich.de>
Subject: Re: Initramfs problem on virtex4fx
References: <47453B63.6010100@fz-juelich.de>
In-Reply-To: <47453B63.6010100@fz-juelich.de>
Content-Type: text/plain;
	charset=ISO-8859-1
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

additional i tried a initramfs rootfs with busybox

Freeing unused kernel memory: 1944k init
init started: BusyBox v1.7.0 (2007-11-07 14:29:33 CET)
starting pid 152eth0: XTemac: Options: 0xb8f2
eth0: XTemac: We renegotiated the speed to: 1000
eth0: XTemac: speed set to 1000Mb/s
, tty '': '/etc/init.d/

this looks very strange to me....

Georg

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
>
> -------------------------------------------------------------------
> -------------------------------------------------------------------
> Forschungszentrum J=FClich GmbH
> 52425 J=FClich
>
> Sitz der Gesellschaft: J=FClich
> Eingetragen im Handelsregister des Amtsgerichts D=FCren Nr. HR B 3498
> Vorsitzende des Aufsichtsrats: MinDirig'in B=E4rbel Brumme-Bothe
> Gesch=E4ftsf=FChrung: Prof. Dr. Achim Bachem (Vorsitzender),
> Dr. Ulrich Krafft (stellv. Vorsitzender), Dr. Sebastian M. Schmidt
> -------------------------------------------------------------------
> -------------------------------------------------------------------
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>  =20



-------------------------------------------------------------------
-------------------------------------------------------------------
Forschungszentrum J=FClich GmbH
52425 J=FClich

Sitz der Gesellschaft: J=FClich
Eingetragen im Handelsregister des Amtsgerichts D=FCren Nr. HR B 3498
Vorsitzende des Aufsichtsrats: MinDirig'in B=E4rbel Brumme-Bothe
Gesch=E4ftsf=FChrung: Prof. Dr. Achim Bachem (Vorsitzender),
Dr. Ulrich Krafft (stellv. Vorsitzender), Dr. Sebastian M. Schmidt
-------------------------------------------------------------------
-------------------------------------------------------------------
