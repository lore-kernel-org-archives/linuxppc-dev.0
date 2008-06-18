Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7E21DDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 10:37:39 +1000 (EST)
Subject: Re: [PATCH] ibm_emac: Remove the ibm_emac driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20080617201127.6388ff78@lappy.seanm.ca>
References: <20080617193523.028d4cc2@zod.rchland.ibm.com>
	<20080617201127.6388ff78@lappy.seanm.ca>
Content-Type: text/plain
Date: Wed, 18 Jun 2008 10:34:43 +1000
Message-Id: <1213749283.8129.259.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jgarzik@pobox.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-06-17 at 20:11 -0400, Sean MacLennan wrote:
> On Tue, 17 Jun 2008 19:35:23 -0400
> Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> 
> > The arch/ppc sub-tree has been removed in the powerpc git tree.  The
> > old ibm_emac driver is no longer used by anything as a result of
> > this.  This removes it, leaving the ibm_newemac driver as the proper
> > driver to use for PowerPC boards with the EMAC hardware.
> 
> Would it make any sense to rename the ibm_newemac driver ibm_emac?

Yes.

Cheers,
Ben.
