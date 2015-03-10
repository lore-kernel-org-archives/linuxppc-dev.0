Return-Path: <tomi.valkeinen@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3B5E1A03B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 23:32:15 +1100 (AEDT)
Message-ID: <54FEE230.6030006@ti.com>
Date: Tue, 10 Mar 2015 14:23:12 +0200
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
MIME-Version: 1.0
To: Kevin Hao <haokexin@gmail.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/15] fbdev: aty128fb: replace PPC_OF with PPC
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-4-git-send-email-haokexin@gmail.com>
 <1424995875.4645.42.camel@kernel.crashing.org>
 <20150227010549.GA10596@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20150227010549.GA10596@pek-khao-d1.corp.ad.wrs.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5NpOSDLisjqi9JIadBmijFVpT0jJBaQKv"
Cc: linux-fbdev@vger.kernel.org,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--5NpOSDLisjqi9JIadBmijFVpT0jJBaQKv
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27/02/15 03:05, Kevin Hao wrote:
> On Fri, Feb 27, 2015 at 11:11:15AM +1100, Benjamin Herrenschmidt wrote:=

>> On Sat, 2015-01-31 at 21:47 +0800, Kevin Hao wrote:
>>> The PPC_OF is a ppc specific option which is used to mean that the
>>> firmware device tree access functions are available. Since all the
>>> ppc platforms have a device tree, it is aways set to 'y' for ppc.
>>> So it makes no sense to keep a such option in the current kernel.
>>> Replace it with PPC.
>>>
>>> Signed-off-by: Kevin Hao <haokexin@gmail.com>
>>
>> For this and generally the whole series,
>>
>> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Thanks Ben.
>=20
>>
>> Which tree do we expect this to go through ?
>=20
> I just sent out a v2 [1] a few hours earlier with some minor updates. W=
e plan
> to merge this patch series via the powerpc tree in 4.1 cycle if I can c=
ollect
> all the acks from the corresponding driver maintainers.

Fbdev changes look ok to me.

 Tomi



--5NpOSDLisjqi9JIadBmijFVpT0jJBaQKv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/uIwAAoJEPo9qoy8lh7146YP/1UP6V+PcgFZzDtryhJp/v9I
vxA3G94XsL1+GZrNvz6CSnl17SS0nytds4UJikLSyvmQ2AjAKCkCcX2HsVq8kF4K
e1eo+rePMNPI7OUrdjt00rbauT2onn8Jhbm8ERHVNbnEjaK+OiZkC+54XatXjhmp
ReuSPRBmnIPgbLV2gLSxBQktPLz9jfrlJwwOa0TvaM8C/SkvZp6nZu9iptCUCAIV
Blx8nzUoSU4ojwAwDSKMDtmKodhb/L9FwKczQ1WYXgCiE/grWmb5tKJd62MKNmWc
2Km4zNwCueYY0n2msDsDN+Fc0d+wmANJB3U0f141povu+24oJ+w67nr1DxMk24dh
sDnu5/ZRIHVRfBxFmZrWkLB8KH2/Cm6LwFIpHUgp93XNe8efqFSbVxP3VNI7Z2oW
zKx58o23eDV0CO0vVFparDA3uxtjA+4Ch06NqjxCszAegAWcHwGgE8oMZzfjDMB7
r+hCtBiTR8uiDjZk5JKL/iy7/SqXLqbiUIgtPpALOGzUiPyDFUMchyeHfFvhphWR
fG0UBNPaeMP9IJstvsSYRd7iWJIj6SniwW4LiXq+tS3n5EXwYGPNPaeZKcgGFnJH
aVsciAtRV6YD02qda9590AMmI9m3vXHobv3uvTl+2hHVKgOTtr2XYXXd1DgWASSg
NQyWV7HjxQ0t852gIZqf
=FZKQ
-----END PGP SIGNATURE-----

--5NpOSDLisjqi9JIadBmijFVpT0jJBaQKv--
