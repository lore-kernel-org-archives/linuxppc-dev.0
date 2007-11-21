Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AC402DDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 19:06:35 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id lAL86VS8021020
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 19:06:31 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAL86YI52080816
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 19:06:34 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAL86XWS000837
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 19:06:34 +1100
Message-ID: <4743E706.6010504@linux.vnet.ibm.com>
Date: Wed, 21 Nov 2007 13:36:30 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-rc3-mm1- powerpc link failure
References: <20071120204525.ff27ac98.akpm@linux-foundation.org>
In-Reply-To: <20071120204525.ff27ac98.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII
Cc: sfr@canb.auug.org.au, Balbir Singh <balbir@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andrew,

The kernel build fails on powerpc while linking,

  AS      .tmp_kallsyms3.o
  LD      vmlinux.o
ld: TOC section size exceeds 64k
make: *** [vmlinux.o] Error 1

The patch posted at http://lkml.org/lkml/2007/11/13/414, solves this 
failure.

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
