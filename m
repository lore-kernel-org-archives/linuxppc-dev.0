Return-Path: <eemingliu@hotmail.com>
Received: from hotmail.com (bay110-f1.bay110.hotmail.com [65.54.229.11])
	by ozlabs.org (Postfix) with ESMTP id 901E1679FB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 18:22:48 +1000 (EST)
Message-ID: <BAY110-F197CC0259C9877D5B47F3B29B0@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: grant.likely@secretlab.ca
Subject: Tri-mode or gigebit ethernet support problem in ML403
Date: Tue, 23 May 2006 08:22:46 +0000
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

Hi Grant,
I want to ask you a problem about the 1000M ethernet support. Now I am 
trying to integrate a linux (2.4 or 2.6) in my ML403 platform, with 
tri-mode ethernet support. And I have downloaded many versions of linux, 
including linuxppc_2_4_devel, MontaVista linux 3.1 Preview 
Kit(v2.4.20_mvl31-ml300), and linux-xilinx-26. Unfortunately, I didn't find 
any option in the menuconfig item Network Device Support->ethernet 
(1000Mbit) for me to enable the 1000M ethernet in all three versions. So I 
have the following questions to ask.

1. With Xilinx Virtex 4 tri-mode ethernet MAC support, which version of 
Linux shall I use? I think I should choose a version with Xilinx On-chip 
Ethernet supported in the 1000M ethernet item in menuconfig. 

2. Assume that you can provide me a proper version. Shall I use Xilinx EDK 
to generate the BSP for my platform and copy the source code to overwrite 
the drivers in the original version. Then configure the kernel and enable 
1000M ethernet (choose Xilinx on-chip ethernet). Then compile the 
kernel...... Are these steps correct? 

Thanks for your help. I am really confused about this problem. Also others 
who can help me are welcome. :)

Best Regards
Ming

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
