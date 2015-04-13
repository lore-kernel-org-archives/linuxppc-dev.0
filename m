Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE1AC1A01C9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 17:55:36 +1000 (AEST)
Date: Mon, 13 Apr 2015 17:55:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: linux-next: manual merge of the powerpc-mpe tree with the
 powerpc tree
Message-ID: <20150413175531.13d4ceb7@canb.auug.org.au>
In-Reply-To: <20150413060913.GA2365@richard>
References: <20150413132715.2303253f@canb.auug.org.au>
 <20150413060913.GA2365@richard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Bpm20_GRTbH22/ObcniWoux"; protocol="application/pgp-signature"
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/Bpm20_GRTbH22/ObcniWoux
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 13 Apr 2015 14:09:13 +0800 Wei Yang <weiyang@linux.vnet.ibm.com> wr=
ote:
>
> Hi, Stephen,
>=20
> Thanks for your finding :-) Your fix looks good to me.
>=20
> Michael & Ben,
>=20
> Do I need to rebase the patch or what should I do?

You should have nothing to do, Michael has fixed it up when he merged
Ben's tree into his.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/Bpm20_GRTbH22/ObcniWoux
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVK3Z4AAoJEMDTa8Ir7ZwVytAP/jclrvEp0a8+4y7X51ex0SmS
yF1N5jDQQcLv5jEdeZOQZrsuzv6MPoTl9DlAFScb0Q0UZs4jn7CsIyqmjT64VvsD
8Ahr1v7gXVFjNrYH53UQ0A+0RAybiDlh7I+NK1hnb03lnRtBq2KWzZR2h+//rjQy
8mcZ875kH9YoEso5h8I2sgyIMHIYncn7jKEMG4syD4uLtV3xrNVy+Kl47vNmzqjT
AiXWvPQrOo6kXjy8kP7fitzBDOY6NeDQlVb+fOZ8ktRTjPg66KEkjunrNmjuUYWW
tj633BMdczlgVVLPP4o2SJL197WmCbPN7XTWqiuaoQjPhd0ddxnDzYTGbhsv/mVi
HeshPp0+41KFCZqUPvpqdB6d60gcfpY9rbXb/x354O9/uoQ5W9maV2UJR03WaVeN
p4xAIrXalzPTS/tDtvnLdwEA/LYenBQyJPoUCWKsY/zRvAud4pQ0/tYiffemovHU
VAfwJZYwMDR88JRM4UFPbh1q0NX5S3iqYFCteC3ry5Cy1IJIznsmam/SHQMtaWJH
fWu4n0sJdX06mVcPr0+ra+gotmaDwccoh0NMe+CrvPAEu0hmcr9DVFkJV1eBzzpW
s6S08i7CGHTl+YnWu/kQIZjLn403GNSu4rZrG5GP+D3gYDPNOcLDoXSOhoDApY+u
t9wowbztZMSPb8mO5wpC
=pUej
-----END PGP SIGNATURE-----

--Sig_/Bpm20_GRTbH22/ObcniWoux--
