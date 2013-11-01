Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 676A92C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Nov 2013 09:27:40 +1100 (EST)
Date: Sat, 2 Nov 2013 09:27:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robherring2@gmail.com>
Subject: Re: linux-next: manual merge of the dt-rh tree with the powerpc tree
Message-Id: <20131102092732.321ddc2823d143320b73ee45@canb.auug.org.au>
In-Reply-To: <52742A2A.9080008@gmail.com>
References: <20131101162002.4dd386299ec42e8d8d032be2@canb.auug.org.au>
 <52742A2A.9080008@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Sat__2_Nov_2013_09_27_32_+1100_B7RsVgMIjSmbfKzt"
Cc: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>,
 linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sat__2_Nov_2013_09_27_32_+1100_B7RsVgMIjSmbfKzt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Fri, 01 Nov 2013 17:24:42 -0500 Rob Herring <robherring2@gmail.com> wrot=
e:
>
> On 11/01/2013 12:20 AM, Stephen Rothwell wrote:
> >=20
> > Today's linux-next merge of the dt-rh tree got a conflict in=20
> > arch/powerpc/include/asm/prom.h between commit a3e31b458844 ("of:
> > Move definition of of_find_next_cache_node into common code") from
> > the powerpc tree and commit 0c3f061c195c ("of: implement
> > of_node_to_nid as a weak function") from the dt-rh tree.
>=20
> Ben, I can pick these 2 patches up instead if you want to drop them
> and avoid the conflict.

The conflict is pretty trivial and so should not require any action.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Sat__2_Nov_2013_09_27_32_+1100_B7RsVgMIjSmbfKzt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSdCrZAAoJEMDTa8Ir7ZwVW/0P/2YCoiVz+izf0CTSv8yrYcxa
uWPjRDivRmFOGsAlv8/dKdrkprq6g3Ha8XXpKe8LOOVvM0k6buX2FS8MbdJWVDT0
KvO5NsG2ls3ft2wwmkJx0SXr1J6N8naBFveDegsKjjcMvKTiB/ZKrQ0iFDHLJtKM
XezXPEjZ7d0ZM2vf7rfuaiKIMDSB3eH9IPbuMMCXahgLkePM6ZzfiBWuUNGGan0u
1GMvWcQ7/y1T3neGoanG33nFQoTGS2z/XYdpxO+2ug0NGXLFgCM0w6UkH4RoweLd
gWhiK5a+HGQeOiwktEOjVJdlYngdRkMWm2zglwvQcuJXBlzWoJVU+FFWaCMY/mnq
WMCRwy2k0yw6VEqkavQPCnOesOu6wO8+Mjo5D25i6Da0NP8K9ncMm4zJ5szdG03O
LHzWrc2h+JTCBUw2dXAwBczj89qOu+bqLZOb75vmBLOH3QG2LsgSJZTsi2R1Vf7c
K6CUJQz5znYVq9v7xyUcnjxYvNVmemRt7LWFVSvRx3XFbEUw8BhOz9IAfd4nHIsz
OASw9l1VJ26Tu6vRXo4qKVaFc1YRycCxaCgSV7YSWfxwHsH5nhlOYJ95ec2BQfHr
pWpNF30PfJN2Aalc4LjQvqYjDrwEHk+j2sDn9LGRySmu2nJvwYsPFpKKEtOADw0D
e5uwpDOICiYpzZT0VoXq
=uP37
-----END PGP SIGNATURE-----

--Signature=_Sat__2_Nov_2013_09_27_32_+1100_B7RsVgMIjSmbfKzt--
