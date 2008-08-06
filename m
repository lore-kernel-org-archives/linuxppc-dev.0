Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 8FEC0DDEE8
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Aug 2008 21:17:15 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KQh0u-0005Sz-Qp
	for linuxppc-embedded@ozlabs.org; Wed, 06 Aug 2008 04:17:08 -0700
Message-ID: <18849083.post@talk.nabble.com>
Date: Wed, 6 Aug 2008 04:17:08 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Two processes accessing the same mapped physical memory
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

In my driver i have mapped the SDRAM memory to user space using mmap.
Application can directly access to this physical memory but how can i ensure
that no other process will write to this memory location as long as my
application is having the access to this memory (unlees it unmaps)

For testing this i have written a simul driver which also maps the same
memory of SDRAM and a test application to access it when i run the two
application (actual and test ) ,both of them were accessing the memory and
writing and reading to it. 

What is the mechanism to lock this memory (SDRAM in my case )so that no
other process should access it unless and until my process unmaps it or gets
killed.

--- Misbah <><


-- 
View this message in context: http://www.nabble.com/Two-processes-accessing-the-same-mapped-physical-memory-tp18849083p18849083.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
