Return-Path: <wuyinliangpin00@hotmail.com>
Received: from bay0-omc1-s35.bay0.hotmail.com (bay0-omc1-s35.bay0.hotmail.com
	[65.54.246.107]) by ozlabs.org (Postfix) with ESMTP id 68B5ADDF0C
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 12 Aug 2007 12:50:43 +1000 (EST)
Message-ID: <BAY117-F32033EE00655919C556AB9A9E30@phx.gbl>
From: =?gb2312?B?0Owg1Ms=?= <wuyinliangpin00@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: no words output in console on 852t board with kernel 2.6.15 
Date: Sun, 12 Aug 2007 10:50:39 +0800
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

Hello all,

I try to run  linux 2.6.15  on a 852T custom board but can't see any words 
by console.
I have located the problem with leds and see that the program hangs in 
function dma_alloc_coherent of cpm_uart_allocbuf in file cpm_uart_cpm1.c.


Is there anyone who has already seen similar problem or can give some 
advise?
my kernel configure bases on TQM850L_defconfig and use smc1 as uart .

Thanks
xuyun00

...............

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
