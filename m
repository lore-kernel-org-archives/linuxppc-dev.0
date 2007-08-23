Return-Path: <mustafa.cayir@bte.mam.gov.tr>
Received: from itri.bte.mam.gov.tr (itri.bte.mam.gov.tr [193.140.75.15])
	by ozlabs.org (Postfix) with SMTP id AECDCDDEEC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 15:58:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-9"
Subject: STK5200 pci_enable_device problem
Date: Thu, 23 Aug 2007 08:42:28 +0300
Message-ID: <7B9A8FF57DBB524190E98CABF6E56F078FAE4E@itri.bte.mam.gov.tr>
From: =?iso-8859-9?Q?Mustafa_Cay=FDr?= <mustafa.cayir@bte.mam.gov.tr>
To: <linuxppc-embedded@ozlabs.org>
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

I am working on TQ STK52000 development board with TQM5200-AB cpu =
module. I am trying to use PCI bus and Local Plus Bus together. SM501, =
video chip is located on local plus bus and PLX9030 based pci device is =
on pci bus.

My pci driver is able to scan pci bus and find succesfully the pci =
device. After this point, pci_enable_device function returns following =
error:

PCI:  Device 00:18.0 not available because of resource collisions

Any help is appreciated.
