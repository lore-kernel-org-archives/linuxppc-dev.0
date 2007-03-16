Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1503DDEEE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Mar 2007 06:14:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: MEN A14C-board
Date: Fri, 16 Mar 2007 12:10:01 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B44@MERCURY.inside.istor.com>
References: <45FA6336.9020400@dutchspace.nl>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Johan Borkhuis" <j.borkhuis@dutchspace.nl>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Johan:
=20
Hello to you. It has been a while since I have admired your train wheels =
on comp.os.vxworks.
=20
On recent linux kernels with PPC, one usually has to add =
CONFIG_SERIAL_TEXT_DEBUG to see very early serial output from the =
kernel. This sets up the serial uart before the console is setup.
=20
Another issue on ppc kernels is they usually require a =
console=3DttyS0,115200 on the kernel command line (Assuming you primary =
serial port is ttyS0).
=20
I can get into more details if you wish. Let me know.
=20
Charles

________________________________

From: linuxppc-embedded-bounces+ckrinke=3Distor.com@ozlabs.org on behalf =
of Johan Borkhuis
Sent: Fri 3/16/2007 2:28 AM
To: linuxppc-embedded@ozlabs.org
Subject: MEN A14C-board



Hello,

I am working on getting Linux running on a MEN-Micro A14C board. This
board contains a PPC-8540, and has a U-Boot compatible bootloader. Is
anyone else working with this board already?
I tried modifying some BSP's, but I am not able to get past the
bootloader prompt, the kernel itself does not produce any output.

Kind Regards,
    Johan Borkhuis
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
