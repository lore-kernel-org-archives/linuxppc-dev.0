Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CBEC5DDFE5
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 18:29:17 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id n0C7dsYH109598
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 18:39:55 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0C7LcGZ148070
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 18:21:39 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0C7LbNg009969
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 18:21:38 +1100
Date: Mon, 12 Jan 2009 12:51:32 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [BUG] 2.6.28-git-4 - powerpc - kernel expection 'c01 at
	.kernel_thread'
Message-ID: <20090112072132.GA8409@linux.vnet.ibm.com>
References: <20090102125752.GA5743@linux.vnet.ibm.com>
	<200901110108.20848.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200901110108.20848.rjw@sisk.pl>
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

* Rafael J. Wysocki <rjw@sisk.pl> [2009-01-11 01:08:19]:

> On Friday 02 January 2009, Kamalesh Babulal wrote:
> > Hi,
> > 
> > 	2.6.28-git4 kernel drops to xmon with kernel expection. Similar kernel
> > expection was seen next-20081230 and next-20081231 and was reported 
> > earlier at http://lkml.org/lkml/2008/12/31/157
> 
> Is this a regression from 2.6.27?
> 
> Rafael
>

This is not a regression from 2.6.27, this expection was first seen 
next-20081230 patches and then was introduced into 2.6.28-git4 and is 
reproducible with 2.6.28-rc1 kernel.

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
