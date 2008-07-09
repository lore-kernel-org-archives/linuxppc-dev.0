Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BE3E9DDE22
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 06:25:56 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m69KSGEJ019829
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 16:28:16 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m69KPgpA157468
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 16:25:42 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m69KPfcU012350
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 16:25:41 -0400
Date: Wed, 9 Jul 2008 16:22:19 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: Fix problems with 32bit PPC's running with
	more than 2GB of RAM
Message-ID: <20080709162219.4c07a67e@zod.rchland.ibm.com>
In-Reply-To: <1215633758.8970.372.camel@pasglop>
References: <1215611076-13518-1-git-send-email-sr@denx.de>
	<1215633758.8970.372.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 Jul 2008 06:02:38 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2008-07-09 at 15:44 +0200, Stefan Roese wrote:
> > This patch enables 32bit PPC's (with 36bit physical address space, e.g.
> > IBM/AMCC PPC44x) to run with more than 2GB of RAM. Mostly its just
> > replacing types (unsigned long -> phys_addr_t).
> > 
> > Tested on an AMCC Katmai with 4GB of DDR2.
> > 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> 
> But DMAs will break no ?

How?

josh
