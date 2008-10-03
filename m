Return-Path: <mohan@in.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 270F8DDEE0
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 15:44:49 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m935iZwZ002668
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Oct 2008 01:44:35 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m935iPgn277288
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Oct 2008 01:44:25 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m935iPxc018395
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Oct 2008 01:44:25 -0400
Message-ID: <48E5B134.6050506@in.ibm.com>
Date: Fri, 03 Oct 2008 11:14:20 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
To: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] powerpc: dtb and purgatory support for ppc32
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
	<1222896024-22172-4-git-send-email-sebastian@breakpoint.cc>
	<7AB33E84-B8C2-4B32-B1F8-7FA213198FE4@kernel.crashing.org>
	<48E47D38.3040508@linutronix.de>
	<20081002100553.GA5886@verge.net.au>
In-Reply-To: <20081002100553.GA5886@verge.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Sebastian Siewior <bigeasy@linutronix.de>,
	kexec@lists.infradead.org,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Simon Horman wrote:
> On Thu, Oct 02, 2008 at 09:50:16AM +0200, Sebastian Siewior wrote:

> 
> I'm not speaking on behalf of Kumar Gala, just on behalf of myself.
>

Hi Horms,

> I would like to get some review of this patch by if possible.
> Also, I'm a little unclear of how it will interact with the
> patches that Mohan Kumar sent this week. But at this point
> I don't see any particular need to break the patch up into
> smaller pieices.
> 

My patches are meant for PPC64 only. The patch implements support for 
relocatable kdump kernel on PPC64 platform.

So I don't think Sebastian's patches need to support this relocation 
support in the kexec-tools as of now.

Regards,
Mohan.
