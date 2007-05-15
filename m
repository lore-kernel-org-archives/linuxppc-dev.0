Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0AB68DDED2
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 14:26:28 +1000 (EST)
Date: Tue, 15 May 2007 14:26:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: Add spinlock to request_phb_iospace()
Message-Id: <20070515142615.bf748b7a.sfr@canb.auug.org.au>
In-Reply-To: <20070515041655.BDD98DDEC6@ozlabs.org>
References: <20070515041655.BDD98DDEC6@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_May_2007_14_26_15_+1000_1oIIj7+Kz_mcKyJn"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Bergmann <arnd.bergmann@de.ibm.com>, Arnd
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__15_May_2007_14_26_15_+1000_1oIIj7+Kz_mcKyJn
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 15 May 2007 14:16:26 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> request_phb_iospace() can be called from different CPUs at init
> time (at least with my next patch) and thus needs a spinlock. As
> for the next patch, this is a temporary workaround for 2.6.22
> issues until my rewrite of IO mappings is ready (for 2.6.23)

What problem is this solving?

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_May_2007_14_26_15_+1000_1oIIj7+Kz_mcKyJn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGSTZrFdBgD/zoJvwRAveiAJ0XKh1ZWm2UqHtQEsUiY6LePd6ehwCgok4L
Hat2Uu8bha6+pogEHU0NGtc=
=Hi+O
-----END PGP SIGNATURE-----

--Signature=_Tue__15_May_2007_14_26_15_+1000_1oIIj7+Kz_mcKyJn--
