Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BE781DDFF7
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 18:31:06 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp07.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4E8V1JE001792
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 18:31:01 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4E8V14k1642694
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 18:31:01 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4E8V0IG011984
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 18:31:00 +1000
Message-ID: <4A0BD6BB.1050600@in.ibm.com>
Date: Thu, 14 May 2009 14:00:51 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
Subject: Re: Next May 11 : BUG during scsi initialization
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com>
	<20090511115233.GB8112@parisc-linux.org>
	<4A081437.7000409@in.ibm.com>
	<20090511122135.GC8112@parisc-linux.org>
	<20090512045716.GC32535@wotan.suse.de>
In-Reply-To: <20090512045716.GC32535@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	linux-next@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nick Piggin wrote:
> This one possibly looks like a problem with remote memory allocation
> or memory hotplug or something like that. I'll do a bit of code
> review....
Removed linux-scsi from the cc list.

I can recreate this issue with today's next tree. Nick let me know if 
you need any other
information on this. I have been able to recreate this issue consistently.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
