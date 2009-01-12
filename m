Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B433DDE23
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 19:37:42 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id n0C8baU0026615
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 14:07:36 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0C8bfW61540212
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 14:07:41 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.13.1/8.13.3) with ESMTP id n0C8bZWd001442
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 19:37:36 +1100
Date: Mon, 12 Jan 2009 14:07:34 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [BUG] 2.6.28-git-4 - powerpc - kernel expection 'c01 at
	.kernel_thread'
Message-ID: <20090112083734.GB8409@linux.vnet.ibm.com>
References: <20090102125752.GA5743@linux.vnet.ibm.com>
	<200901110108.20848.rjw@sisk.pl>
	<20090112072132.GA8409@linux.vnet.ibm.com>
	<200901120907.20418.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200901120907.20418.rjw@sisk.pl>
Cc: sfr@canb.auug.org.au, linux-mm@kvack.org, mel@csn.ul.ie,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Rafael J. Wysocki <rjw@sisk.pl> [2009-01-12 09:07:19]:

> On Monday 12 January 2009, Kamalesh Babulal wrote:
> > * Rafael J. Wysocki <rjw@sisk.pl> [2009-01-11 01:08:19]:
> > 
> > > On Friday 02 January 2009, Kamalesh Babulal wrote:
> > > > Hi,
> > > > 
> > > > 	2.6.28-git4 kernel drops to xmon with kernel expection. Similar kernel
> > > > expection was seen next-20081230 and next-20081231 and was reported 
> > > > earlier at http://lkml.org/lkml/2008/12/31/157
> > > 
> > > Is this a regression from 2.6.27?
> > > 
> > > Rafael
> > >
> > 
> > This is not a regression from 2.6.27, this expection was first seen 
> > next-20081230 patches and then was introduced into 2.6.28-git4 and is 
> > reproducible with 2.6.28-rc1 kernel.
> 
> Presumably you meant 2.6.29-rc1 ?  In which case it would be a regression from
> 2.6.28 .  Please confirm.
> 
> Thanks,
> Rafael
> 
sorry, I meant it was introduced in 2.6.28-git4 and is still reproducible
with 2.6.29-rc1.

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
