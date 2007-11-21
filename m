Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 70018DDEA0
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 09:41:52 +1100 (EST)
Date: Thu, 22 Nov 2007 09:41:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: annoying prinkts during vmemmap initialization
Message-Id: <20071122094145.e79e1084.sfr@canb.auug.org.au>
In-Reply-To: <20071121153526.GA23589@lst.de>
References: <20071121153526.GA23589@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__22_Nov_2007_09_41_45_+1100_K0Qpf.2LCdKIFkb0"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__22_Nov_2007_09_41_45_+1100_K0Qpf.2LCdKIFkb0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Wed, 21 Nov 2007 16:35:26 +0100 Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Andi,
>=20
> your patch 'ppc64: SPARSEMEM_VMEMMAP support' adds the following two line=
s:
>=20
> +               printk(KERN_WARNING "vmemmap %08lx allocated at %p, "
> +                                       "physical %p.\n", start, p, __pa(=
p));
>=20
> in a loop around basically every page.  That's a lot of flooding (with
> the wrong printk level, btw) and really slows down booting my cell blade
> a lot (these only have a very slow serial over lan console).
>=20
> Any reason to keep this?  And if yes can we please make it conditional
> on some kind of vmemmap_debug boot option?

These have been changed to pr_debug() in 2.6.24-rc3 kernel.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__22_Nov_2007_09_41_45_+1100_K0Qpf.2LCdKIFkb0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHRLQtTgG2atn1QN8RAoaYAJ0d3HpkWsV65Penn4wJFwVueQu7dACeMviQ
25Ti53PysqM+ldvz+RoRD90=
=8TmG
-----END PGP SIGNATURE-----

--Signature=_Thu__22_Nov_2007_09_41_45_+1100_K0Qpf.2LCdKIFkb0--
