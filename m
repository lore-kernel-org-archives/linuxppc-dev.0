Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound7-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E779BDDED8
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 03:34:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/4] [v4][POWERPC] refactor dcr code
Date: Tue, 6 May 2008 10:34:36 -0700
In-reply-to: <1210046531.21644.139.camel@pasglop>
References: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
	<1210010201-28436-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080505175647.5C26F2B0059@mail60-sin.bigfish.com>
	<20080506134006.62900cce.sfr@canb.auug.org.au>
	<1210046531.21644.139.camel@pasglop>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: <benh@kernel.crashing.org>,
	"Stephen Rothwell" <sfr@canb.auug.org.au>
Message-Id: <20080506173438.5C1A0820071@mail178-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I'll fix it.

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> Sent: Monday, May 05, 2008 9:02 PM
> To: Stephen Rothwell
> Cc: Stephen Neuendorffer; jwboyer@linux.vnet.ibm.com;
grant.likely@secretlab.ca; linuxppc-
> dev@ozlabs.org
> Subject: Re: [PATCH 1/4] [v4][POWERPC] refactor dcr code
>=20
>=20
> On Tue, 2008-05-06 at 13:40 +1000, Stephen Rothwell wrote:
> > Since find_dcr_parent has done a of_node_get on its return value,
you
> > leak a reference to dp here i.e. you need an of_node_put(dp) before
> > you return.
>=20
> He inherited that bug from other dcr.c functions I wrote, my fault.
>=20
> Stephen (N. not R.), would you mind fixing them while at it or do you
> want me to cook up a patch ?
>=20
> Cheers,
> Ben.
>=20
>=20
