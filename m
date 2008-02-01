Return-Path: <hans.lehmann@ritter-elektronik.de>
Received: from mail.textile.saurer.com (mail.textile.saurer.com
	[193.158.88.134]) by ozlabs.org (Postfix) with ESMTP id A808CDDF14
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Feb 2008 02:04:58 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: External Interrupt
Date: Fri, 1 Feb 2008 15:52:45 +0100
Message-ID: <D75C3E75C6176746B68E0EF7245F616F611B21@SRVEXC01.sts.saurer.vpn>
In-Reply-To: <47A2D424.3090903@coritel.it>
References: <47A2D424.3090903@coritel.it>
From: "Lehmann, Hans (Ritter Elektronik)" <hans.lehmann@ritter-elektronik.de>
To: "Marco Stornelli" <marco.stornelli@coritel.it>
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

Marco,

ASFAIK there where some changes and you have to get the irq with =
irq_create_mapping() or irq_of_parse_and_map()

Kindly regards

Hans
=20


Mit freundlichen Gr=FC=DFen

Hans Lehmann
Dipl.-Ing. Elektrotechnik



RITTER Elektronik GmbH
Leverkuser Strasse 65
D-42897 Remscheid

Tel.	+49 (0) 2191 - 67 32 40
Fax 	+49 (0) 2191 - 67 14 29
Email 	hans.lehmann@ritter-elektronik.de
Homepage  www.ritter-elektronik.de

Gesch=E4ftsf=FChrer: Manfred A. Wagner, Dr. Uwe Baader
Sitz der Gesellschaft: Oberhausen
HRB 17168 Duisburg    USt-ID DE 814009849


-----Urspr=FCngliche Nachricht-----
Von: =
linuxppc-embedded-bounces+hans.lehmann=3Dritter-elektronik.de@ozlabs.org =
[mailto:linuxppc-embedded-bounces+hans.lehmann=3Dritter-elektronik.de@ozl=
abs.org] Im Auftrag von Marco Stornelli
Gesendet: Freitag, 1. Februar 2008 09:11
An: Linuxppc Embedded Mailing List
Betreff: External Interrupt

Hi,

I used the linux kernel 2.6.10 with a processor MPC8548E. I wrote a =
driver for a device connected with the local bus. This device has an =
external interrupt. In the local bus driver I have used the macro =
MPC85xx_IRQ_EXT<X> to get the interrupt number and pass it to the driver =
and after that register the ISR. Now with a kernel 2.6.21 this macro =
isn't available because in the header file irq.h there is the option =
CONFIG_PPC_MERGE that disable those options. I think this problem is =
related to the migration of ppc code towards powerpc. I know that now =
there is the new device tree source file where I can add a device and =
its interrupt number  but I think in this file I should describe only =
the platform device, and this device is not a platform device. Then, how =
can I get now this  value? Is there some function to call? How can I =
perform this operation?

Thanks in advance.

Marco
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
