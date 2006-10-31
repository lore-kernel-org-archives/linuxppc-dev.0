Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2767167BE4
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 02:24:59 +1100 (EST)
Date: Wed, 1 Nov 2006 02:24:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: build problems with powerpc allmodconfig
Message-Id: <20061101022457.0c684351.sfr@canb.auug.org.au>
In-Reply-To: <20061101022213.0b6bcaf9.sfr@canb.auug.org.au>
References: <20061031142213.GA9275@lst.de>
	<20061101022213.0b6bcaf9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__1_Nov_2006_02_24_57_+1100_vl6eJHQJMNXzHemY"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__1_Nov_2006_02_24_57_+1100_vl6eJHQJMNXzHemY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 1 Nov 2006 02:22:13 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> On Tue, 31 Oct 2006 15:22:13 +0100 Christoph Hellwig <hch@lst.de> wrote:
> >
> >  - arch/powerpc/platforms/iseries/setup.c references rd_size
> >    when CONFIG_INITRD is set.  But rd_size is defined drivers/block/rd.c
> >    which can me modular (and is selected by CONFIG_BLK_DEV_RAM).
> >    This same bug is repeated in the arm amd arm26 code, but except
> >    for those no one outside of rd.c uses this symbol.  I don't see
> >    a point why arch code should modify this as it's already big enough.
>
> A fix for this has already been posted
> (http://patchwork.ozlabs.org/linuxppc/patch?id=7523).

This patch is already in the powerpc git tree.
--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__1_Nov_2006_02_24_57_+1100_vl6eJHQJMNXzHemY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFR2rJFdBgD/zoJvwRAmURAJoCPL73e5hb8co/LxaNNkB4Unb/5gCeLdAv
HkDHBNZJEGOS4SYyk2AespU=
=YQ+s
-----END PGP SIGNATURE-----

--Signature=_Wed__1_Nov_2006_02_24_57_+1100_vl6eJHQJMNXzHemY--
