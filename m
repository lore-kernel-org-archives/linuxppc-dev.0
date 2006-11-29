Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s18.bay0.hotmail.com (bay0-omc3-s18.bay0.hotmail.com
	[65.54.246.218]) by ozlabs.org (Postfix) with ESMTP id 39481679E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Nov 2006 01:33:41 +1100 (EST)
Message-ID: <BAY110-F289C3474171EF7F5FA8CA8B2E40@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: akonovalov@ru.mvista.com
Subject: Some questions about the Xilinx Temac driver.
Date: Wed, 29 Nov 2006 14:33:37 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Andrei,
I have some questions about your xilinx Temac driver. If possible, please 
give me a hand on such confusing problems. 

1. I am using the driver from 
http://source.mvista.com/~ank/paulus-powerpc/20060309/, and the IP cores of 
plb_temac and hard_temac whose hardware versions are 2.00a and 1.00a 
specifically. I know the newest versions of those hardwares are 3.00a and 
3.00a. Is your driver support the 3.00a version hardware? Also, is the 
driver from http://source.mvista.com/~ank/paulus-powerpc/20060309/ the 
latest one for Xilinx Temac? If you have some updated version, please tell 
me the address. 

2. Is that driver from the above address able to support SGDMA? In fact, I 
am testing the throughput of the Temac enet by my own little program which 
is very simple. In the program running on the board, the pseudo code looks 
just like this:
     for(;;){
           select();
           if(FD_ISSET()){
                 recvfrom();
           }
           
           sendto();
     }

The program is just to receive packets from a pc and then transfer them 
back. But in this condition, the embedded PowerPC CPU is easily used by 
100&. So I suspect that maybe the DMA is not running properly. Could you 
please say something about the DMA in your driver? 

Thanks a lot for your telling.

Regards
Ming

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn/  
