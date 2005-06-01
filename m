Return-Path: <andreas_schmidt@ifm-electronic.com>
Received: from mail1.ifm-electronic.com (mail1.ifm-electronic.com
	[62.180.229.59]) by ozlabs.org (Postfix) with ESMTP id DD201679E1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Jun 2005 01:35:41 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF544D6698.91FE4535-ONC1257013.005459BC-C1257013.00558BDF@ifm-electronic.com>
From: andreas_schmidt@ifm-electronic.com
Date: Wed, 1 Jun 2005 17:34:23 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: linux2.4.24 on Memec EVB no output on console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi at all

I have already postet this problem there but i want make some adds there.

Configs:
I use Memec EVB with Virtex2Pro
u-boot 1.1.2
linux2.4.24 with modify ml300 config

I ported u-boot on this board and can download the uImage from the ethernet.

Problem:
Atfer uncompressing the kernel I get no output on console

=> bootm
## Booting image at 00400000 ...
   Image Name:   Linux-2.4.24-pre2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    720036 Bytes = 703.2 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

I have oportunity to debug the kernel and I can see that the kernel runs!
It write something in buffer and init the serial driver. But somewhere it get illegal
kernel access and thhe kernel call exeption handler. On which point  the problem is I
can't say because I can't find the start address from kernel, to set a breakpoint there
and debug. I can only stop the processor and then debug.

Perhaps had someone the same problems and can help me.

Many thangs for any help!

best regards,

Andreas
