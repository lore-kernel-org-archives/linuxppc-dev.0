Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id ED6E1DDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 02:24:44 +1100 (EST)
Received: from [134.94.232.103] (zel201.zel.kfa-juelich.de
	[134.94.232.103])by zam837.fz-juelich.de (Postfix) with ESMTP id
	9D7891000986for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 16:24:41 +0100 (CET)
Message-ID: <474D8839.6020609@fz-juelich.de>
Date: Wed, 28 Nov 2007 16:24:41 +0100
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: Init hangs on Xilinx4
Content-Type: text/plain;
	charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

i still have some problems booting linux from flash and don't know how
to debug.

i have a xilinx4-ppc with 64MB Ram and 4MB Flash, U-Boot works fine,
kernel is booting, but my little hello world program runs as init, died
after printing "He" (intead of "Hello World"). i tried initramfs with
build in cpio-image and jffs2 rootfs

Is there a log-buffer to look at ?
Should i try another compiler version ? (btw. booting from systemace
works with the version i use).

---------------------------
famous last words :

[   50.476641] VFS: Mounted root (jffs2 filesystem).
[   50.533581] Freeing unused kernel memory: 68k init
He
---------------------------


regards
Georg



-------------------------------------------------------------------
-------------------------------------------------------------------
Forschungszentrum Jülich GmbH
52425 Jülich

Sitz der Gesellschaft: Jülich
Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498
Vorsitzende des Aufsichtsrats: MinDirig'in Bärbel Brumme-Bothe
Geschäftsführung: Prof. Dr. Achim Bachem (Vorsitzender),
Dr. Ulrich Krafft (stellv. Vorsitzender), Dr. Sebastian M. Schmidt
-------------------------------------------------------------------
-------------------------------------------------------------------
