Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F638DDF8D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 23:20:30 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HjbE3-0003hD-DJ
	for linuxppc-embedded@ozlabs.org; Thu, 03 May 2007 15:20:03 +0200
Received: from 222.90.193.92 ([222.90.193.92])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 03 May 2007 15:20:03 +0200
Received: from cuifeng226 by 222.90.193.92 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 03 May 2007 15:20:03 +0200
To: linuxppc-embedded@ozlabs.org
From: feng <cuifeng226@163.com>
Subject: pci based on mpc8250
Date: Wed, 2 May 2007 09:11:33 +0000 (UTC)
Message-ID: <loom.20070502T105747-533@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi all:
  I have been working on my pci for about 2 mounths ,but I can't work it out.
I list the problems I encounter here.Any suggestion will be welcome.
  We want to send 208 bytes per frame.but it was send in several frames.
We try to disalbe the snoop bit in our program ,choose another dma band 
width.the result it we can speed up the speed ,but it can't be checked  
through by our check program.what confused us is that the data gets by our 
software transferes through  the hardware is right .
  some one suggests that:
   When snooping is not used and a memeory region is cacheable, you should 
invalidate cache area (executing as much DCBI instructions as required) 
corresponding to the transfer region after each transfer before read it by the 
core. Refer to the Programming Environments Manual for 32-Bit Implementations 
of the PowerPC Architecture, Chapter 8 Instruction Set, dcbi.


 our Latency Timer Register value  is 0xc4,and the cachline is 0x8

thank you for you attention.
 feng
