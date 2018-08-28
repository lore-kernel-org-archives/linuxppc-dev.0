Return-Path: <thierry.reding@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42053K5Vx3zDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 20:44:09 +1000 (AEST)
Received: by mail-wm0-x243.google.com with SMTP id c14-v6so1406009wmb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 03:44:09 -0700 (PDT)
Date: Tue, 28 Aug 2018 12:44:05 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Andy Gross <andy.gross@linaro.org>,
 David Brown <david.brown@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-soc@vger.kernel.org
Subject: Re: [PATCH] soc: Convert to using %pOFn instead of device_node.name
Message-ID: <20180828104405.GB9386@ulmo>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-43-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
In-Reply-To: <20180828015252.28511-43-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2018 at 08:52:44PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>=20
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/soc/dove/pmu.c            |  8 +++---
>  drivers/soc/fsl/qe/qe_tdm.c       |  4 +--
>  drivers/soc/qcom/apr.c            |  2 +-
>  drivers/soc/rockchip/pm_domains.c | 44 +++++++++++++++----------------
>  drivers/soc/tegra/pmc.c           | 12 ++++-----
>  drivers/soc/ti/knav_dma.c         |  8 +++---
>  drivers/soc/ti/knav_qmss_queue.c  |  8 +++---
>  7 files changed, 43 insertions(+), 43 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluFJ3UACgkQ3SOs138+
s6GD5xAAwk8wk3MMJcqmINxPuZwkmqEhM9UEvObejj4eWhcJyTTaZVxWDSImevoN
qlqEesIdQPZ/zqjTf9b0SHsIfRIEy+kUSjEajNaVPTy9WAuPl8H/34yO/e/nUU3U
jnwt58kIpeoU1kMvVzTCloBRJE2JNRV6IdzhMp8Dr7XFZdKUxgFylx7KQRM3HcCH
O07fktTO4MDKlhceR29zG70cnVVudfZ+IOrUFVKwwyh6G3RSBPsJIU70fWpUoyvN
DHsLpfGPVHPy+uHerLL9BTCrq4cwpZydHUs5f7ehWda8h8pexx2DsSxzsStxzuW/
2JhiCvQlZC9cMtTYYVQV/ewAA/AyR0Qk5GE8hkSUmmFqGVrEPqG+UWSQEJwi+NyG
n+v8zJauq1LFYvvIcm/SMKmw9lhVfPtWVeaPF5WXdegWAHcmG6smtXcB6ObxCvEk
kA0Y38kezs/DQzSrqyJzkU6L36Vl6UiBU5PKeL3CpKQ2XhOerw8d23Yk2FnGxCCf
p/DyDWFLlb+ocQ/YSyheBKZ9xKFPFvNwMs6KOEjV4DrWI0AUNflRS9/0R022y1tH
rPR9pGJ66CatN3iz207Q/w7XBpkVPqtVl5oBWlxsqRtcBsFV82Xcq5TiIGFLSWMR
/EP9dvrfcBZ+62YR2ByJv09XoYgMBcFcdX5JqWVqlTwYGdM0qM0=
=WnQr
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
