Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id B2D472BDB5
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Jan 2005 12:16:43 +1100 (EST)
Received: from mailman.pit.comms.marconi.com (mailman.pit.comms.marconi.com
	[169.144.2.12])
	by mailgate.pit.comms.marconi.com (8.12.10+Sun/8.12.10) with ESMTP id
	j0G0v8DR017804
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jan 2005 19:57:09 -0500 (EST)
Received: from uspitsmsgrtr01.pit.comms.marconi.com
	(uspitsmsgrtr01.pit.comms.marconi.com [169.144.2.221])
	by mailman.pit.comms.marconi.com (8.9.3/8.9.3) with ESMTP id TAA12770
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jan 2005 19:57:08 -0500 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A6474E3@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>
Date: Sat, 15 Jan 2005 19:55:24 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: Linux 2.6-10.rc3  8xx: Only 3 characters are printed well in  __i
	n it start_kernel() upon kernel booting
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

__init start_kernel() in init/main.c 

... 
lock_kernel();
page_address_init();
printk(linux_banner);
setup_arch(&command_line);
setup_per_cpu_areas();
...

Are interrupts enabled in above code ?
If so, could I somehow disable interrupts and switch to the "polling mode"
of the serial driver (drivers/serial/cpm_uart/cpm_uart_core.c) just before
printk() ?

Thanks,
Alex
