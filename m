Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ACDE2DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 17:34:45 +1100 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id n2Q6YeAM019760
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 12:04:40 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2Q6V8IM4419682
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 12:01:08 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id n2Q6Ye7j002148
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 17:34:40 +1100
Message-ID: <49CB2200.50703@in.ibm.com>
Date: Thu, 26 Mar 2009 12:04:40 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: Next March 25: Boot failure on powerpc [recursive locking
	detected]
References: <20090325191229.0e17eaf6.sfr@canb.auug.org.au>
	<49CA3BF4.3050801@in.ibm.com>
In-Reply-To: <49CA3BF4.3050801@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	linux-scsi <linux-scsi@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sachin Sant wrote:
> Today's next failed to boot on a powerpc box
> (Power6 blade IBM,7998-61X) with following recursive locking message.
>
> =============================================
> [ INFO: possible recursive locking detected ]
> 2.6.29-next-20090325 #1
After bisecting the failure seems to be because of the following
patch from James ( block: move SCSI timeout check into block )

http://patchwork.kernel.org/patch/8017/

If i back out the above mentioned patch, the machine boots fine
without any problems.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
