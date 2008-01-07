Return-Path: <rwoodworth@securics.com>
Received: from securics.com (mail.securics.com [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id D7D29DDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jan 2008 05:12:59 +1100 (EST)
Received: from [192.168.1.182] (unknown [192.168.1.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by securics.com (Postfix) with ESMTP id 59109B8C0B8
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Jan 2008 10:42:24 -0700 (MST)
Subject: MMU failure, Virtex4-FX60
From: Robert Woodworth <rwoodworth@securics.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Mon, 07 Jan 2008 10:42:24 -0700
Message-Id: <1199727744.17452.8.camel@PisteOff>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello!

I'm building a new Virtex4-FX60 device.  I have built it with the new
MPMC3 and a 256MB SO-DIMM.  It works successfully with a "mem-test" type
embedded program.

I cannot get it to boot a Linux kernel.  I have traced it down to the
MMU not getting mapped correctly. 

I can load the kernel via jtag, get the pre-boot messages on the serial
but then when it tries to jump to 0xc0002218 (start_here: head_4xxx.S)
it fails with a "Machine check exception; invalid instruction address".

Using the debugger and examining the memory once the mmu is suppose to
be configured, I see that it is not mapping 0xc0000000  to the proper
location.  I'm sure I've set something up wrong in my FPGA and I need to
re-synthesize.  But what?


Any hints on which registers to look for or what I need to do??



RJW.
