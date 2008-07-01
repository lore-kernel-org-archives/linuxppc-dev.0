Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C95D0DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 12:34:06 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m612Y1Iw010325
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 22:34:01 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m612Y1Rl219168
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 22:34:01 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m612Y01Y013035
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 22:34:00 -0400
Date: Mon, 30 Jun 2008 22:30:40 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: Commits added to powerpc.git master and powerpc-next branches
Message-ID: <20080630223040.32ee04e1@zod.rchland.ibm.com>
In-Reply-To: <1214876710.20711.69.camel@pasglop>
References: <18537.30774.608486.268257@cargo.ozlabs.ibm.com>
	<18537.34789.355993.604857@cargo.ozlabs.ibm.com>
	<1214876710.20711.69.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 01 Jul 2008 11:45:10 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2008-07-01 at 11:27 +1000, Paul Mackerras wrote:
> > Paul Mackerras writes:
> > 
> > > The following commits have been added to the master and powerpc-next
> > > branches of the powerpc.git repository.  This includes patches pulled
> > > from Kumar's and Josh's trees.
> > 
> > Hold off from pulling this for now, everyone...  I inadvertently broke
> > builds with 64k pages by leaving in some stuff that was purely for
> > testing in my "Only demote individual slices rather than whole
> > process" patch.  I'll re-do the tree in order to avoid breaking
> > bisection.
> 
> Any chance to get my 4xx PTE rework in too ?

I asked you about that 2 weeks ago.  I also asked you to spin a v2 with
the comments Kumar asked for.  I got nothing back.

If you want it in 2.6.27, do that soon please :)

josh
