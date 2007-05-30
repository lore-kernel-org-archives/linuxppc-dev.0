Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 55133DE05B
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 10:53:22 +1000 (EST)
Date: Wed, 30 May 2007 10:53:09 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 4/5] powerpc: Make syscall restart code more common
Message-Id: <20070530105309.7869fdd6.sfr@canb.auug.org.au>
In-Reply-To: <1180438885.19517.157.camel@localhost.localdomain>
References: <20070529064533.CA8C4DDFF8@ozlabs.org>
	<20070529113232.GA6071@lst.de>
	<1180438885.19517.157.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__30_May_2007_10_53_09_+1000_PmI7.hp_PVtirH2+"
Cc: linuxppc-dev@ozlabs.org, ulrich.weigand@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__30_May_2007_10_53_09_+1000_PmI7.hp_PVtirH2+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 29 May 2007 21:41:25 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> I've been thinking about doing that too. In fact, some of the
> ptrace-common.h stuff should probably be turned back into ptrace.c too
> for the same reason. I'm still toying with that part of the designm but
> yeah, I think that's something to do.

Yeah, I think having ptrace{,_32,_64}.c makes more sense as well.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__30_May_2007_10_53_09_+1000_PmI7.hp_PVtirH2+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGXMsAFdBgD/zoJvwRAnLgAJ4/Ia0JgvGNgBYeUqS7xn6tVS5MigCgoFOR
lfgraSunWsiXIk/ZiwID2FY=
=yWR1
-----END PGP SIGNATURE-----

--Signature=_Wed__30_May_2007_10_53_09_+1000_PmI7.hp_PVtirH2+--
