Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 33788DDDEB
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 03:53:30 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id lAFGrQST018574
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 03:53:26 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAFGrTFV618660
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 03:53:29 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAFGrT8v030891
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 03:53:29 +1100
Message-ID: <473C7B16.3050700@linux.vnet.ibm.com>
Date: Thu, 15 Nov 2007 22:30:06 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: 2.6.24-rc1 on PPC64: machine check exception
References: <472F1F4C.3010507@linux.vnet.ibm.com>
	<20071105154055.GA4746@kryten>
	<472F5C5E.4030607@linux.vnet.ibm.com>
In-Reply-To: <472F5C5E.4030607@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc <linuxppc-dev@ozlabs.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
>> http://patchwork.ozlabs.org/linuxppc/patch?id=14475
> 
> Thanks for pointing me to this patch.  I will try out and let you know if
> this fixed the problem.

Hi Anton,

This patch fixed the problem.  I am able to run and profile ebizzy on 128-way
PPC64.  However this fix is not included in 2.6.24-rc2 as well.
I will watch for inclusion of this fix in 2.6.24.

--Vaidy
