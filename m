Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CA3A1A0BA9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 15:38:26 +1100 (AEDT)
Received: by mail-pa0-f49.google.com with SMTP id eu11so17173903pac.36
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Dec 2014 20:38:24 -0800 (PST)
Date: Thu, 4 Dec 2014 12:38:16 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 1/3] Revert "clk: ppc-corenet: Fix Section mismatch
 warning"
Message-ID: <20141204043816.GB14597@pek-khao-d1.corp.ad.wrs.com>
References: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
 <1417596833-31456-2-git-send-email-haokexin@gmail.com>
 <1417665891.15957.238.camel@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
In-Reply-To: <1417665891.15957.238.camel@freescale.com>
Cc: Mike Turquette <mturquette@linaro.org>, Gerhard Sittig <gsi@denx.de>,
 Yuantian Tang <Yuantian.Tang@freescale.com>,
 Jingchang Lu <jingchang.lu@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2014 at 10:04:51PM -0600, Scott Wood wrote:
> On Wed, 2014-12-03 at 16:53 +0800, Kevin Hao wrote:
> > This reverts commit da788acb28386aa896224e784954bb73c99ff26c.
> >=20
> > That commit tried to fix the section mismatch warning by moving the
> > ppc_corenet_clk_driver struct to init section. This is definitely wrong
> > because the kernel would free the memories occupied by this struct
> > after boot while this driver is still registered in the driver core.
> > The kernel would panic when accessing this driver struct.
> >=20
> > Cc: stable@vger.kernel.org # 3.17
>=20
> I don't see stable@vger.kernel.org in the actual CC list.

With the above cc tag, Won't this get automatically included in the stable
tree once it is merged into mainline? As I know, we only need to explicitly
send the patch to stable@vger.kernel.org only when that patch was already
merged into mainline without the corresponding cc stable tag and we also wa=
nt
the stable tree include it. Did I miss something?

Thanks,
Kevin

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUf+U4AAoJEJNY7TDerrFx5gcH/0jPvUAwHh2rCuTHyv3aD+jS
o3gMpk1E79MsquWfhhnpp35qawDWf4sFCLw3f/GR+hbu8a5OBTPb7VQrIvblrVvR
QC81V7xIc2UQefh5Ua2dpTQvgUbFxTky2+TeGHSEarSGtYqa3MHvACUDJwVIK/yT
atqqKJeMBPJjkkw0Jw/bBWXvvxOyy3A5zgXnDlX3PBOXTI7vUkn3mIYRTHasWwAc
Cjo35B5c9++0M5toGVmDT5tMxR3sEW+oqsWd38uAPRpxnwI09QOz4/lLx7qk1MqA
X5cBCc3pS1ysRHh7GBmVV+9XzurWGEACYI6mi5hyCq9e44OyAV/CgqtGVK8Ns+k=
=9UW1
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
