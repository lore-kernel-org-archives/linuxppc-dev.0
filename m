Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 816DBDDEFE
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 09:55:35 +1100 (EST)
Date: Tue, 6 Mar 2007 09:55:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH 2/6] [POWERPC] create and use get_pci_dma_ops(
Message-Id: <20070306095525.781a730d.sfr@canb.auug.org.au>
In-Reply-To: <1173112272.5877.5.camel@localhost>
References: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
	<20070304170241.816f9802.sfr@canb.auug.org.au>
	<1173112272.5877.5.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__6_Mar_2007_09_55_25_+1100_f5gbtZ4Wp23rCnE/"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__6_Mar_2007_09_55_25_+1100_f5gbtZ4Wp23rCnE/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 05 Mar 2007 10:31:11 -0600 Will Schmidt <will_schmidt@vnet.ibm.com> wrote:
>
> > -EXPORT_SYMBOL(pci_dma_ops);
>
> > +EXPORT_SYMBOL(get_pci_dma_ops);
>
> should this one be EXPORT_SYMBOL_GPL(get_pci_dma_ops);
>
> or is it grandfathered in because it is replacing and renaming
> EXPORT_SYMBOL(pci_dma_ops);   ?

Yes, I don't know if there are any out of tree uses, but there could
easily be.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__6_Mar_2007_09_55_25_+1100_f5gbtZ4Wp23rCnE/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF7J/oFdBgD/zoJvwRAiYRAJ9Fj1gflrPFLjvAh4DbHWYae/aX/gCeJWxs
Rk7UcnbQ4CetOGAtze9X8zM=
=T/Lj
-----END PGP SIGNATURE-----

--Signature=_Tue__6_Mar_2007_09_55_25_+1100_f5gbtZ4Wp23rCnE/--
