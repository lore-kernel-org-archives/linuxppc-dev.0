Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5301EDE5F1
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 23:40:27 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3GDeNwR009766
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 09:40:23 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3GDeNRg235168
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 09:40:23 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3GDeMS9015447
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 09:40:22 -0400
Date: Wed, 16 Apr 2008 08:36:59 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: linux-next: 4xx build failure
Message-ID: <20080416083659.542373d6@zod.rchland.ibm.com>
In-Reply-To: <1208350282.6958.285.camel@pasglop>
References: <20080416194227.1e5e1a9a.sfr@canb.auug.org.au>
	<20080416072453.59858204@zod.rchland.ibm.com>
	<1208350282.6958.285.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 16 Apr 2008 22:51:22 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > Grr.  Yes, that's probably the right solution for now.  I had forgotten
> > about Axon.
> > 
> > Sorry for the trouble.  I'll revert those commits locally and repush.
> 
> MMIO is not only Axon.. .some Xilinx stuff too. We should have a proper

Yes.  But Axon is the only one in-tree that uses it at the moment.

> implementation of the dcri stuff for MMIO.

Yes, of course.  Though neither you or I thought of that when we acked
the patch :).

josh
