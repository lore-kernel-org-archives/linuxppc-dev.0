Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 115C468863
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 07:19:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 1 Dec 2005 14:18:58 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8594B7@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Matt Porter" <mporter@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: PPC 32bits and big RAM mapping problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Matt Porter [mailto:mporter@kernel.crashing.org]=20
> Sent: Thursday, December 01, 2005 12:56
> If you have 2GB you had to have something else. Right now
> you have it set to constrict the max lowmem to 1GB. So,
> you must have CONFIG_HIGHMEM on as well to utilize the
> other 1GB.

Ahh.. Yep, have CONFIG_HIGHMEM set.

I only did 1G of kernel low mem, so that there still would be space left
for vmalloc mappings.
I have a 8265 witch uses 0xf0000000 and up for internal stuff and flash,
so with 1G lowmem and kernel baseadr set to 0xa.... I have 0xe0000000 to
0xeffffffff for virtual address space.

I do not remember if I had to patch some other parts of the kernel also.
I do not think I did.
Can't chech right now either, because we used bitkeeper and I cannot
even check the commit logs anymore.
