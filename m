Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C7B6DDDF55
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 10:41:16 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5I0fDhS017824
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 20:41:13 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5I0fD5l199350
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 20:41:13 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5I0fCEP027333
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 20:41:12 -0400
Date: Tue, 17 Jun 2008 20:39:12 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] ibm_emac: Remove the ibm_emac driver
Message-ID: <20080617203912.4d51ddb9@zod.rchland.ibm.com>
In-Reply-To: <1213749283.8129.259.camel@pasglop>
References: <20080617193523.028d4cc2@zod.rchland.ibm.com>
	<20080617201127.6388ff78@lappy.seanm.ca>
	<1213749283.8129.259.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jgarzik@pobox.com,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 18 Jun 2008 10:34:43 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2008-06-17 at 20:11 -0400, Sean MacLennan wrote:
> > On Tue, 17 Jun 2008 19:35:23 -0400
> > Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > 
> > > The arch/ppc sub-tree has been removed in the powerpc git tree.  The
> > > old ibm_emac driver is no longer used by anything as a result of
> > > this.  This removes it, leaving the ibm_newemac driver as the proper
> > > driver to use for PowerPC boards with the EMAC hardware.
> > 
> > Would it make any sense to rename the ibm_newemac driver ibm_emac?
> 
> Yes.

One step at a time.

And really, that seems like a bunch of busy work for little gain.  We'd
have to move the files, change the Kconfig options, update all the
in-tree defconfigs... just so it can be called ibm_emac?

I don't really care either way, but I'll leave it up to the ibm_newemac
maintainer to push that change through.  If it goes in, I'll update
other things as needed.

josh
