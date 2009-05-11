Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3CD54DDDA9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 02:59:55 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4BGxEm8024513
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 02:59:14 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4BGxskZ483356
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 02:59:54 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4BGxsKW026173
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 02:59:54 +1000
Message-ID: <4A085987.7070706@in.ibm.com>
Date: Mon, 11 May 2009 22:29:51 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Next May 11 : BUG during scsi initialization
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com>
	<20090511115233.GB8112@parisc-linux.org>
	<4A081437.7000409@in.ibm.com>
	<20090511122135.GC8112@parisc-linux.org>
	<4A08502B.9040001@in.ibm.com>
	<20090511162511.GG8112@parisc-linux.org>
In-Reply-To: <20090511162511.GG8112@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Nick Piggin <npiggin@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-scsi <linux-scsi@vger.kernel.org>, chinang.ma@intel.com,
	linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matthew Wilcox wrote:
> On Mon, May 11, 2009 at 09:49:55PM +0530, Sachin Sant wrote:
>   
>> Yeah so the problem seems to be with SLQB. I was able to boot Next 11 with
>> SLUB on the same machine.
>>     
>
> Is it 100% reproducable with SLQB?  Our errors were fairly hard to tickle
> on demand.
>
>   
Yes. I am able to recreate this during every single reboot. I just 
tested few older next
releases (May 6th, 7th and 8th)as well and was able to recreate this 
issue with every release.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
