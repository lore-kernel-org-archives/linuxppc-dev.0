Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s20.bay0.hotmail.com (bay0-omc2-s20.bay0.hotmail.com
	[65.54.246.156]) by ozlabs.org (Postfix) with ESMTP id DB22967C62
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Oct 2006 00:28:05 +1000 (EST)
Message-ID: <BAY110-F990057FF58BF5A4F24763B20D0@phx.gbl>
From: "Ming Liu" <eemingliu@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: how to reserve memory in linux?
Date: Fri, 20 Oct 2006 14:27:59 +0000
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
My situation is, I want to reserve some amount of memory and make it shared 
by both Linux kernel and another hardware peripheral. That is, when I boot 
linux and execute some user space programs, this part of memory should be 
reserved for other use and cannot be used by both the kernel and those 
applications. But it could be accessed by Linux with some certain kind of 
application and also be accessed by another hardware peripheral with DMA or 
something like that. 

I am not sure if I am right but I think it's just like the situation of 
multiprocessing (if we can treat that hardware peripheral as another 
processor, or just use another processor to realize its functions.) and 
that part of memory is just like the hardware shared memory by 
multiprocessor. Am I right? 

Then my question is, how to reserve such part of memory in Linux? Does 
Linux has such a function? 

I am not falimiar with such a topic, so any hint related to this is 
appreciated.

Thanks for your ideals and suggestions.

Regards
Ming

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
