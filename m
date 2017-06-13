Return-Path: <thierry.reding@gmail.com>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn8PX1lJczDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 22:35:44 +1000 (AEST)
Received: by mail-wr0-x243.google.com with SMTP id g76so29618900wrd.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 05:35:44 -0700 (PDT)
Date: Tue, 13 Jun 2017 14:35:38 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/44] firmware/ivc: use dma_mapping_error
Message-ID: <20170613123538.GB16758@ulmo.fritz.box>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
In-Reply-To: <20170608132609.32662-2-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 03:25:26PM +0200, Christoph Hellwig wrote:
> DMA_ERROR_CODE is not supposed to be used by drivers.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/firmware/tegra/ivc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlk/3BoACgkQ3SOs138+
s6HPehAAsPH3WCVEat0HG8XtDXXMKUx9atqqkjijlfz3wzr3Yu8oeWJkmauxBI2J
xWvBLcQSO632cLKWDXp9sfnjUN9McgOQi4LbbEnJZ3Wzovtn86aaPUXEtbrUImTw
P57+RXkSbiFiGp8LlUECzxlshCYZHbzvOmqvdxpBqOTjQfv7fehxm+SVPJgkRflE
EUuCItQsdBhnqBOtq743sf7Ck4QJ3Kz4pLGgntIDINnwiPxWjpMpI06SeVnvK2st
d5lq46pyBdS3dliCsRcn6jukf79HzS/jStxG8r5YCEkRfCPvw0au5ds8iywvCZrZ
hJYP0tumPW9j/x0ZC35a6j4dIbotmuhqCE2mYJUjG2mKDtAtdqZKVBvwKUmxzGok
H7YKQDZN54UOBVg4Rzsbu80eyYc2jFZEWIhICrQUYVM534Psw7LGnA6hMiv5X8aS
J4T7cOnL+71/iwE9Ey5EdvTbV22/mcx711OcyPbZ7q5Dv4AZE9HdJrPTF1rf1TeA
WDqgA3BbY6JNflUayq5in0OxeyN8/qKbJr9ozhXgCNKNUUH5nihjT4LZxENEWV2p
pRCppkKHw9Wmze/9cDuINms2Ef1DlEzxJ9BqE5mtiFFsCq1mn9EUxgMt4vbbfMqC
Ynk0gIB134Hm0HIXoJcwdQ/27Ltko3nyeRm+28ka/gS8GVgYtec=
=jGwQ
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
