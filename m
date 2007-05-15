Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA147DDF41
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 17:33:39 +1000 (EST)
Subject: Re: [PATCH 0/3] Initial AMCC Bamboo support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070515014431.GF565@localhost.localdomain>
References: <1179154608.3420.21.camel@zod.rchland.ibm.com>
	<20070515012629.GC565@localhost.localdomain>
	<1179193113.3420.95.camel@zod.rchland.ibm.com>
	<20070515014431.GF565@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 15 May 2007 17:33:07 +1000
Message-Id: <1179214387.32247.168.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> You may need to do both.  At least if you use the same format for the
> ebc binding as I have on Ebony: in the reg properties of the
> individual nodes I directly encode the ebc chip select value and
> offset within the peripheral bank.  The ebc node's 'ranges' gives the
> mappings into the OPB space.  So, in practice, the low 20 bits of
> address are determined by the individual peripheral's reg properties,
> and the upper 12 bits are determined by the ranges property at the EBC
> node.

In addition we might want a helper to fix the node unit address after
poking reg ...

Ben.
