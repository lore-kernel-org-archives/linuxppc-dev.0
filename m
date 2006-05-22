Return-Path: <eemingliu@hotmail.com>
Received: from hotmail.com (bay110-f12.bay110.hotmail.com [65.54.229.22])
	by ozlabs.org (Postfix) with ESMTP id AA3F267A3F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 01:26:36 +1000 (EST)
Message-ID: <BAY110-F120770D9A80B5FC8BF9797B29A0@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: akonovalov@ru.mvista.com
Subject: Gigabit ethernet support question about linux 2.6 on ML403 board
Date: Mon, 22 May 2006 15:09:28 +0000
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

Hello Andrei,
I noticed that you are the owner of the Xilinx Virtex Development tree. Now 
I am trying to integrate a linux-xilinx-26 kernel in my ML403 Virtex 4 
platform, with tri-mode (or gigabit) ethernet supported. In the menuconfig, 
I haven't found an option in Ethernet (1000 Mbit) to enable the gigabit 
ethernet (I have chosen the processor as ppc 40x and the platform as 
ML403.). Also, in the Ethernet (10 or 100Mbit), there is no option for 
Xilinx on-chip ethernet. Could you please tell me how can I include a 
tri-mode ethernet MAC supported by my platform in linux-xilinx-26? Thanks a 
lot for your precious reply. 

Best Regards
Ming

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
