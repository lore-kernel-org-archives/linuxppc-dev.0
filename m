Return-Path: <prakash@ipinfusion.com>
Received: from gateway.ipinfusion.com (mail.ipinfusion.com [65.223.109.2])
	by ozlabs.org (Postfix) with ESMTP id F1B7967B5D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Sep 2006 06:32:50 +1000 (EST)
Received: from [10.10.0.196] ([10.10.0.196])
	by gateway.ipinfusion.com (8.11.6/8.11.6) with ESMTP id k8FJrUc30033
	for <linuxppc-embedded@ozlabs.org>; Fri, 15 Sep 2006 12:53:30 -0700
Message-ID: <450B058B.6060806@ipinfusion.com>
Date: Fri, 15 Sep 2006 12:56:59 -0700
From: Prakash Jain <prakash@ipinfusion.com>
MIME-Version: 1.0
To: Linux PPC List <linuxppc-embedded@ozlabs.org>
Subject: Kernel module insertion issue with kernel 2.6.15
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
I am relatively new to this list/area, not sure if this is right forum 
for my query (please point me to right list in that case).

I am porting my software from 2.4 kernel to 2.6.15 on a board similar to 
ppc 82xx  sandpoint architecture. I am able to make the board functional 
except the following issue. One of my kernel module (inserted thru 
insmod) takes almost 6-7 minutes to load with 2.6 kernel while it used 
to take only few seconds with 2.4 kernel. Yet, after the long wait 
module is inserted correctly with 2.6 kernel as board software works 
fine after that. When I halt the processor (using BDI2000) during the 
long wait, it always halts in function get_plt_size() in kernel's 
arch/ppc/kernel/module.c. Single stepping does not take to any error or 
suspicious place. Looks like it is going thru the long for() loop in the 
function. Only suspicion I got is while compiling the module, it 
generates tons of undefined symbols. I ignored them as it was a third 
party software and module inserts correctly at the end.

Can someone give few pointers on what could be the reasons and where to 
look to resolve this? Will appreciate your time,
Thanks,
Prakash
