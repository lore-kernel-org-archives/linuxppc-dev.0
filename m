Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F5471A08EC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2015 22:14:52 +1100 (AEDT)
Date: Sat, 14 Mar 2015 12:14:51 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Subject: Re: [RFC V2 00/12] i2c: describe adapter quirks in a generic way
Message-ID: <20150314111450.GC970@katana>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
In-Reply-To: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@atmel.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Eddie Huang <eddie.huang@mediatek.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2015 at 05:01:51PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Here is the second version of the patch series to describe i2c adapter qu=
irks
> in a generic way. For the motivation, please read description of patch 1.=
 This
> is still RFC because I would like to do some more tests on my own, but I =
need
> to write a tool for that. However, I'd really like to have the driver aut=
hors
> to have a look already. Actual testing is very much appreciated. Thanks t=
o the
> Mediatek guys for rebasing their new driver to this framework. That helps=
, too!

Thanks for all the testing. Merged this branch now into for-next!


--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBBgqAAoJEBQN5MwUoCm2fQAQAI1w0/RXIcR5OoBFBLw5DkCr
vA2Ou1OG9x9M2FP29hco4AzXRaRRHqe9hFRl31Adm0YoQF41/nf+7z4g1VveN4hD
P+ocEWMvzHnafbwGO0+QIYY4nhBVN+/a8eg+j4+AbKdQBLL2+b0I9uwpL1uwdiCY
ceRhoMrrg1oHcFUNKErXyuzA/t0dNq5ekx3z8iqpjjXjp3JRVmfpeueCzD6Gv0zg
HkXAC+U9Ur2gLvBpSRhadn9/Cy6cvOeuIF8Jq2wMOKDUM54Z1HwttT7dTiW8IGXo
xgXFaimc4StYeR1JQEyGLYUATfhXlOKPFOXrUktTwWLlGbgjKUqB3KKGDzR9XXB+
NvtWekSj9+h/c0hHYOiezMV21AIzr7n3c3cmAoK9XYMRz/NeTseC1jG4EgSVCQr1
Vl+QgAgOiOcSNJ3BPfLStNM0kAyPov0UB41EP25fWq3eOJMWUzUEvlLkJMadmPbL
ucvuLhMUvI1jp8EdTEiBltQuukM4tlHgp/tQrK245vO1s0NHnbOdgy68Lab7RfFp
KxbBwIQ1DOhMin80xOC9AUkkYbBppbqhCUc79Fpufx5FYSd+tS3dTLAdwOErmmSh
7YbWXMOdscAUD3+vuDYTWn4gPJGDtzM4MaYn2AAbGVchPa6UR/W1UZDKlpTDLcV/
wvo+3WNDb7KyV+YGySP4
=KnPk
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
