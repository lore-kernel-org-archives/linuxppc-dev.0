Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A6D4FDE1D2
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 02:16:33 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m71GFuA7006595
	for <linuxppc-dev@ozlabs.org>; Sat, 2 Aug 2008 02:15:56 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m71GGA3U301654
	for <linuxppc-dev@ozlabs.org>; Sat, 2 Aug 2008 02:16:10 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m71GGAgR000336
	for <linuxppc-dev@ozlabs.org>; Sat, 2 Aug 2008 02:16:10 +1000
Message-ID: <489336C7.8010605@linux.vnet.ibm.com>
Date: Fri, 01 Aug 2008 21:46:07 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [BUILD-FAILURE] 2.6.27-rc1-mm1 - allyesconfig build fails on
	powerpc
References: <20080731000354.24b55d5b.akpm@linux-foundation.org>
	<4891B370.5040208@linux.vnet.ibm.com>
	<20080801052936.GZ20457@bakeyournoodle.com>
In-Reply-To: <20080801052936.GZ20457@bakeyournoodle.com>
Content-Type: text/plain; charset=UTF-8
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kernel Testers List <kernel-testers@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tony Breeds wrote:
> On Thu, Jul 31, 2008 at 06:13:28PM +0530, Kamalesh Babulal wrote:
>> Hi Andrew,
>>
>> make allyesconfig with 2.6.27-rc1-mm1 kernel on powerpc fails with build error
> 
> <snip>
> 
> Turning off GCOV "fixes" this.  Not really the best solution but at
> least it narrows doen the search effort.

Thanks, kernel compiles after turning off the GCOV profiling options.
> 
> Peter,
> 	Can you have a look at how this can be fixed, if at all?
Peter, 
	kindly let me know if you want me to test any test patches/fixes.
> 
> Yours Tony
> 
>   linux.conf.au    http://www.marchsouth.org/
>   Jan 19 - 24 2009 The Australian Linux Technical Conference!
> 


-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
