Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [59.145.155.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 10A67DDFA0
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 06:28:17 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp02.in.ibm.com (8.13.1/8.13.1) with ESMTP id n4CKSEpY010729
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 01:58:14 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4CKSENo1556550
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 01:58:14 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n4CKSDQQ017389
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 01:58:13 +0530
Date: Wed, 13 May 2009 01:58:10 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] Hardware Breakpoint interfaces implementation for PPC64
Message-ID: <20090512202810.GF6033@in.ibm.com>
References: <20090511200355.GA17988@in.ibm.com>
	<20090512115149.GA1885@yoda.jdub.homelinux.org>
	<20090512164738.GA1173@b07421-ec1.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090512164738.GA1173@b07421-ec1.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@au1.ibm.com>,
	paulus@samba.org
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 12, 2009 at 11:47:38AM -0500, Scott Wood wrote:
> On Tue, May 12, 2009 at 07:51:49AM -0400, Josh Boyer wrote:
> > On Tue, May 12, 2009 at 01:33:55AM +0530, K.Prasad wrote:
> > >- The patch is currently implemented only for PPC64 architecture. Other
> > >  architectures (especially Book-E implementations are expected to
> > >  happen in due course).
> > 
> > Does this mean you will work on transitioning Book-E implementations, or that
> > you expect the Book-E maintainers to?  I'm just curious.  The code as written
> > relies heavily on the DABR/MSR setup that ppc64 has and Book-E unfortunately
> > doesn't follow that at all.
> 
> And since there will eventually be 64-bit book E chips, we need to use
> something more specific than CONFIG_PPC64 in the #ifdef (easier now than
> figuring out which ones are breakpoint-related later).
> 
> -Scott

Sure. I will be glad to receive & incorporate suggestions in this regard
from PowerPC experts (or will 64-bit Book-E implementations be called by
a different name altogether?)

Thanks,
K.Prasad
