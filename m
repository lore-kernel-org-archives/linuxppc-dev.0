Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3CED8B7131
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 18:08:57 +1000 (EST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 222EADDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 18:08:56 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5C878qZ021769
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 18:07:08 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5C88ssu897174
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 18:08:54 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5C88rKl018644
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 18:08:54 +1000
Message-ID: <4A320D12.2050802@in.ibm.com>
Date: Fri, 12 Jun 2009 13:38:50 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [Powerpc/SLQB] Next June 06 : BUG during scsi initialization
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com> <4A2909E8.6000507@in.ibm.com>
	<Pine.LNX.4.64.0906071105030.11309@melkki.cs.Helsinki.FI>
	<4A2D001E.5060802@in.ibm.com>
	<20090609141903.GE15219@wotan.suse.de>
	<4A31EB2A.9080003@in.ibm.com>
	<20090612074213.GA21070@wotan.suse.de>
In-Reply-To: <20090612074213.GA21070@wotan.suse.de>
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
>> I was able to boot yesterday's next (20090611) on this machine. Not sure
>>     
>
> Still with SLQB? With debug options turned on?
>   
Ah .. spoke too soon. The kernel was not compiled with SLQB. Sorry
about the confusion. I can't seem to select SLQB as the slab
allocator.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
