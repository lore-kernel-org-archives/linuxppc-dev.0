Return-Path: <kjoutwater@raytheon.com>
Received: from tus-gate5.raytheon.com (tus-gate5.raytheon.com [199.46.245.234])
	by ozlabs.org (Postfix) with ESMTP id 065D06818B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Aug 2005 04:31:29 +1000 (EST)
Received: from ds02t00.directory.ray.com (ds02t00.directory.ray.com
	[147.25.154.117])
	by tus-gate5.raytheon.com (8.12.10/8.12.10) with ESMTP id
	j7TIVRtr002450 for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Aug 2005 11:31:27 -0700 (MST)
Received: from ds02t00 (localhost [127.0.0.1])
	by ds02t00.directory.ray.com (Switch-3.1.7/Switch-3.1.0) with ESMTP id
	j7TIVLt1021627
	for <linuxppc-embedded@ozlabs.org>; Mon, 29 Aug 2005 18:31:21 GMT
Received: from ds02t00.directory.ray.com with LMTP by ds02t00
	(2.0.6/sieved-2-0-build-559)
	for <linuxppc-embedded@ozlabs.org>; Mon, 29 Aug 2005 18:31:21 +0000
Received: from tu2-msg04.rsc.raytheon.com (tu2-msg04.RSC.RAYTHEON.COM
	[147.24.232.105])
	by ds02t00.directory.ray.com (Switch-3.1.7/Switch-3.1.0) with ESMTP id
	j7TIV6dF021558
	sender kjoutwater@raytheon.com for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Aug 2005 18:31:09 GMT
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
From: Keith J Outwater <kjoutwater@raytheon.com>
Message-ID: <OF9C3C40D4.4EC5E6BD-ON0725706C.0064A09D-0725706C.0065B9FC@mck.us.ray.com>
Date: Mon, 29 Aug 2005 11:31:06 -0700
Content-Type: text/plain; charset="US-ASCII"
Subject: linuxppc-2.4.30-pre1 crashes with root fs on Xilinx SystemACE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello - 
Per a previous suggestion from this list, I rsynced the linuxppc-2.4 
kernel sources from MontaVista and modified the kernel to run on my custom 
ppc405/VirtexII Pro based system with U-Boot as the bootloader.
When I try to use the SystemACE device as the root filesystem, the kernel 
crashes with a sig 11.  Looking at the 'oops' output it appears  the 
SystemACE driver may be to blame.  The crash is random - sometimes I get 
all the way to login as root and then things crash on a file copy or a 
file read.
Before I start digging deeper, is anyone running a VirtexIIPro based 
system with the root filesystem in the CF card attached to a SystemACE? 
I'm wondering if I really have the best kernel and SystemACE driver.
BTW, I'm developing the hardware design using Xilinx EDK 7.02i.
Thanks,
Keith
