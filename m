Return-Path: <boardbringup@hotmail.com>
Received: from bay0-omc1-s5.bay0.hotmail.com (unknown [65.54.246.77])
	by ozlabs.org (Postfix) with ESMTP id 35A1EDDE2B
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 03:50:52 +1100 (EST)
Message-ID: <BAY112-F343E40D8DEF46C97D4C645C0AF0@phx.gbl>
From: "Suresh Chandra Mannava" <boardbringup@hotmail.com>
To: linuxppc-dev@ozlabs.org
Subject: please: linux-2.5-20 -rc2 16550 serial console problem
Date: Sun, 21 Jan 2007 22:20:50 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,
I am working on porting linux-2.6.20-rc2 (DENX) kernel to our board. It 
consists of powerpc MPC7410, IBM CPC700 system controller and couple of AMD 
79C972 network chips.
I am using gcc version 4.0.0 (DENX ELDK 4.0 4.0.0) cross compiler for this 
task.
I followed IBM spruce which consists of CPC700. CPC700 serial port is 16550 
compatible.
I can see printk's  on serial console till "Freeing unused kernel memory", 
this happens before starting of init.
I enabled debug statements in 8250.c and found some messages "like 
serial8250_interrupt(3)...end" and kernel freezes ( I attached serial 
console messages). ttyS0 is using interrupt 3.

I assume it is not a tool chain or ramdisk image problem because I ported 
linux-2.4 (DENX) with the same tool chain and ramdisk image.
Serial console is working fine in linux-2.4.

I request you to provide some pointers for the same.

Thanks,
Suresh

_________________________________________________________________
Do women make better employees? Join the debate 
http://msnspecials.in/debate/topicdetails.aspx?TID=64
