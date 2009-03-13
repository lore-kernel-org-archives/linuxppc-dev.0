Return-Path: <jhautbois@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id 0F7C9DE13F
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 00:38:57 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id k4so901918nfd.9
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 06:38:55 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 13 Mar 2009 14:38:55 +0100
Message-ID: <8cad0aa0903130638w6fab6299kcd23d92d4c2d0a8@mail.gmail.com>
Subject: [MPC8272ADS]Can not configure the ttyCPM0
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all !

I am currently facing a big problem on my MPC8272ADS development board.
I have tried to use the /dev/ttyCPM1 port in order to send data over
the serial cable to another device.

This is just not working but nothing is sent, my DTR signal is down:

> cat /proc/tty/driver/ttyCPM
0: uart:CPM UART mmio:0xF0011A00 irq:40 tx:296 rx:0 RTS|CTS|DTR|DSR|CD
1: uart:CPM UART mmio:0xF0011A60 irq:43 tx:0 rx:0 CTS|DSR|CD

So, I have tried to use the serial port /dev/ttyCPM0. It is
successfully sending out my bytes, but I can't configure it !!
When I am trying to use the tcsetattr() function, I don't have any
error, but the signal is always the same (no effect, if you prefer).

I have tried to disable the kernel console output, but it is not
working, either...

Can anyone help me ?
Thanks in advance !
Best Regards,

JM
