Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A0D59DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 02:25:35 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l9VFPS3Y006723
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 08:25:29 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9VFPSg1018493
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 10:25:28 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RFC:  replace device_type with new "class" property?
Date: Wed, 31 Oct 2007 08:25:28 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA3035F2ABE@az33exm25.fsl.freescale.net>
In-Reply-To: <20071030232730.GD2784@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<20071029212213.GA28073@lixom.net>
	<20071030005146.GF29263@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F26EE@az33exm25.fsl.freescale.net>
	<20071030232730.GD2784@localhost.localdomain>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > 1.  There are types of nodes that don't have a programming
> >     inteface per se and thus no compatible.
> >     "cpu", "memory", "cache" are 3 that come to mind.
>=20
> Well, yes, this is why I suggested treating these "fundamental" nodes
> as a special case in an earlier mail.

Given your statement below, I'm wondering how you think
"fundamental" nodes should be represented ideally?
=20
> The *only* reason I'm suggesting leaving device_type values for
> IEEE1275 defined classes is so that flat trees written as flat trees
> look more similar to OF derived trees.

So, ideally (without respect to 1275) how should a "cpu"
node be represented and identified as a cpu node?

Stuart
