Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s40.bay0.hotmail.com (bay0-omc3-s40.bay0.hotmail.com
	[65.54.246.240]) by ozlabs.org (Postfix) with ESMTP id A2A5767C8A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Dec 2006 02:01:10 +1100 (EST)
Message-ID: <BAY110-F25EA12AA2D6F3C9FC4B15DB2DC0@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Kernel hangs after "Now booting the kernel" if Xilinx plb_temac
	driver included
Date: Thu, 07 Dec 2006 15:01:05 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear all,
I am trying to include the EDK-generated plb_temac driver in my 2.6.16 
kernel tree. Before I include the new driver, I used the one from 
http://source.mvista.com/~ank/paulus-powerpc/20060309/ for the old 
plb_temac and hard_temac cores. There is no problem and the kernel could 
run correctly with the 2.6.16 tree. Then to update the temac driver, I 
copied and overwrote the file xparameters_ml403.h, the files in 
EDK-generated BSP \drivers\net\xilinx_temac, and the files in 
\drivers\xilinx_common into the linux source tree and made some necessary 
and basic modifications. Finally I got a zImage.elf image. However 
unfortunately when I boot the kernel, it hangs after "Now booting the 
kernel" and nothing continues later. 

I noticed that there are some changes between the kernel files and the 
EDK-generated files for UART console driver.(I am using opb_uart16550 for 
UART.) Then I guess maybe the problem is on the UART console. But I am not 
sure. So if possible, I am anxious for the suggestions from other experts. 
Any idea on how to find out the problem? Thanks a lot for your help.

BR
Ming

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn  
