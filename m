Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 08F62DDE30
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 03:09:23 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l1NG7ZmK013204
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 09:07:35 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1NG7Y6G022256
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 10:07:34 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc: document new interrupt-array property
Date: Fri, 23 Feb 2007 09:07:33 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A59633@az33exm25.fsl.freescale.net>
In-Reply-To: <1be2170fcb25fdc4ac52c93444269737@kernel.crashing.org>
References: <b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<20070222225707.GB15387@localhost.localdomain>
	<621751322ddfe998a15538e8d3903b93@kernel.crashing.org>
	<20070223003317.GA18508@localhost.localdomain>
	<1be2170fcb25fdc4ac52c93444269737@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"David Gibson" <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
> > we need something like interrupt-array.
>=20
> Again, the "interrupt-array" helps only this one specific
> case, and not the general case *at all*.
>=20

Yes-- The interrupt-array helps only this specific case. But
the question is, will this specific case be common in the
future?

If this is a one-off situation it doesn't warrant a new
general property.  However, if it becomes common enough
a simpler representation will benefit developers.  There are
developers who have a hard enough time figuring out the
interrupt-map scheme, much less a logical interrupt nexus
node.

Stuart
