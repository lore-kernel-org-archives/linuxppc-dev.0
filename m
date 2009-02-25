Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4AD19DDE2A
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 22:08:52 +1100 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id n1PB8Nie031718
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 16:38:23 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n1PB5XCg2334964
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 16:35:33 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id n1PB8NMZ007029
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 22:08:23 +1100
Message-ID: <49A526A6.70509@in.ibm.com>
Date: Wed, 25 Feb 2009 16:38:22 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Mark Nelson <markn@au1.ibm.com>
Subject: Re: Crash (ext3 ) during 2.6.29-rc6 boot
References: <49A2705D.9030008@in.ibm.com>
	<20090223155116.GB5764@atrey.karlin.mff.cuni.cz>
	<49A395ED.5030607@in.ibm.com>
	<200902251752.56514.markn@au1.ibm.com>
In-Reply-To: <200902251752.56514.markn@au1.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jan Kara <jack@ucw.cz>, Jan Kara <jack@suse.cz>, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark Nelson wrote:
> Hi Sanchin and Geert,
>
> Does the patch below fix the problems you're seeing? If it does I'll send
> a properly written up and formatted patch to linuxppc-dev (as well as
> another one to fix the same problem in copy_tofrom_user()).
>   
This patch fixes the issue at my side. I tried booting the system few times
and every single time it came up clean.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
