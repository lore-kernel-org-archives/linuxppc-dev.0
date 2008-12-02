Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 2CB74DDDEF
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Dec 2008 20:15:06 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1L7RLT-0007M2-Eq
	for linuxppc-embedded@ozlabs.org; Tue, 02 Dec 2008 01:15:03 -0800
Message-ID: <20788559.post@talk.nabble.com>
Date: Tue, 2 Dec 2008 01:15:03 -0800 (PST)
From: saadia dhouib <saadia_dhouib@yahoo.fr>
To: linuxppc-embedded@ozlabs.org
Subject: linux 2.6.23 from git.xilinx and opb_emac driver
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
I want to install linux 2.6.23 (from git.xilinx.com) on an ppc 405 processor
embedded in a xupv2p platform.
In this version, there is support for xilinx sysace and xilinx uartlite, but
there is no networking driver from xilinx.
I need the opb_emac driver. I tried to copy the opb_emac driver files
generated from edk 9.1 to the linux tree,
and I made some changes following the instructions in this link :
http://abdn.ac.uk/piprg/wiki/index.php?title=Installing_Linux_Kernel_2.6.23_on_the_PPC405_core_of_a_Xilinx_ML403_board
.
But I did not succeed to have the opb_emac driver in the config menu.
Could someone help to do this, or is there some patch to integrate the
xilinx opb_emac driver.
Thanks
-- 
View this message in context: http://www.nabble.com/linux-2.6.23-from-git.xilinx-and-opb_emac-driver-tp20788559p20788559.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
