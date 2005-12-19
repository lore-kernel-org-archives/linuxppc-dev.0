Return-Path: <dhlii@comcast.net>
Received: from xm.dlasys.net (unknown [24.152.213.223])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED01368802
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 16:56:17 +1100 (EST)
Received: from [206.223.20.240] (port=47474 helo=[206.223.20.240] ident=dhlii)
	by xm.dlasys.net with esmtp (Exim 4.54 #1 (Debian))
	id 1EoZgm-00040K-Kh
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Dec 2005 00:05:28 -0500
Message-ID: <43A64446.8080109@comcast.net>
Date: Mon, 19 Dec 2005 00:25:26 -0500
From: "David H. Lynch Jr." <dhlii@comcast.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <OF22452781.22D7B3D3-ON652570D9.0019E468-652570D9.001A1298@tcs.com>
In-Reply-To: <OF22452781.22D7B3D3-ON652570D9.0019E468-652570D9.001A1298@tcs.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Howto submit drivers/patches ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


	I am just polishing off bringup a Xilinx Virtex IV/ppc405 system with
minimal hardware under 2.6.14.4.
	I have a collection of patches that I can submit for the specific,
board, for the Virtex IV, for board specific hardware, ...
	Additionally I have 2 complete boot loader through full serial driver
implementations of a pseudo serial console driver for this board when it
is in a HOST development system - it is a compact flash card normally
plugged into a PC during development and using the PC as the console,
and a complete serial driver chain for the Xilinx UartLite as a console
when not in a Host, or as a general serial driver. The Xilinx Driver is
based heavily on other 2.6 driver/serial drivers and not the 2.4
implementation from Xilinx.

	Is this list the right place to submit this ?
	Is there a HOWTO addressing the rules/procedures to do so.

	I have not looked at the kernel style guides, but the style of this
code is pretty much identical to other Kernel code. The UartLite driver
is virtually indistinguishable from other driver/serial drivers except
the few places where hardware differences require changes, and that
there is a full tree of end-end support similar to what exists for the
8250's.

David H. Lynch Jr.
DLA Systems
354 Rudy Dam Rd.
Lititz, PA 17543
717.627.3770
