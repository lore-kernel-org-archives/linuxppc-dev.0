Return-Path: <tomi.valkeinen@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59A781A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 18:51:31 +1100 (AEDT)
Message-ID: <54FFF3EE.3070400@ti.com>
Date: Wed, 11 Mar 2015 09:51:10 +0200
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
MIME-Version: 1.0
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 03/15] fbdev: aty128fb: replace PPC_OF with PPC
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-4-git-send-email-haokexin@gmail.com>
 <1424995875.4645.42.camel@kernel.crashing.org>
 <20150227010549.GA10596@pek-khao-d1.corp.ad.wrs.com>
 <54FEE230.6030006@ti.com>
 <20150311043811.GF28582@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20150311043811.GF28582@pek-khao-d1.corp.ad.wrs.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="oGwk8lbKunKadRHJ00277hRp59sVMXKAR"
Cc: linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--oGwk8lbKunKadRHJ00277hRp59sVMXKAR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/03/15 06:38, Kevin Hao wrote:
> On Tue, Mar 10, 2015 at 02:23:12PM +0200, Tomi Valkeinen wrote:
>>> I just sent out a v2 [1] a few hours earlier with some minor updates.=
 We plan
>>> to merge this patch series via the powerpc tree in 4.1 cycle if I can=
 collect
>>> all the acks from the corresponding driver maintainers.
>>
>> Fbdev changes look ok to me.
>=20
> Hi Tomi,
>=20
> I assume that I can add a "Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.=
com>"
> for all the following patches, right?
>   http://patchwork.ozlabs.org/patch/443890/
>   http://patchwork.ozlabs.org/patch/443891/
>   http://patchwork.ozlabs.org/patch/443892/
>   http://patchwork.ozlabs.org/patch/443893/
>   http://patchwork.ozlabs.org/patch/443894/
>   http://patchwork.ozlabs.org/patch/443895/
>   http://patchwork.ozlabs.org/patch/443897/

Yes, that's right. Sorry for not being clear on the ack.

 Tomi



--oGwk8lbKunKadRHJ00277hRp59sVMXKAR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU//PxAAoJEPo9qoy8lh719t0P/jVOSwn7WVlpsLLqEezSiLCH
kB/+E6GQ5OGW82TjvhZYIA553eci7OeeY+Vvuj4lfkojV/kJVTBWaUCpZNbT+CmN
agsrSLkr379YcSPITWoZg6je74a+jEzh6Fq0KViRL+xjgSQ6p14VTkRaz5oMeLVB
qqZHYSS1HpXmQZQc5dB3TekeVumGH6jWNVM+YjC68yks0/TWXikA4XG15QVQkPIB
LtsFOw0RlLuSAXXm6TClaQCPfbI3aj69TdSJG6Ge2syit/wURlbMSBTkVrmKgyjF
f7vquy/VHeIYKr5wR2N31x7fcG1hDac5gxmaaulhiA/YgVPuuZBrGlMrgCTSfIpQ
O30cpPKgXNJJmttH0XZjZzflVQesxQjVal1GAKbW/jvf8mHMCh1h06QwYTyH5nrJ
lWtRux5VCOr68yYUU7h+uiRmYJZbSlvIJFjtKF1Q7V4sAmHZ4qzij+r6lb8QPFID
HaOi+cd1d37AKUJNCBtRGGeR8Y4cc54HXxauQz96vTq5zaYpXOpr5me/uUjcZpGe
vSEzEpvtzrXQm6KXqj0pvaIHDgL5DEzXr7PTJQL8QHpph52/8tSTbBJnG/YwsfVT
jUYyny8OUs0fkIZ9opsFGFVp+nUT3UvnSxCQBjQ7lZ8Qi3c/XVMRS/sevKD2rMna
J87o9N22U+lkFLe7l+VL
=Z6JI
-----END PGP SIGNATURE-----

--oGwk8lbKunKadRHJ00277hRp59sVMXKAR--
