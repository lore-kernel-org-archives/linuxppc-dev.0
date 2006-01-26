Return-Path: <Jose.Franca.Ext@siemens.com>
Received: from relay2.siemens.pt (unknown [194.145.62.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46F3768A94
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jan 2006 01:05:15 +1100 (EST)
Received: from fw-mta1.siemens.pt (fw-mta1.siemens.pt [141.29.156.201])
	by relay2.siemens.pt (8.12.8/8.12.9) with ESMTP id k0QDwJFe014546
	for <linuxppc-embedded@ozlabs.org>; Thu, 26 Jan 2006 13:58:21 GMT
Received: from lisi053a.siemens.pt (lisi053a.siemens.pt [141.29.156.193])
	by fw-mta1.siemens.pt (Hvm) with ESMTP id k0QDntH07651
	for <linuxppc-embedded@ozlabs.org>; Thu, 26 Jan 2006 13:49:55 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: HELP! Memory mapping and address space doubts
Date: Thu, 26 Jan 2006 14:04:49 -0000
Message-ID: <16FD2D70D281D44F9BFCF6ACF9B6117102AF731A@lisi053a.siemens.pt>
From: =?iso-8859-1?Q?Jose_Fran=E7a_=28Ext=5FGTBC=29?=
	<Jose.Franca.Ext@siemens.com>
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

Hello u all!

	I need to clarify some aspects of the memory management in ppc linux =
and i hope that you could help me.
	Lets imagine we have a mpc8272 based board with 3 devices A, B and C.In =
the bootloader (in my case, i use u-boot), i configured the BRx and Orx =
so that A has base address X, B has base address Y and C has base =
address Z. My first doubt arrises here: what address should i use? Being =
SDRAM base address 0x00000000 and kernel base address 0xC0000000, where =
will i put these devices mapped on? Above 0xC0000000 or in between the =
end of physical memory and 0xC0000000? Do i really need to configure the =
BAT registers in u boot?
	In linux 2.4 kernel, we have ppc_md.setup_io_mappings to map address =
blocks into the BAT registers... As i observed in the kernel source tree =
examples, we must map CPM (why?). And what about the other devices A, B =
and C? How will i setup them in this case and what addresses i can use? =
Above 0xC0000000 or in between the end of physical memory and =
0xC0000000? Is the SDRAM included?

	Thanks in advance to all contributions! All of them will be most =
welcomed!





Best regards,
Filipe
