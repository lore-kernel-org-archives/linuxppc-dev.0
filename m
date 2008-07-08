Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2864CDDF1C
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 11:28:48 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m681SjRF031088
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 21:28:45 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m681SjS7068254
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 21:28:45 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m681SijY008390
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 21:28:45 -0400
Date: Mon, 7 Jul 2008 21:25:23 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: rework 4xx PTE access and TLB miss
Message-ID: <20080707212523.24d2014f@zod.rchland.ibm.com>
In-Reply-To: <1215468180.8970.124.camel@pasglop>
References: <20080701043607.07484DDED7@ozlabs.org>
	<20080707100627.4be05488@zod.rchland.ibm.com>
	<1215468180.8970.124.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 08 Jul 2008 08:03:00 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2008-07-07 at 10:06 -0400, Josh Boyer wrote:
> 
> > The setup is an tftp'd kernel via U-Boot using cuImage, nfsroot
> > filesystem.  Sequoia has an FPU, and CONFIG_PPC_FPU is set.
> > 
> > I reverted this patch and used the latest powerpc-next branch and it
> > boots fine.
> > 
> > Seems something is wrong here still.  I suspect the DSI handler
> > changes, but I have no proof and haven't debugged it yet.  Until we
> > get it fixed, I don't feel overly comfortable putting it in the next
> > branch.  Which board and setup did you test with?
> 
> mambo and another board I don't remember which one precisely.

Unless you've seriously fixed mambo (which you probably have), I
wouldn't consider the 44x port to be useful as a true test platform.  I
started that support like 3 years ago, and I abandoned it when I was
1/2 way finished.  The exception precedence wasn't even right, and
userspace didn't start :)

> I'll have a look.

Cool, thanks.  If I get some time, I'll poke around myself too.

josh
