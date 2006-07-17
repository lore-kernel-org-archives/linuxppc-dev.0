Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	by ozlabs.org (Postfix) with ESMTP id 5BC49679E7
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 06:23:12 +1000 (EST)
Received: from zcarhxs1.corp.nortel.com
	(zcarhxs1.corp.nort...s0.corp.nortel.com [47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id
	k6HK73a23998
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2006 16:07:03 -0400 (EDT)
Message-ID: <44BBEDE1.3040004@nortel.com>
Date: Mon, 17 Jul 2006 14:06:57 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: kernel memory map/usage/holes?
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I've got a Maple board with 4GB of memory running a modified 2.6.10 
kernel.  When it boots, I see the following in the logs:


Top of RAM: 0x180000000, Total RAM: 0x100000000
On node 0 totalpages: 1048576
   DMA zone: 1048576 pages, LIFO batch:16
   Normal zone: 0 pages, LIFO batch:1
   HighMem zone: 0 pages, LIFO batch:1


Then a bit later, I see:


Memory: 4006976k/6291456k available (3408k kernel code, 2284124k 
reserved, 1656k data, 448k bss, 220k init)



1048576 pages works out to 4194304kB, so what happened to the 187328kB 
that is the difference between the "Total RAM" and "Memory:" lines? 
We've got an app that wants as much memory as possible, so I need to 
explain where this 183MB of memory is being used.

Thanks,

Chris
