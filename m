Return-Path: <dedekind1@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BF1E2B71AD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 18:41:11 +1100 (EST)
Received: by iafi7 with SMTP id i7so2734724iaf.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 23:41:08 -0800 (PST)
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
From: Artem Bityutskiy <dedekind1@gmail.com>
To: b35362@freescale.com
Date: Thu, 24 Nov 2011 09:41:48 +0200
In-Reply-To: <1322095306-13156-3-git-send-email-b35362@freescale.com>
References: <1322095306-13156-1-git-send-email-b35362@freescale.com>
 <1322095306-13156-3-git-send-email-b35362@freescale.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-GYr90kBodyQcuCaED/XK"
Message-ID: <1322120515.24797.296.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Cc: Artem.Bityutskiy@nokia.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 scottwood@freescale.com, akpm@linux-foundation.org, dwmw2@infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-GYr90kBodyQcuCaED/XK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-11-24 at 08:41 +0800, b35362@freescale.com wrote:
> +               /*
> +                * Freescale FCM controller has a 2K size limitation of b=
uffer
> +                * RAM, so elbc_fcm_ctrl->buffer have to be used if write=
size
> +                * of chip is greater than 2048.
> +                * We malloc a large enough buffer (maximum page size is =
16K).
> +                */
> +               elbc_fcm_ctrl->buffer =3D kmalloc(1024 * 16 + 1024, GFP_K=
ERNEL);=20

Are there NANDs with 16KiB page size?

--=20
Best Regards,
Artem Bityutskiy

--=-GYr90kBodyQcuCaED/XK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOzfU8AAoJECmIfjd9wqK0yYkP/RaJ/NQr9rgNt0MbLMDIASMs
itvVY8Uw99utfOLx3Sgjf95IbLWW+Fiz2lDiTg5jM8YQ/Lse2PHK7yctisJjpDNC
+7OL07HUOvlp4tCDlfV+Y0e80KetPKEkmDWsV8cpJTaCkii5pBx/NALGqLxhLVCp
BZFoZOaBdg52rWnf6/K+0j1PI1rY7F6wRtm5cR2+pV1nsQdnZa8tKn23CkK5ygLr
jGLN++iWQW/xdLvfIC0MIrf6527PNobXpmhjSQrLX8eqeZoW+RDH75b9A54d9J6W
JFBfzMghp7LS6Id1/DoJEooekj1SgZhzyPYHB8UNfl6Uh3JaOO4ADwDdI4aiUj96
XN/QdS4ofjabwCd7YOGDkeu3mhD3833eXeNwbGyP6+5WRzkPYy2E+3bQMgQJ6E/0
4IMprwZ8OUNvtIiwwn0VJwu09S7+UTOClg7LxDZblMMp6KDA/Led1jHivjuSKmU/
U56f4avrqnmtcinzniv7xgx5zj4b+efWYytl7eEq4KfxxhYB6wQUE68qGmTMyxkK
xSl8WgKZq6xQ8L6e3oYFAiLWHzq6WtTThM/PUE95RlV/FjHu1Zejwp10dGj3c4xU
iwSHA+WaXnRgiQ+Bxxou+QxZYDGI/uF/W/9yXiGXNxoH7EWRZDGx9TAkmbLO5bBV
ESRzrhcLbM1yLepsJ4q7
=OOLJ
-----END PGP SIGNATURE-----

--=-GYr90kBodyQcuCaED/XK--
