Return-Path: <rza1@so-logic.co.at>
Received: from mail.so-logic.net (mail.so-logic.net [62.99.208.149])
	by ozlabs.org (Postfix) with ESMTP id 19C6A679FB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jul 2006 03:57:22 +1000 (EST)
Received: from localhost (mail.so-logic.net [62.99.208.149])
	by mail.so-logic.net (Postfix) with ESMTP id F310E1560A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jul 2006 19:31:25 +0200 (CEST)
Received: from [192.168.1.196] (62-99-208-147.c-vbergg.xdsl-line.inode.at
	[62.99.208.147])
	by mail.so-logic.net (Postfix) with ESMTP id EA72B15607
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jul 2006 19:31:07 +0200 (CEST)
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <60EDCAFB-0AFB-4EAC-A6A0-DFF7C02A90F1@so-logic.co.at>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linuxppc-embedded@ozlabs.org
From: Robert Zach so-logic <rza1@so-logic.co.at>
Subject: using BRAM for heavly used Code (on Virtex4fx)
Date: Wed, 26 Jul 2006 19:56:40 +0200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

I am working on an ml403 board (virtex4 with ppc core). I am  
sucessfully using Linux 2.4 and 2.6.
I have done a few performance tests with networking, applications...

In the Virtex 4 is it possible to use BRAM(which are 10 times faster  
then the normal RAM)...
I would like to connect this BRAMS in a special address area...

Questions:
1.1. Is it possible to write a linker script, that places heavly used  
Code(or importend Interrupt Routines...) of the kernel in my special  
Adress Area(on the BRAM)?
Has anyone already written such a Linker script?

1.2. Or do I have to tell the bootloader to copy the special  marked 
(how?) heavly used Code in this special Area?
Has anyone done such a thing?


2. Is there a way to tell the Kernel to place heavily used  
Application Code or Data automatically in my special Adress Area?
Has anyone worked on such a thing?


Nice greetings
Robert
