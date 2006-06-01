Return-Path: <jimix@watson.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A467C67B20
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 14:34:25 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k514YNuN026585
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Jun 2006 00:34:23 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k514YNFT171614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 22:34:23 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k514YMru006755
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 22:34:22 -0600
In-Reply-To: <20060531204144.GA7909@w-mikek2.ibm.com>
References: <20060531204144.GA7909@w-mikek2.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AEFF6654-C958-42F7-93CF-64103B015CB1@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: Collecting hypervisor call stats
Date: Thu, 1 Jun 2006 00:34:29 -0400
To: Mike Kravetz <kravetz@us.ibm.com>, Chris Yeoh <yeohc@au1.ibm.com>,
	Bryan Rosenburg <rosnbrg@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

IIRC, chris and bryan have done some work to track this, they may  
have some code to contribute.
On May 31, 2006, at 4:41 PM, Mike Kravetz wrote:

> We would like to add code that gathers statistics about hypervisor  
> calls.
> It would keep track of things like # of calls made for each opcode  
> as well
> as time spent processing the calls.
>
> The 'obvious' place to gather such statistics would be from within the
> routines making hcalls in hvCall.S.  Once thing that I have noticed is
> the following comment at the beginning hvCall.S:
>
>  * NOTE: this file will go away when we move to inline this work.
>
> So, it appears someone thought/thinks these routines should be  
> inlined.
> I assume this is for performance reasons?  If this is the case, then I
> suspect gathering of statistics (which would introduce overhead) would
> meet resistance?
>
> Comments about the feasibility of adding such statistic gathering code
> would be appreciated.
>
> Thanks,
> -- 
> Mike
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
