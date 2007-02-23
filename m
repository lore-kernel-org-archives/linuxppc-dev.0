Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B44BBDDF2B
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 04:01:54 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l1NH1jYA009301
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 10:01:45 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1NH1jTa002074
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 11:01:45 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc: document new interrupt-array property
Date: Fri, 23 Feb 2007 10:01:44 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A5968F@az33exm25.fsl.freescale.net>
In-Reply-To: <851c62f4acae2d5c9b2d1eeab20bdd47@kernel.crashing.org>
References: <b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org><9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net><20070222225707.GB15387@localhost.localdomain><621751322ddfe998a15538e8d3903b93@kernel.crashing.org><20070223003317.GA18508@localhost.localdomain><1be2170fcb25fdc4ac52c93444269737@kernel.crashing.org><9696D7A991D0824DBA8DFAC74A9C5FA302A59633@az33exm25.fsl.freescale.net>
	<851c62f4acae2d5c9b2d1eeab20bdd47@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > If this is a one-off situation it doesn't warrant a new
> > general property.  However, if it becomes common enough
> > a simpler representation will benefit developers.
>=20
> Sure.  But in that case, it would be a lot better to
> try to come up with something new that can handle the
> general case (or many many more cases at least).

What is the general case you are referring to here?  What
other cases and scenarios can you imagine?

Stuart
