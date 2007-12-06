Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 33C28DDEBF
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:48:16 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB6EkeLb027348
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 09:46:40 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB6Fm7hR061444
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 08:48:08 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB6Fm66o012755
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 08:48:06 -0700
Date: Thu, 6 Dec 2007 09:44:48 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Powerpc PCI cleanups (mainly iSeries)
Message-ID: <20071206094448.4de7967a@zod.rchland.ibm.com>
In-Reply-To: <20071207020726.8c0ea12b.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
	<20071207020726.8c0ea12b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 7 Dec 2007 02:07:26 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> On Thu, 6 Dec 2007 18:00:45 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > I started out looking for ways to remove our dependencies on pci_dn and
> > got sidetracked into clening up the iSeries PCI code.  The intention of
> > the following set of patches is that there be no semantic changes
> > (mostly).
> 
> Some of these will clearly conflict with Benh's PCI work.  We will sot
> that out between us.  :-)

In the meantime...

My tree is going to carry BenH's patches since they're obviously
important to 4xx.  If these conflicts get sorted out soon, that would
be good :).  At some point I'm going to start sending stuff to Paul.

josh
