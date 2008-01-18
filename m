Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e28esmtp04.in.ibm.com (e28smtp04.in.ibm.com [59.145.155.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B4B99DDED3
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 21:55:11 +1100 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp04.in.ibm.com (8.13.1/8.13.1) with ESMTP id m0IAsgTt009751
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 16:24:42 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0IAsgJQ1048710
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 16:24:42 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id m0IAsgC7022811
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 10:54:42 GMT
Date: Fri, 18 Jan 2008 16:24:41 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: 2.6.24-rc8-mm1 Kernel oops will running kernbench
Message-ID: <20080118105441.GA12009@balbir.in.ibm.com>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<479064F0.7040305@linux.vnet.ibm.com>
	<20080118004416.6a757169.akpm@linux-foundation.org>
	<18320.27372.202771.764301@cargo.ozlabs.ibm.com>
	<479072BC.3080908@linux.vnet.ibm.com>
	<18320.32464.634534.415458@cargo.ozlabs.ibm.com>
	<479082F0.2040109@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <479082F0.2040109@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> [2008-01-18 16:14:00]:

> Paul Mackerras wrote:
> > Kamalesh Babulal writes:
> > 
> >>>>> NIP: 0000000000004570 LR: 000000000fc42dc0 CTR: 0000000000000000
> >>>>> REGS: c00000077b6bf8c0 TRAP: 0300   Not tainted  (2.6.24-rc8-mm1-autotest)
> >>>>> MSR: 8000000000001000 <ME>  CR: 28022422  XER: 00000000
> >>>>> DAR: c00000077b6bfce0, DSISR: 000000000a000000
> > 
> > Actually, how much RAM does this machine have?  If it has less than
> > 32GB, then the problem is that the kernel stack pointer is bogus.
> > (How it got to be bogus is the interesting question, of course. :)
> > 
> > Paul.
> > 
> Hi Paul,
> 
> The machine has around 30GB of RAM, do you want me to try, by taking 
> the git-powerpc.patch out of the series and try reproducing the oops.
>

Kamalesh, I thought I saw Paul's request for trying without
git-powerpc.patch (it's in a separate email). 

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
