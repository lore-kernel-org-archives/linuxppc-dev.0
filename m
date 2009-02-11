Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2FF9FDDDB0
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 16:28:43 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id n1B5R5J2001421
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 16:27:05 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n1B5StS0328076
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 16:28:56 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1B5SaTp023072
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 16:28:37 +1100
Message-ID: <49926202.3010405@in.ibm.com>
Date: Wed, 11 Feb 2009 10:58:34 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [patch] powerpc/ps3: Use hard coded values for LV1 device type
References: <498C6C49.1010200@in.ibm.com> <498CF52E.4040903@am.sony.com>
	<1234092590.10240.4.camel@localhost>
	<1234138267.31963.77.camel@pasglop>
	<1234151988.8776.4.camel@localhost.localdomain>
In-Reply-To: <1234151988.8776.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-scsi <linux-scsi@vger.kernel.org>, Mel Gorman <mel@csn.ul.ie>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

James Bottomley wrote:
> Actually, I think the fix lies in scsi.h ... we can make that into a
> nicely independent protocol header file.  Your current woes come because
> it pulls in scsi_cmnd.h ... perhaps just getting rid of this will fix
> it.
>
> Can the rest of linux-scsi verify that the fix below doesn't break
> something else?
>
> I found one cockup: block/cmd-filter.c is apparently not including
> linuc/blkdev.h directly but via scsi/scsi.h ... I fixed this up.
>   
Tested the patch and it fixes the issue.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
