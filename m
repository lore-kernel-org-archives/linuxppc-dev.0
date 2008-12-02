Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 0BB31DDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Dec 2008 03:11:37 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1L7XqY-0001Qd-R1
	for linuxppc-embedded@ozlabs.org; Tue, 02 Dec 2008 08:11:34 -0800
Message-ID: <20794404.post@talk.nabble.com>
Date: Tue, 2 Dec 2008 08:11:34 -0800 (PST)
From: saadia dhouib <saadia_dhouib@yahoo.fr>
To: linuxppc-embedded@ozlabs.org
Subject: xilinx drivers support in linux 2.6 from denx tree ?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,
I have to install a real time microkernel (xenomai) with a linux 2.6 kernel
on a ppc 405 processor embedded in the xilinx xupv2p platform. 
Xenomai adeos patch is only applicable to kernels from denx tree. 
So I have to install a linux 2.6 from the denx tree. My question is: 
Is there support for xilinx drivers (sysace; opb_emac, rs232 ) in denx tree,
if it's not the case, how can I integrate them.

Thanks
-- 
View this message in context: http://www.nabble.com/xilinx-drivers-support-in-linux-2.6-from-denx-tree---tp20794404p20794404.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
