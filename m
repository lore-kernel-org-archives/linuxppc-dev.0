Return-Path: <boris@fabiotec.com>
Received: from mtaout3.barak.net.il (mtaout3.barak.net.il [212.150.49.173])
	by ozlabs.org (Postfix) with ESMTP id 8CB9F67C37
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Nov 2006 03:53:43 +1100 (EST)
Received: from [192.168.200.97] ([62.90.35.117])
	by mtaout3.barak.net.il (Sun Java System Messaging Server 6.2-6.02
	(built Apr
	25 2006)) with ESMTPA id <0J8U00CIE1JBM210@mtaout3.barak.net.il> for
	linuxppc-embedded@ozlabs.org; Thu, 16 Nov 2006 18:52:24 +0200 (IST)
Date: Thu, 16 Nov 2006 18:52:26 +0200
From: Boris Shteinbock <boris@fabiotec.com>
Subject: Linux kernel 2.6 on Embedded Planet 8248 board
To: linuxppc-embedded@ozlabs.org
Message-id: <455C974A.1000106@fabiotec.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi. I am trying to bring up Linux kernel 2.6.16 on EP8248 board
and I am having some serious problems with console driver there, which 
doesn't work (console on SMC).
The kernel hangs after console_init() and BDM shows exception that I was 
unable to trace to any specific point.

I've got access to Arabella Linux 2.4 for this board, but it also 
doesn't work at all unfortunately. Just
for reference, u-boot 1.1.6 works quite well after some chip-select 
patching. so I am sure that the board is
functional.

Linux-related information for this board is quite sparse and couldn't 
find anything useful for me.
If any of you had successfully booted 2.6.* kernels on this board, I'd 
really appreciate some
help or perhaps platform-specific files that you've used.

Thanks in advance
