Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0F45BDDE45
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 20:59:17 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9IAwqU0025874
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 06:58:52 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9IAwqbC064294
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 06:58:52 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9IAwkmg013778
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 06:58:46 -0400
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Yuri Tikhonov <yur@emcraft.com>
In-Reply-To: <200710181108.19413.yur@emcraft.com>
References: <200710181108.19413.yur@emcraft.com>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 05:44:08 -0500
Message-Id: <1192704248.13993.36.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-10-18 at 11:08 +0400, Yuri Tikhonov wrote:
>  Hello,
> 
>  The following patch adds support for 256KB PAGE_SIZE on ppc44x-based boards. 
> The applications to be run on the kernel with 256KB PAGE_SIZE have to be 
> built using the modified version of binutils, where the MAXPAGESIZE 
> definition is set to 0x40000 (as opposite to standard 0x10000).

Sorry, this is against arch/ppc which is bug fix only.  New features
should be done against arch/powerpc.  Also, I'd rather see something
along the lines of hugetlbfs support instead.

josh
