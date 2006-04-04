Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AFB5E679F7
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 23:44:04 +1000 (EST)
Date: Tue, 4 Apr 2006 23:43:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] powerpc: iSeries has only 256 IRQs
Message-Id: <20060404234350.09ce876d.sfr@canb.auug.org.au>
In-Reply-To: <20060404133614.GA24210@suse.de>
References: <20060404145620.00697fff.sfr@canb.auug.org.au>
	<20060404133614.GA24210@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__4_Apr_2006_23_43_50_+1000_y9TFv8H+HDKaXw3."
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__4_Apr_2006_23_43_50_+1000_y9TFv8H+HDKaXw3.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Apr 2006 15:36:14 +0200 Olaf Hering <olh@suse.de> wrote:
>
>  On Tue, Apr 04, Stephen Rothwell wrote:
>=20
> > The iSeries Hypervisor only allows us to specify IRQ numbers up to 255 =
(it
> > has a u8 field to pass it in).  This patch allows platforms to specify a
> > maximum to the virtual IRQ numbers we will use and has iSeries set that
> > to 255.  If not set, the maximum is NR_IRQS - 1 (as before).
>=20
> I tried this patch, and the partition dies that way:

Thanks for the test, I will have a further look.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__4_Apr_2006_23_43_50_+1000_y9TFv8H+HDKaXw3.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEMngfFdBgD/zoJvwRAhDGAJ415TgSxNZ+TzRW/PCJueLCJEDfCgCfTZhv
si/135FsCfMM6RHpKFrr6U8=
=7A6T
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Apr_2006_23_43_50_+1000_y9TFv8H+HDKaXw3.--
