Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A17F31A05D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 04:23:27 +1100 (AEDT)
Date: Mon, 1 Dec 2014 18:23:20 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Danielle Costantino <danielle.costantino@gmail.com>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
Message-ID: <20141201172320.GC3212@katana>
References: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
 <1414537731.23458.120.camel@snotra.buserror.net>
 <5450AC85.40302@keymile.com> <20141113003418.GE2062@katana>
 <5465B285.7070005@keymile.com> <20141114082832.GA2180@katana>
 <1416274083.15957.96.camel@freescale.com>
 <20141125181347.GC9716@katana>
 <1416966097.15957.171.camel@freescale.com>
 <CAAVjN7fJyOh64p5UGRmv-UTnF47cERDfbHyHTuzQmQj8xTDEOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
In-Reply-To: <CAAVjN7fJyOh64p5UGRmv-UTnF47cERDfbHyHTuzQmQj8xTDEOQ@mail.gmail.com>
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>,
 Linux device trees <devicetree@vger.kernel.org>, "Boschung,
 Rainer" <Rainer.Boschung@keymile.com>, "Brunck,
 Holger" <Holger.Brunck@keymile.com>, Linux I2C <linux-i2c@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>,
 Linux PowerPC Kernel <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I saw that this patch was marked as not applicable, but on most qoriq
> devices the pre-scaler is 2 especially for p2020/p2010 devices
> arch/powerpc/boot/dts/fsl/p2020si-post.dtsi

Just for completeness: "Not applicable" given from patchwork of the i2c
subsystem means this patch is not for the i2c subsystem. In this case,
it is for powerpc because it was modifying powerpc dts files only. That
doesn't say anything about the patch itself.


--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfKQIAAoJEBQN5MwUoCm2M2YQAKt1jbo62vzgw+uocyTJENa0
3XU2ax6GcrffnZymRmYvO/xyuWipwWrkE146NlzUXlQyK77BDVJcowDt51u0C0tO
tJA4Tzik2g85k+/6DzqpXLdQlFWWuWIPnvbKUaTbRRvTRWEc3vO8AndVGlXkyIMy
Wvgv6qh1QQzWjl8mQpGxN2eq5MsxAhKMVdVKSrb8YgAUbP7j0JQiKDU2sBHQ42eS
Ryd5jVxqddUyEKDctoLXfF8TcOdU1PsrJyTCNrKGej3htCT2pnOZQXyyB/dxtsaO
i1y+8nOQJHemcYuAC+0q/grzIZAW/zpTMNujLEU/tho4vOZgaKjelBf3rvFGMeM4
JRyTt3f3tELVw28a9+i5tPEQNViCcx7vaeie7e6i35LgJaq5cymKZRgjV7uKXNMb
OUazENr9HF+fp03GOOquMcphZQMwDsjy5BxDQB72x4LJ/HmgH9Zv4CWvp0wNskzd
Twb0chGR2EYFaFbX34yM9t+d7z6ZVm2qXvng8kipxkLPniJIfXRCXyl3iIU4Hf81
+6Vsl+ITQXNdwh47i3qljXA+ZACgN8jseMdtguB+EW17a/ExLQwpaNUmPgLryMDM
15uX5crduWrfxbsSjSWO7n4IXj6ZoGEXeIXjwyQtJ/pr83sn5weDzdnmUQOFWyIT
0SZAChYQ148sLyu348iS
=WHGN
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
