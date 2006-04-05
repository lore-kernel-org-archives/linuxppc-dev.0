Return-Path: <eemingliu@hotmail.com>
Received: from hotmail.com (bay110-f12.bay110.hotmail.com [65.54.229.22])
	by ozlabs.org (Postfix) with ESMTP id 34C4B679EA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Apr 2006 02:20:01 +1000 (EST)
Message-ID: <BAY110-F12AEECB510AD5DC78CDEDEB2CB0@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: help. a question on "make menuconfig"
Date: Wed, 05 Apr 2006 16:02:54 +0000
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

Hi,
I am a novice for embendded linux. My platform is Xilinx Virtex4 (PPC405). 
I have downloaded the kernal source of linuxppc_2_4_devel and modified the 
Makefile as:
ARCH := ppc
CROSS_COMPILE = powerpc-405-linux-gnu-

But when I execute "make menuconfig", the following error happens,

mingliu@linux:~/linuxppc_2_4_devel> make menuconfig 
make: *** arch/ppc: Is a directory.  Stop. 
mingliu@linux:~/linuxppc_2_4_devel> 

Why this error happened? Is there something wrong with the Makefile? I did 
nothing except for specifying the ARCH and the CROSS_COMPILE.

Thanks for your help.

                                                              BR
                                                                 Ming

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
