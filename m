Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 78F93DDE05
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 19:38:16 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8U9cEWS012420
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 19:38:14 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8U9cFcq1433786
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 19:38:15 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8U9ZM3H020061
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 19:35:23 +1000
Message-ID: <46FF6E6A.30808@linux.vnet.ibm.com>
Date: Sun, 30 Sep 2007 15:07:46 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: 2.6.23-rc8-mm2 - PowerPC link failure at
	arch/powerpc/kernel/head_64.o
References: <20070927022220.c76a7a6e.akpm@linux-foundation.org>
	<46FF2199.2060202@linux.vnet.ibm.com>
In-Reply-To: <46FF2199.2060202@linux.vnet.ibm.com>
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Andrew Morton <akpm@linux-foundation.org>, sam@ravnborg.org,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kamalesh Babulal wrote:
> Hi Andrew,
> 
> The compilation with the cross compiler for the PowerPC-405 on the powerbox
> fails at linking
> 
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> ld: arch/powerpc/kernel/head_64.o(.text+0x80c8): sibling call optimization to `.text.init.refok' does not allow automatic multiple TOCs; recompile with -mminimal-toc or -fno-optimize-sibling-calls, or make `.text.init.refok' extern
> ld: arch/powerpc/kernel/head_64.o(.text+0x8160): sibling call optimization to `.text.init.refok' does not allow automatic multiple TOCs; recompile with -mminimal-toc or -fno-optimize-sibling-calls, or make `.text.init.refok' extern
> ld: arch/powerpc/kernel/head_64.o(.text+0x81c4): sibling call optimization to `.text.init.refok' does not allow automatic multiple TOCs; recompile with -mminimal-toc or -fno-optimize-sibling-calls, or make `.text.init.refok' extern
> ld: final link failed: Bad value
> make: *** [.tmp_vmlinux1] Error 1
> 

Adding CC to the powerpc mailing list

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
