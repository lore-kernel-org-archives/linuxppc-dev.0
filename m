Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s28.bay0.hotmail.com (bay0-omc1-s28.bay0.hotmail.com
	[65.54.246.100]) by ozlabs.org (Postfix) with ESMTP id 3408B67BDC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Dec 2006 21:07:42 +1100 (EST)
Message-ID: <BAY110-F2437D558E178369DB8669CB2D00@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: how to cross-compile netperf.
Date: Mon, 11 Dec 2006 10:07:38 +0000
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
Maybe my question is not proper for this maillist but I really see some 
friends who are using netperf to measure the netowrk performance from this 
maillist. So I ask for help here. 

Could anyone please tell me how to cross-compile the Netperf which could be 
run on my PowerPC 405 processor? I cannot find a detailed explanation from 
the manual. After the downloading and untaring the package, I use the 
command "./configure --host ppc CC=powerpc-405-linux-gnu-gcc". However 
unfortunately it doesn't work and error " checking whether setpgrp takes no 
argument... configure:error: cannot check setpgrp when cross compiling" 
appears. My host system is X86_64 PC with linux OS and my target system is 
PowerPC 405(Xilinx Virtex 4 FPGA) with linux too(embedded Ml403 board from 
Xilinx company). In my condition, which arguments shall I specify? 

If anyone can help, I wll really appreciate a lot.

Thanks a lot.

BR
Ming

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
