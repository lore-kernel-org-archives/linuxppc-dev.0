Return-Path: <ammubhai@gmail.com>
Received: from mailgw.cs.york.ac.uk (mailgw.cs.york.ac.uk [144.32.40.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 427C267B59
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 04:21:15 +1000 (EST)
Received: from minster.cs.york.ac.uk ([144.32.40.2])
	by mailgw.cs.york.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.60) (envelope-from <ammubhai@gmail.com>) id 1FveAt-0006Bx-3D
	for linuxppc-embedded@ozlabs.org; Wed, 28 Jun 2006 18:50:03 +0100
Received: from pc112.ad.cs.york.ac.uk ([144.32.81.113])
	by minster.cs.york.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.60) (envelope-from <ammubhai@gmail.com>) id 1FveAt-0002ys-E2
	for linuxppc-embedded@ozlabs.org; Wed, 28 Jun 2006 18:50:03 +0100
Message-ID: <44A2C14B.5070504@gmail.com>
Date: Wed, 28 Jun 2006 18:50:03 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: 2.6 kernel on XUPV2pro / ML300 board!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
   I have a XUPV2Pro Xilinx Embedded PPC405 board which is similar in 
many respects to the ML3XX series. With good support in the kernel 
source tree, I was easily able to compile the 2.4.26 linux kernel to run 
on it.

However, I wanted 2.6 kernel to run on it. For some reason, the Xilinx 
drivers and the OCP code went missing in the 2.6 kernel tree.
Does anyone know why did 2.6 kernel drop the Xilinx ML300 board
drivers (SysACE, Ethernet, Frame Buffer) which were present in the 2.4
kernel code tree? It is because of porting issues?

Anyway, I have ported the old 2.4 Xilinx drivers (Sysace and Ethernet) 
to 2.6.17.1 kernel. If anyone is interested to test them, please let me 
know. I shall put out a patch soon...

Thanks,
-Ameet
