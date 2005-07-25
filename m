Return-Path: <va824363@albany.edu>
Received: from smtp.albany.edu (mail1.its.albany.edu [169.226.1.105])
	by ozlabs.org (Postfix) with ESMTP id 5FFA167D25
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jul 2005 01:32:15 +1000 (EST)
Message-ID: <13434.198.22.236.230.1122305525.squirrel@198.22.236.230>
In-Reply-To: <20050725071638.67632.qmail@web8503.mail.in.yahoo.com>
References: <20050725071638.67632.qmail@web8503.mail.in.yahoo.com>
Date: Mon, 25 Jul 2005 11:32:05 -0400 (EDT)
From: "Vikas Aggarwal" <va824363@albany.edu>
To: kernelnewbies@nl.linux.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: porting a  mm specific macro  from 2.4 to 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am porting a linux driver written for 2.4.28 to kernel 2.6.10. Have
question regarding a MACRO in my old driver.

#define __vpa(va)
((pte_val(*pte_offset(pmd_offset(pgd_offset_k(va),(va)),(va))) &
PAGE_MASK) + (va & ~PAGE_MASK))
Will the above MACRO work as is for 2.6.10 kernel? If not can someone help
me in making 2.6.10 compatible.

I saw in 2.6.10 pte_offset_kernel is introduced and also googling around
showed the pte_offset should be replaced by pte_offset_kernel.

Also my compilation fails when that MACRO expanded complaining
 "invalid type argument of `unary *'

The Linux kernel runs on Freescale's  MPC8248(ppc arch).

thanks in advance.
-vikas aggarwal
MS CS
SUNY, albany
