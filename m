Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 55433679FB
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 19:57:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/11] qe_lib: Add common files
Date: Fri, 22 Sep 2006 11:57:31 +0200
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D9399B458A@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Li Yang-r58472" <LeoLi@freescale.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > -----Original Message-----
> > From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]
> > Sent: Thursday, September 21, 2006 11:22 PM
> > To: Li Yang-r58472; linuxppc-dev@ozlabs.org
> > Subject: RE: [PATCH 2/11] qe_lib: Add common files
> >=20
> > > diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
> > > +#define QE_MURAM_DATAONLY_BASE	((uint)0x0)
> > > +#define QE_MURAM_NOSPACE		((uint)0x7fffffff)
> > > +#define QE_MURAM_DATAONLY_SIZE	((uint)(48 * 1024) -
> > > QE_MURAM_DATAONLY_BASE)
> >=20
> > QE_MURAM_DATAONLY_SIZE is 16*1024 on 8321
> >=20
> > Also, you have line wrapping that has mangled all long lines in all
> > patches.
>=20
> No, not for this time.  Maybe your mail client wrapped them.

Yes, you are corrrect. It was my client that messed up this time. Sorry
for the noise.

  Jocke
