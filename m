Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s13.bay0.hotmail.com (bay0-omc1-s13.bay0.hotmail.com
	[65.54.246.85]) by ozlabs.org (Postfix) with ESMTP id AB52B67A3E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jul 2006 22:49:33 +1000 (EST)
Message-ID: <BAY110-F18951B1690B257545F5EEB2770@phx.gbl>
In-Reply-To: <44A580F5.8050900@gmail.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: ammubhai@gmail.com
Subject: Xilinx BSP for linux 2.6
Date: Thu, 06 Jul 2006 12:49:27 +0000
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

Dear Ameet,
Now I am using your patch for SystemACE in Linux 2.6. My linux version is 
2.6.16-rc5 and I have applied the patch for SystemACE and Temac. 

When I generate BSP in EDK, how can I implement it in my linux kernel? I 
know the EDK BSP is for Linux 2.4 and the directory stucture is the same as 
2.4(e.g. arch/ppc/platform/xilinx_ocp/......) But in 2.6, the directory 
tree is different and I cannot simply copy and replace the original files 
there. Also, there is a file called xparameters_ml403.h in Linux kernel but 
in BSP there is only xparameters_ml300.h. Shall I rename the 
xparameters_ml300 as ml403, or configure the board as ml300 in menuconfig? 
In these xparameters files, the peripheral addresses are defined. How can I 
include these xparameters defination in the kernel? It looks complicate and 
you didn't mention how to replace these files in your article. So if you 
can provide some guidance, I will appreciate a lot because it will save me 
much time. 

By the way, I am still waiting for the last part of your article. Where are 
they? :)

Thanks for your help.

Regards
Ming

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
