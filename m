Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 13A63B6FE9
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2012 10:02:41 +1000 (EST)
Date: Thu, 5 Apr 2012 10:02:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
Message-Id: <20120405100228.9ca940aa4739e81540bb2a6f@canb.auug.org.au>
In-Reply-To: <20120404192101.2A558200243@gemini.denx.de>
References: <4F69C553.6070409@gmail.com>
 <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com>
 <20120321162549.8C1D0202A4D@gemini.denx.de>
 <1332633218.2882.16.camel@pasglop>
 <CA+5PVA4pGhbrM1P8Dbjaxw_1_ZgEweimLCSc1xrw0Rombr_2rg@mail.gmail.com>
 <CADNf2swF2EVO2u-yPziF2z6HyF6jRBvVsQC2nbY=W2sXJpp2hQ@mail.gmail.com>
 <1333152184.30734.3.camel@pasglop>
 <CA+5PVA6jQgme0sS=i8yYX6b_R5179+BtWPh7QXCGNfoLTCt46A@mail.gmail.com>
 <20120404192101.2A558200243@gemini.denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__5_Apr_2012_10_02_28_+1000_qHeADNe_aR+J5naq"
Cc: linuxppc-dev@ozlabs.org, robert.karl.berger@gmail.com,
 Frank =?UTF-8?B?U3ZlbmRzYsO4ZQ==?= <frank.svendsboe@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__5_Apr_2012_10_02_28_+1000_qHeADNe_aR+J5naq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 04 Apr 2012 21:21:01 +0200 Wolfgang Denk <wd@denx.de> wrote:
>
> The kernel README says nothing about binutils requirements, the only
> tool related statement is "Make sure you have at least gcc 3.2
> available."  Actually I doubt if gcc 3.2 wouldbuild a working kernel
> image.
>=20
> ELDK 4.2 is based on gcc version 4.2.2 / binutils version 2.17.50.0.12
> 20070128.  This is obviously to old for this code.  I do not see an
> actual problem with that - nobody can expect that we support old tol
> chain versions forever.

The requirements are documented in Documentation/Changes where we say we
need gcc 3.2 and binutils 2.12.  Not that that is very relevant to this
discussion. ;-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__5_Apr_2012_10_02_28_+1000_qHeADNe_aR+J5naq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIbBAEBCAAGBQJPfOEUAAoJEECxmPOUX5FEypIP9jFLngWQyCnHGp3q3O5krnd7
qasUiu43yDgAsVoeRxDFokzI/FFOrR7r2lR/bZVdGXFvpS4yMRpo17swYOXXLIT9
EEn00l5V51kStV8oPRKUywKU5kbLzgCmJ25IDBTjhZ0PcG1030mhyxzvExME1wMC
KY5pCaq7Z13zobKE4H1cP8O24ecgvjpKydDLi7r94sacCmaJuXs2G+GDq8oO3mwY
spkR5NTd3mz79xm+r6l45Qw1Dh/MumwnnEPWtIXCKWplDWXLAgwij3SkfTjIScyD
grC86Y8hpjfCF93Sa7S7dV3Et9JmU0wiUeRqikIccj18RQ1ByiPcDrmnjDldA+MJ
GZBCsZV9VQMWQpuAGB72GXY6wmA+Gy7iUomAzvszTGz80JGeKIz/8madiXaQDAIi
w2OVuM/Tk8TvehP6Z7LpGU7Ztg7iUp9RBLO9+G6lpglVvfnoxVFhquEVZ+HA5G2T
f3wKJvqiZzkee56jyjTa65kRjiaiJG6/YDU6JoZJFvaSqh87WxV23E12Z9u9aZ3f
PV+0Q2hk5RLOdzKKz12+WW3i6dn+kcV5gcibqcKpAppeox9o0bF7pH9hzScFI0XM
aSStyrh4/Tu7NTdAwxStbzMc4q4fysg0C8Hm/rXF7JfSfN0JmexGL3cWSarPB4Ou
l7QiyDIdBqFAJqAr0gA=
=KRvG
-----END PGP SIGNATURE-----

--Signature=_Thu__5_Apr_2012_10_02_28_+1000_qHeADNe_aR+J5naq--
