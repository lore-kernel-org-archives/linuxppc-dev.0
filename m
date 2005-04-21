Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 9273F67A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 02:32:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 21 Apr 2005 11:32:54 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B85936A@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH 2.6.12-rc2] Freescale 8272ADS PCI bridge support to
	thestock linux-2.5 (updated)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

	From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]=20
	Sent: Thursday, April 21, 2005 10:29

>	This is all right. The only thing I still don't understand -=20
>how this stuff work without PCI IRQ (don't know much about 8266
though).=20
>On my 8272 only one IRQ is produced and it should be demux'ed in order=20
>for PCI devices to work. I agree that the siumcr stuff would better
reside=20
>in the firmware, and I have submitted related patch to the u-boot-users

>list, but I have no idea whether it would be accepted or not
(Wolfgang?).

Ah.. That. I have that in a board specific file. Looks excactly like the
implementation you have (for the 8266 port) For our internal board, it
is quite different, so it should probably be in a board specific file
(eg platforms/board_pci_setup.h)
=09
>	The main point I actually dislike in the current m8260
implementation=20
>is that it adds defines for the PCI memory map while it exists=20
>(and already included) in platforms/pq2ads.h. The memory maps are=20
>nearly the same so we should decide which one will remain.=09

I think I like the _LOWER/_UPPER/OFFSET variant. And it need to be
possible to override it in board-files.
I'll work in getting the 8266 PCI support I have to be integrated into
the PQ2[F]ADS board support.
=09
	--=20
	Sincerely,=20
	Vitaly
=09
