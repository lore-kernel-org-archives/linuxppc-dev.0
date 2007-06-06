Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s23.bay0.hotmail.com (bay0-omc2-s23.bay0.hotmail.com
	[65.54.246.159]) by ozlabs.org (Postfix) with ESMTP id 18B21DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jun 2007 05:30:33 +1000 (EST)
Message-ID: <BAY138-F6B2DA6BEF021C7026E522B2270@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: a question on "iowrite32()"
Date: Wed, 06 Jun 2007 19:30:28 +0000
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
I am writing a device driver for my customized PLB hardware module on my 
PPC405 & Xilinx ML403 architecture. In the driver code, I use a 
"iowrite32()" function to initiate a DMA transfer. However, I found that if 
I program as "iowrite32(0x12345678, address);", actually I am writing 
0x87654321 to that address. However if I write a standalone program without 
a Linux OS, the Xilinx function "XIo_Out32()" just write the correct value 
0x12345678 into address. Can anyone explain my why this happens? I know 
that PPC405 is a big-endian system. But I don't think this is a endian 
problem. After all endian is only an issue of the CPU architecture, not the 
OS. Am I right?

Thanks for your hints.

BR
Ming

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
