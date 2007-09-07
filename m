Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id 631C7DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 17:34:52 +1000 (EST)
Received: from [134.94.232.103] (zel201.zel.kfa-juelich.de
	[134.94.232.103])by zam837.fz-juelich.de (Postfix) with ESMTP id
	0A5E41000783for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 09:34:50 +0200 (CEST)
Message-ID: <46E0FEF3.8010500@fz-juelich.de>
Date: Fri, 07 Sep 2007 09:34:11 +0200
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: Flash Filesystem
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

Hi

i've some problems using the on board flash memory with linux.
i added the support for adm/fujittsu flash in kernel config and add the
right parameters for the "cfi  flash device in physical memory".

cat /proc/mtd gives me

dev:    size   erasesize  name
mtd0: 00400000 00010000 "physmap-flash.0"

i added /dev/mtd0 c 90 0 and /dev/mtdblock0 b 31 0

how do i add a partition and filesystem ????
fdisk /dev/mtd0  seems me not to be correct :)

Greets
Georg





-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
Forschungszentrum Jülich GmbH
52425 Jülich

Sitz der Gesellschaft: Jülich
Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498
Vorsitzende des Aufsichtsrats: MinDirig'in Bärbel Brumme-Bothe
Vorstand: Prof. Dr. Achim Bachem (Vorsitzender), Dr. Ulrich Krafft (stellv. 
Vorsitzender)
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
