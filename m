Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id 87D42DDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 23:01:32 +1000 (EST)
Received: from [134.94.232.103] (zel201.zel.kfa-juelich.de
	[134.94.232.103])by zam837.fz-juelich.de (Postfix) with ESMTP id
	B837310008B4for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 14:55:29 +0200 (CEST)
Message-ID: <46D2C9A5.9030708@fz-juelich.de>
Date: Mon, 27 Aug 2007 14:55:01 +0200
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Newbie and linux on virtex-II ppc
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

Hello,

im a student from germany and i try to run linux on a virtex-II with
integrated powerpc.
i use the developer board DS-DB-2VP4/7-FG456 from Memec ( i think its
now avnet)

i hope my questions are not too stupid :-)

what is running :

  - Xilinx EDK project (standalone program running fine, and BSP files
are generated)
    the project has only one UARTLITE, 82MB SDRAM and a few kByte
blockram, and the systemace interface
 
  - crosscompiler toolchain works

  - after modified some defines in the xparameters.h i got a linux 2.4.
kernel (linuxppc) without compiler errors
    and yes, the uartlite driver is enabled :)


but, when downloading the zImage.elf via XMD to the SDRAM and starting
it with the run command nothing happens , or  i think that nothings
happens because the serial port is quiet.

is it possible to run a kernel that way ? or need i some kind of
bootloader ?
or is this complete the wrong way ?

Regards
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
