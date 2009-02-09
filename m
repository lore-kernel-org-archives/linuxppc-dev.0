Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1BFFBDDDA0
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Feb 2009 18:19:26 +1100 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id n197ICrl005313
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Feb 2009 18:18:12 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n197JdgY1110080
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Feb 2009 18:19:39 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n197JKXx005549
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Feb 2009 18:19:21 +1100
Message-ID: <498FD8F7.8010103@in.ibm.com>
Date: Mon, 09 Feb 2009 12:49:19 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: 2.6.29-rc4-git1 build break : cell/spu_profiler.o
References: <498FD09D.2070207@in.ibm.com>
	<20090209175043.04889757.sfr@canb.auug.org.au>
In-Reply-To: <20090209175043.04889757.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org, arnd@arndb.de,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> See http://patchwork.ozlabs.org/patch/22628/
Thanks Stephen. The above patch fixed this build break.

Regards
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
