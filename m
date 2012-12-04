Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 1BE642C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 11:05:53 +1100 (EST)
Date: Tue, 4 Dec 2012 11:05:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jon Hunter <jon-hunter@ti.com>
Subject: Re: omap2plus_defconfig fails to build
Message-Id: <20121204110546.61973b83030490faa62848a0@canb.auug.org.au>
In-Reply-To: <50BD37FA.2090501@ti.com>
References: <CAAfyv37BA4YMRFJsN5n7EeAD7iE3hzQ2PDqBAtqCju7JdxrvTA@mail.gmail.com>
 <20121204102631.3d8d41e3e8a8c0eb71734e55@canb.auug.org.au>
 <50BD37FA.2090501@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__4_Dec_2012_11_05_46_+1100_0hMzYol8m8XgOm3p"
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Belisko Marek <marek.belisko@gmail.com>, Olof Johansson <olof@lixom.net>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__4_Dec_2012_11_05_46_+1100_0hMzYol8m8XgOm3p
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 3 Dec 2012 17:38:34 -0600 Jon Hunter <jon-hunter@ti.com> wrote:
>
> On 12/03/2012 05:26 PM, Stephen Rothwell wrote:
> >=20
> > On Thu, 29 Nov 2012 11:40:18 +0100 Belisko Marek <marek.belisko@gmail.c=
om> wrote:
> >>
> >> I've update linux-next to next-20121129 and omap2plus_defconfig fails =
to build:
> >> arch/arm/mach-omap2/timer.c: In function 'omap_get_timer_dt':
> >> arch/arm/mach-omap2/timer.c:195: error: implicit declaration of
> >> function 'prom_add_property'
> >=20
> > Caused by commit 9725f4451a9c ("ARM: OMAP: Add DT support for timer
> > driver") from the arm-soc tree interacting with commit 79d1c712958f
> > ("powerpc+of: Rename the drivers/of prom_* functions to of_*") from the
> > powerpc tree.
> >=20
> > I will fix this up in today' linux-next (by changing prom_add_property =
to
> > of_add_property).  Someone will need to remember to tell Linus when the
> > latter of those two commits gets merged.
>=20
> Just to let you know there is a patch available for this problem [1].
>=20
> Tony, Olof, Arnd, not sure how you guys wish to handle this one.

They just really need to send this to Linus along with the pull request,
or Ben does, depending on who gets in first.

>=20
> Cheers
> Jon
>=20
> [1] http://www.spinics.net/lists/arm-kernel/msg210179.html

I will apply this to the arm-soc merge in linux-next today.  The error
will only happen the linux-next at the moment.  Thanks for the pointer -
I actually fished it out of patchwork.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__4_Dec_2012_11_05_46_+1100_0hMzYol8m8XgOm3p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQvT5aAAoJEECxmPOUX5FEKJ4P/Rq21lNKmq2jXKOKMCLiDSli
P6t7v7SfFlfTe7ZLKaSgWWTvvo5taOe4VNUHrWL1sw/RjVxqSKzLyQib13FYozVM
tgpgvwf9vouBEbTpAms3/ANiDoD4k+li3rFA0doTLvQh4dj0opFLwX6WaFsO2Dz5
Mc0vyxkniljkUC4zGofPAPNXq4eXhc+W7VSO890+vvA8a4zQFz4VxyPiQ0SViJFQ
Wvqf2YnUbvaYf0Fs7Ql6+FE3+pWLXYd79FQsBXiVYNZeFT6Teh0NlKBDPvByzYXF
wHuqFIAp2wkUldXtuY65DDb/Z/PrS4ctjBEPKcf27k/RMoIGnZ1cmxMJ9Xgo6MfK
4u/PurYyPkMIrLcmvUECj0jxrOY2J/g3/oj/jr2qZxA5fcp+FBY5KggWh5bXntet
dWMnBQ+oRae4OEmQJbz43inSDlIdBEeUC8ojN20aDIedtP1wd8tvlbxtwv7Sdk5V
OeZAsT/h9wfm2G40sjGhKzYRkqaJEIAcKyIOdyjp+nijQSNR2gQezHeMZtoCVdYO
huVxzvAP5CfDaaq6/ft/qkr05BwdvboyAhqhQxZ7ZxXTDRpcGW10y09jfN9+a8JJ
6Nf9jvWx8lZwd7+QmCF0qeXhfpBXuKA6L726XnoN0yHlwbL/IzEHcZ260AHjGUnI
kIm6+seJfRQEtIbxESLO
=LFyp
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Dec_2012_11_05_46_+1100_0hMzYol8m8XgOm3p--
