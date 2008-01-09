Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by ozlabs.org (Postfix) with ESMTP id C84D2DDE01
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 11:11:54 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so22684rvf.9
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jan 2008 16:11:52 -0800 (PST)
Message-ID: <5c9cd53b0801081611ve59e9a8q6ae2fd227bfc0ed8@mail.gmail.com>
Date: Tue, 8 Jan 2008 19:11:52 -0500
From: "mike zheng" <mail4mz@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: printk() does not work on UART1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

I have one mpc8568 board using UART1 as the serial port.  The OS is
Linux Kernel2.4.  If I use the polling mode driver of
gen550_progress(), it works fine. However the printk() does not work
after the console_init(). Anyone know what shall I change in the
kernel to use UART1 as serial console? I assume the default is UART0,
but I don't know where the value is set. I changed the CONFIG_CMDLINE
to ttyS1, it does NOT work.

Thanks for your help,

Mike
