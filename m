Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail176-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 80F5DDDF48
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 11:45:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Use <linux/of_{platform,
	device}.h> and not <asm/...>variants.
Date: Tue, 8 Jan 2008 16:45:16 -0800
In-Reply-To: <20080109102912.16215a01.sfr@canb.auug.org.au>
References: <E1JBwNX-0006XF-26@jdl.com><20080108113637.5208a0c7.sfr@canb.auug.org.au><E1JCF5S-00043W-0U@jdl.com>
	<20080109102912.16215a01.sfr@canb.auug.org.au>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>,
	"Jon Loeliger" <jdl@jdl.com>
Message-Id: <20080109004523.B49A61050055@mail176-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: =
linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of
Stephen Rothwell
> Sent: Tuesday, January 08, 2008 3:29 PM
> To: Jon Loeliger
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Use <linux/of_{platform, device}.h> and not
<asm/...>variants.
>=20
> > But, of course, the various asm/of_{platform,device}.h files
> > are different for each arch/, so I wasn't sure if the longer
> > term plan had folding the arch variants straight into the
> > include/linux/ version of the file or not.  Seems there will
> > come a point when the sparc and powerpc variants will need
> > to be more unified...
>=20
> Some more unification should be possible over time, but that is much
> harder.

One of the unified bits I'd really like to see for the microblaze is the
interrupt handling stuff, i.e. irq_of_parse_and_map().

Steve
