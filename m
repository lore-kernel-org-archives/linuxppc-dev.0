Return-Path: <g.schardt@fz-juelich.de>
Message-ID: <4731A8E3.4020909@fz-juelich.de>
Date: Wed, 07 Nov 2007 13:00:35 +0100
From: schardt <g.schardt@fz-juelich.de>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
Subject: Bootloader & Flash
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

Hi,

i use the AVnet Xilinx4 FX12 Minimodule and until now, i use system-ace
to configure the fpga and boot the linux kernel.
But now, i want to boot from the on board flash memory and have no idea
where to start.

I think i have to:
- save the fpga configuration in the fpga-prom
- use/program some kind of bootloader store in fpga block ram to jump to
the flash-adress where the executable linux kernel resist
- use the mtd-device driver to mount  root fs on the same flash some
address later

Is this the right way ?


Regards
Georg






-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
Forschungszentrum Jülich GmbH
52425 Jülich

Sitz der Gesellschaft: Jülich
Eingetragen im Handelsregister des Amtsgerichts Düren Nr. HR B 3498
Vorsitzende des Aufsichtsrats: MinDirig'in Bärbel Brumme-Bothe
Geschäftsführung: Prof. Dr. Achim Bachem (Vorsitzender), Dr. Ulrich Krafft (stellv. 
Vorsitzender)
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
