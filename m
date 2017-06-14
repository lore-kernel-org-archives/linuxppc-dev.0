Return-Path: <trini@konsulko.com>
Received: from mail-yw0-x229.google.com (mail-yw0-x229.google.com
 [IPv6:2607:f8b0:4002:c05::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnnTw48WWzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 23:26:43 +1000 (AEST)
Received: by mail-yw0-x229.google.com with SMTP id l75so204035ywc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 06:26:43 -0700 (PDT)
Date: Wed, 14 Jun 2017 09:27:04 -0400
From: Tom Rini <trini@konsulko.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: hs@denx.de, u-boot@lists.denx.de,
 Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v1 1/3] powerpc, 8xx: remove support for 8xx
Message-ID: <20170614132704.GA10782@bill-the-cat>
References: <8472b742-049b-070b-2627-27704f5bfc0a@c-s.fr>
 <c47ea679-cd3f-d993-7eb6-247762b87081@c-s.fr>
 <593F9644.5080305@denx.de>
 <e14b80d8-e2b9-4f27-0191-bb64cd987edb@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4TXh5fNl3e3Ypx4l"
In-Reply-To: <e14b80d8-e2b9-4f27-0191-bb64cd987edb@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--4TXh5fNl3e3Ypx4l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2017 at 09:40:18AM +0200, Christophe LEROY wrote:
>=20
>=20
> Le 13/06/2017 =E0 09:37, Heiko Schocher a =E9crit :
> >Hello Christophe,
> >
> >Am 13.06.2017 um 07:40 schrieb Christophe LEROY:
> >>
> >>
> >>Le 13/06/2017 =E0 07:26, Christophe LEROY a =E9crit :
> >>>There was for long time no activity in the 8xx area.
> >>>We need to go further and convert to Kconfig, but it
> >>>turned out, nobody is interested anymore in 8xx,
> >>>so remove it (with a heavy heart, knowing that I remove
> >>>here the root of U-Boot).
> >>>
> >>>Signed-off-by: Heiko Schocher <hs@denx.de>
> >>>
> >>
> >>Please don't do that.
> >
> >Tom already applied the patch to mainline ...
>=20
> Can be reverted ?

It's not a trivial revert, but it wouldn't take took long to resolve the
conflicts, for someone that's interested in the architecture.

> >>As you can see in Linux kernel activity, there have been a lot
> >>activity related to the 8xx,
> >>including but not limited to:
> >>1/ HW Crypto for the 885 (Talitos SEC1)
> >>2/ TX NAPI in the 8xx Ethernet driver
> >>3/ Scatter/Gather support in the 8xx Ethernet driver
> >>4/ Hugepages
> >>5/ Perf events
> >>6/ hw breakpoints
> >>7/ Linear memory mapping via Large TLBs
> >
> >Thats linux ... not u-boot!
>=20
> Sure, but it shows there is still interest to that processor. The
> 885 is a good recent 8xx.
> u-boot is not really something we focus on. We update it once a
> year, as far as it can start our Linux box we are happy.

I suppose this highlights the risks of not upstreaming your code.  If
someone had been submitting a new board in the last few years, they
would (likely, yes, we've made a few mistakes in missing maintainers at
times) have been CC'd on one of the "Does anyone care about this still?"
messages that've been both in public and in private.

> >>The followings links give an overview of the activity:
> >>
> >>https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git=
/log/drivers/crypto/talitos.c
> >>
> >>https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git=
/log/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> >>
> >>
> >>https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git=
/log/arch/powerpc/kernel/head_8xx.S
> >>
> >>
> >>https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git=
/log/arch/powerpc/mm/8xx_mmu.c
> >>
> >>
> >>We have thousands of boards with mpc885 running and requiring
> >>support for at least the next 10 years.
> >
> >Ok, nice to hear!
> >
> >>How can the 8xx survive without U-boot support ?
> >
> >Tom asked (I think a lot of times) regarding converting mpc8xx to
> >Kconfig / DM and nobody did the necessary steps. We also asked
> >our customers if they can do the necessary changes, none was interested.
>=20
> I did't know. Indeed I was not following uboot activity until
> someone who knows the level of interest we have in 8xx alerted me
> yesterday.
> It would have been nice if you had notified linuxppc-dev list.
>=20
> >
> >So, if you need mpc8xx support in U-Boot, simply add it again with
> >Kconfig and DM support included!
>=20
> Ok, I'll try and come with a patch to convert 8xx in the coming
> weeks. In the mean time please revert the deletion in order to avoid
> nightmare conflicts when the converting patch comes.

Well, how about this.  Now that you know there's a problem, and a need
for a maintainer, can you please submit a patch, in the next say 2
weeks, that brings back the core of mpc8xx and lists you (or someone
else from your company) as the maintainer for mpc8xx, and we'll aim for
v2017.09 as having (a) one of your platforms, or relevant reference
platform in mainline.  I don't want "just a revert" as there's many
boards that no, we don't want anymore as no one is maintaining them.
Thanks!

--=20
Tom

--4TXh5fNl3e3Ypx4l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZQTmnAAoJEIf59jXTHXZSf/wP/i0v+qVAmCXZ99MWlzh/2+h2
djvFZ4kDOxrg++hqv+k9mEUYBh9HuRgiHjTW+oSDX57C0NpJ8xwiv13PPJ2J7HSE
5AtVRP4bC8rngn3ZRnLiRZnYyXSEV2GG2MhECqiSHv6kTfg3tCXCwC7DcmgovOT8
UCSHNK1Lm3WJHdaBRKtOiUNQwNbB4XAhx7aq0YrslykVYy1rDL5eJ5GinMo7ZJvf
H/3M29cEgrlgWzmCrdEI+t7hW5BCh6K11qqMTcuC45lDpZom6L2EgnoAt/QwKdcS
P7RzdNrDTP1LuPMgJqGWdGURe4FCrvqBqR7uRsMcpKyVEVZ9xk3vXuv4WNy9hkTz
Ro5nm68DwwCJ+SY0g+QDLySloh28/USY7A++nRBH2Qq+vk6uUOVv20f76OMsasVG
hXsNcP2WAjRdOR1KlQOvnMfH/v+E3ZAsyXyFO6WVSbhB0hvswOD0yWc7hToTvBgN
l8SpST6Eayr7oO8oTIu0m/0LeFY3r49N1WAQEO4i5FFTEko7rTVDwFdeAMGpP4w0
x3H4iSgS+uBvuqOX3l5Yb7+BJlyUkzm7ewmXRoRaV/pLvQNc7Tq3R5wjry3k5UrQ
RkA37cmdwtxDmnmLVWRfFexVp8gpTs4v57BQafYrPG5zffg4aFO/zuIxqEoeq3OO
FhgCOuZoXJKVOSMOE+zC
=Z3PU
-----END PGP SIGNATURE-----

--4TXh5fNl3e3Ypx4l--
