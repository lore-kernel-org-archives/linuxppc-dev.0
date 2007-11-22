Return-Path: <g.schardt@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id C8535DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Nov 2007 19:18:53 +1100 (EST)
Received: from [134.94.232.103] (zel201.zel.kfa-juelich.de
	[134.94.232.103])by zam837.fz-juelich.de (Postfix) with ESMTP id
	B01B31000595for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Nov 2007 09:18:50 +0100 (CET)
Message-ID: <47453B63.6010100@fz-juelich.de>
Date: Thu, 22 Nov 2007 09:18:43 +0100
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: Initramfs problem on virtex4fx
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

i try to run linux from flash with the initramfs as root filesystem.
i wrote a simple hello_world as init to test the initramfs.

the kernel boots normaly, but instead of the complete "Hello World" i
see only "He"
and the system hangs.

Does anyone have similar problems ? And solved it ? ;)

Regards
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
