Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 56039679E7
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2006 01:08:28 +1000 (EST)
Date: Wed, 5 Apr 2006 01:08:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] powerpc: iSeries has only 256 IRQs
Message-Id: <20060405010818.7e992a66.sfr@canb.auug.org.au>
In-Reply-To: <20060404133614.GA24210@suse.de>
References: <20060404145620.00697fff.sfr@canb.auug.org.au>
	<20060404133614.GA24210@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__5_Apr_2006_01_08_18_+1000_L_5iGVci8+UU8/sV"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__5_Apr_2006_01_08_18_+1000_L_5iGVci8+UU8/sV
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olaf,

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

If you have time, can you try (without this patch) just changing NR_IRQS in
include/asm-powerpc/irq.h from 512 to 256 and see if that kernel will boot
and what changes (if any) you get to the boot messages.

Thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__5_Apr_2006_01_08_18_+1000_L_5iGVci8+UU8/sV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEMovoFdBgD/zoJvwRAgMrAJ44VL/lX3dO8R93QqH4O0YLOXicyACdGBT1
ILnKPs8facS5pRXK+LoK824=
=dwrD
-----END PGP SIGNATURE-----

--Signature=_Wed__5_Apr_2006_01_08_18_+1000_L_5iGVci8+UU8/sV--
