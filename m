Return-Path: <muneeswaranp@hcl.in>
Received: from rose.ctd.hcltech.com (rose.ctd.hcltech.com [202.54.64.23])
	by ozlabs.org (Postfix) with ESMTP id 5700D67AC7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 May 2006 15:55:17 +1000 (EST)
Message-ID: <012301731C23DE4DBFE035647C68F1CC0331C84F@sindhu.ctd.hcltech.com>
From: "Muneeswaran P - TLS, Chennai" <muneeswaranp@hcl.in>
To: <linuxppc-embedded@ozlabs.org>
Subject: Howto allocate non-cacheable memory
Date: Sat, 27 May 2006 11:08:05 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

How to allocate non-cacheable kernel memory ?

Pls help me.


	I am writing device driver (kernel 2.6 ) for PCI-X card.

	Pls clarify the following doubts:
	1. DPRAM is memory mapped to PCI-X card.
	2. I have to transfer data from main memory to DPRAM using bus
master concept and vice-versa.
	3. How to make this memory area as non-cacheable one ?=20
	4. Whether DMA mapping (pci_map_single() call ) should be done for
both DPRAM and main memory ?
	   4.a) I will get the physical address of DPRAM memory (memory
mapped to PCI-X card) from BAR-0 register. Can i use this physical =
addres
directly for data transer using bus master (without pci_map_single() =
call.)
?
	   4.b)  How to make main memory area as non-cacheable one ?


Regards,
Munees.
DISCLAIMER=20
The contents of this e-mail and any attachment(s) are confidential and =
intended for the=20

named recipient(s) only. It shall not attach any liability on the =
originator or HCL or its=20

affiliates. Any views or opinions presented in this email are solely =
those of the author and=20

may not necessarily reflect the opinions of HCL or its affiliates. Any =
form of reproduction,=20

dissemination, copying, disclosure, modification, distribution and / or =
publication of this=20

message without the prior written consent of the author of this e-mail =
is strictly=20

prohibited. If you have received this email in error please delete it =
and notify the sender=20

immediately. Before opening any mail and attachments please check them =
for viruses and=20

defect.
