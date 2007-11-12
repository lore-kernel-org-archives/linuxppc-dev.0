Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD5E1DDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 06:54:23 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IrfMR-0006It-WA
	for linuxppc-embedded@ozlabs.org; Mon, 12 Nov 2007 11:54:19 -0800
Message-ID: <13712778.post@talk.nabble.com>
Date: Mon, 12 Nov 2007 11:54:19 -0800 (PST)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: small bootloader that passes arguments
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

I would like to create a small bootloader that is able to pass kernel
arguments and boot a linux kernel.  Im using a xilinx PPC, and have already
booted a working kernel with a Xilinx provided XMD bootloader over USB.  My
main question is how does a bootloader pass these arguments to the kernel
before booting it?  Most specifically the root=/dev/xsa1 command so I can
tell it to either boot from compact flash or NFS.

I really don't want to try and port U-boot since I don't need the bells and
whistles and I want it to fit in the BRAM of the FPGA so it will load when I
load the hardware configuration.
-- 
View this message in context: http://www.nabble.com/small-bootloader-that-passes-arguments-tf4793411.html#a13712778
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
