Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 1879B2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Oct 2004 00:51:09 +1000 (EST)
Message-ID: <415D6F76.4010601@ru.mvista.com>
Date: Fri, 01 Oct 2004 18:53:42 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <35fb2e59040930165327f2dd59@mail.gmail.com>		<87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com>	<1096602008.14803.16.camel@gaston>
	<415D3C2C.7050704@jonmasters.org>
In-Reply-To: <415D3C2C.7050704@jonmasters.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [PATCH] for linuxppc-2.4 tree: adds Memec 2VP7 / 2VP4 board support
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

The patch is for 2VP7 or 2VP4 "Virtex-II Pro Development board"
with P160 COMM Module installed.

The supported peripherals are:
- 2x 16x50 compatible UARTs (the 2nd one is on the COMM Module),
- 10/100 Mbit ethernet controller using SGDMA mode
- MTD device for two flash/SRAM chips on the COMM Module (just flash suport)
- 2x16 character LCD
- GPIO (4 LEDs, 3 buttons, DIP switches).

MAC address is supposed to be in the COMM Module's flash. If it is not there
the default (hardcoded) one is used.

The patch relies heavily on the Xilinx Virtex-II Pro support (introduced with
Xilinx ML300 board support).

I know that linuxppc-2.4 is not for patches, but linux-2.4 has no Virtex-II Pro stuff at all.

The patch itself can be found here:
http://source.mvista.com/~ank/memec2vpx.2dot4.04.diff


Best regards,
Andrei Konovalov
