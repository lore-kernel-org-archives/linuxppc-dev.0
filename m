Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C38A1DE082
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jan 2008 03:42:27 +1100 (EST)
Received: from dale by xyzzy.farnsworth.org with local (Exim 4.68)
	(envelope-from <dale@farnsworth.org>) id 1JCdRj-0007tS-Pi
	for linuxppc-embedded@ozlabs.org; Wed, 09 Jan 2008 09:06:31 -0700
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <OF590B6FCB.576A8335-ON482573CB.00169CC3@alphanetworks.com>
Cc: 
Message-Id: <E1JCdRj-0007tS-Pi@xyzzy.farnsworth.org>
From: Dale Farnsworth <dale@farnsworth.org>
Date: Wed, 09 Jan 2008 09:06:27 -0700
Subject: Re: Use 2G RAM in 8548, vmalloc fail, adjust_total_lowmem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I am using a MCP8548 board with 2.6.14.5 kernel.
> And I would like to upgrade memory from 512MB to 2048MB.
> Finally, I realize this is not so easy as I think. I encounter several
> problems. :~~
> 
> First, I change mem=512M to mem=2048M.
> 
> 1. vmalloc fail problem
> So, I change kernel config in "advanced setup"
> Change  "Set maximum low memory" from 0x30000000 to 0x80000000.
> Change "Virtual address of kernel base" from 0xC0000000 to 0x60000000.
> Change "Set custom user task size" from 0x80000000 to 0x60000000

Just enable CONFIG_HIGHMEM=y to use your 2GB.  It's not worth the effort
to try making it all accessible as lowmem.

-Dale
