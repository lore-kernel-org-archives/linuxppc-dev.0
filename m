Return-Path: <vatsa@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0900FDDE02
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 20:13:15 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0Q9DBoo006184
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 04:13:11 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0Q9DBPs242818
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 04:13:11 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0Q9DBY5029185
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 04:13:11 -0500
Date: Sat, 26 Jan 2008 14:56:45 +0530
From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ppc32: Weird process scheduling behaviour with 2.6.24-rc
Message-ID: <20080126092644.GA1044@linux.vnet.ibm.com>
References: <1201090699.9052.39.camel@thor.sulgenrain.local>
	<1201092131.6341.51.camel@lappy>
	<1201244082.6815.128.camel@pasglop>
	<1201244618.6815.130.camel@pasglop>
	<1201245901.6815.133.camel@pasglop>
	<1201251000.6341.108.camel@lappy>
	<20080126040734.GA21365@linux.vnet.ibm.com>
	<1201320834.6815.160.camel@pasglop>
	<20080126050637.GA14177@linux.vnet.ibm.com>
	<1201324552.6815.165.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1201324552.6815.165.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	=?iso-8859-1?Q?Michel=2ED=E4nzer_=3Cmichel=40tungstengraphics=2Ecom=3E?=.=?iso-8859-1?B?QHNub3d5LmluLmlibS5jb20=?=@snowy.in.ibm.com,
	=?iso-8859-1?Q?Michel=2ED=E4nzer?= <michel@tungstengraphics.com>
Reply-To: vatsa@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 26, 2008 at 04:15:52PM +1100, Benjamin Herrenschmidt wrote:
> > Michel,
> > 	You had reported that commit 810e95ccd58d91369191aa4ecc9e6d4a10d8d0c8 
> > was the cause for this bad behavior. Do you see behavior change (from good->bad)
> > immediately after applying that patch during your bisect process?
> 
> Also Michel, double check your .config in both cases.

And also Michel whether CONFIG_FAIR_GROUP_SCHED + CONFIG_FAIR_CGROUP_SCHED
gives more or less same desktop exp as !CONFIG_FAIR_GROUP_SCHED pls!

> > I would prefer to have CONFIG_FAIR_GROUP_SCHED +
> > CONFIG_FAIR_CGROUP_SCHED on by default. Can you pls let me know how you
> > think is the desktop experience with that combination?
> 
> I'm going to give that a try but unfortunately, it will have to wait
> until I'm back from LCA in a bit more than a week.

-- 
Regards,
vatsa
