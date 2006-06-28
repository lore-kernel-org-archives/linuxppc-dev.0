Return-Path: <rick.moleres@xilinx.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EF3BA67B73
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 05:12:45 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 2.6 kernel on XUPV2pro / ML300 board!
Date: Wed, 28 Jun 2006 12:42:17 -0600
Message-ID: <689CB232690D8D4E97DA6C76DA098E6C0285AD19@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Rick Moleres" <rick.moleres@xilinx.com>
To: "Ameet Patil" <ammubhai@gmail.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ameet,

Xilinx is working with MontaVista to create an ML40x LSP (for the Xilinx
ML403/ML405 boards) and port the ML300 LSP to the MV Linux 2.6
distribution, and once it's ready MontaVista plans to push the ported
drivers to the Linux 2.6 tree.  I don't have an exact timeframe, but I
hope this is very soon.

-Rick

-----Original Message-----
From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On
Behalf Of Ameet Patil
Sent: Wednesday, June 28, 2006 11:50 AM
To: linuxppc-embedded@ozlabs.org
Subject: 2.6 kernel on XUPV2pro / ML300 board!

Hi,
   I have a XUPV2Pro Xilinx Embedded PPC405 board which is similar in=20
many respects to the ML3XX series. With good support in the kernel=20
source tree, I was easily able to compile the 2.4.26 linux kernel to run

on it.

However, I wanted 2.6 kernel to run on it. For some reason, the Xilinx=20
drivers and the OCP code went missing in the 2.6 kernel tree.
Does anyone know why did 2.6 kernel drop the Xilinx ML300 board
drivers (SysACE, Ethernet, Frame Buffer) which were present in the 2.4
kernel code tree? It is because of porting issues?

Anyway, I have ported the old 2.4 Xilinx drivers (Sysace and Ethernet)=20
to 2.6.17.1 kernel. If anyone is interested to test them, please let me=20
know. I shall put out a patch soon...

Thanks,
-Ameet
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
