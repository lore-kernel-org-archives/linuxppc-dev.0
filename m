Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [59.145.155.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2C8EDDDF9
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 21:58:18 +1100 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id n1NAvKme006725
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 16:27:20 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n1NAsXGJ3678436
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 16:24:33 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id n1NAvKt6014870
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Feb 2009 21:57:20 +1100
Message-ID: <49A28110.1000802@in.ibm.com>
Date: Mon, 23 Feb 2009 16:27:20 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Crash (ext3 ) during 2.6.29-rc6 boot
References: <49A2705D.9030008@in.ibm.com>
	<20090223021320.11019d64.akpm@linux-foundation.org>
	<18850.31567.212454.514549@cargo.ozlabs.ibm.com>
In-Reply-To: <18850.31567.212454.514549@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jan Kara <jack@ucw.cz>, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> It appears to have faulted on a load, implicating the source.  The
> address being referenced (0xc00000003f380000) doesn't look
> outlandish.  I wonder if this kernel has CONFIG_DEBUG_PAGEALLOC turned
> on, and what page size is selected?
Yes CONFIG_DEBUG_PAGEALLOC is enabled and the page size is 64K.

CONFIG_DEBUG_PAGEALLOC=y
CONFIG_PPC_64K_PAGES=y

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
