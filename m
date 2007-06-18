Return-Path: <xenidis@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.228])
	by ozlabs.org (Postfix) with ESMTP id 23189DDEDC
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 05:45:59 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id t13so1375417wxc
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 12:45:58 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <F4482BED-242B-42AD-96FF-3CB14B6BC5BE@watson.ibm.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: CONFIG_PS3_USE_LPAR_ADDR dramically increases boot time
Date: Mon, 18 Jun 2007 15:45:43 -0400
From: Jimi Xenidis <jimix@pobox.com>
Sender: Jimi Xenidis <xenidis@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following change set:
   http://git.kernel.org/?p=linux/kernel/git/paulus/ 
powerpc.git;a=commit;h=261efc3f178c8c5b55d76208aee1f39ce247f723

setting CONFIG_PS3_USE_LPAR_ADDR (which is the default for PS3)  
changes increases MAX_PHYSADDR_BITS  from 44 to 47 which makes the  
array 8 time bigger and takes way longer for sparse_init() to run on  
simulator.

Is this really the right approach?
Cell is actually 42 so could not the special address space be 43 or 44?

-JX
