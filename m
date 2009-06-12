Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C84BDB71C2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 15:44:15 +1000 (EST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3317DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 15:44:15 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5C5i8xR011891
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 15:44:08 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5C5iD4g336260
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 15:44:13 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5C5iDrB010730
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 15:44:13 +1000
Message-ID: <4A31EB2A.9080003@in.ibm.com>
Date: Fri, 12 Jun 2009 11:14:10 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [Powerpc/SLQB] Next June 06 : BUG during scsi initialization
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com> <4A2909E8.6000507@in.ibm.com>
	<Pine.LNX.4.64.0906071105030.11309@melkki.cs.Helsinki.FI>
	<4A2D001E.5060802@in.ibm.com>
	<20090609141903.GE15219@wotan.suse.de>
In-Reply-To: <20090609141903.GE15219@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Pekka J Enberg <penberg@cs.helsinki.fi>,
	linux-next@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nick Piggin wrote:
> I can't really work it out. It seems to be the kmem_cache_cache which has
> a problem, but there have already been lots of caches created and even
> this samw cache_node already used right beforehand with no problem.
>
> Unless a CPU or node comes up or something right at this point or the
> caller is scheduled onto a different CPU... oopses seem to all
> have CPU#1, wheras boot CPU is probably #0 (these CPUs are node 0
> and memory is only on node 1 and 2 where there are no CPUs if I read
> correctly).
>
> I still can't see the reason for the failure, but can you try this
> patch please and show dmesg?
I was able to boot yesterday's next (20090611) on this machine. Not sure
what changed(may be because of merge with linus tree), but i can no longer
recreate this issue with next 20090611. I was consistently able to
recreate the problem till June 10th next tree.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
