Return-Path: <haokexin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E87551A0CBE
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Feb 2015 10:17:51 +1100 (AEDT)
Received: from mail-qa0-x233.google.com (mail-qa0-x233.google.com
 [IPv6:2607:f8b0:400d:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5BD1314012E
 for <linuxppc-dev@ozlabs.org>; Sun, 22 Feb 2015 10:17:51 +1100 (AEDT)
Received: by mail-qa0-f51.google.com with SMTP id i13so17493959qae.10
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Feb 2015 15:17:48 -0800 (PST)
Date: Sun, 22 Feb 2015 07:17:40 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc/dma: Always configure ZONE_DMA32 correctly
Message-ID: <20150221231740.GA3255@pek-khao-d1.corp.ad.wrs.com>
References: <1424421325.27448.41.camel@kernel.crashing.org>
 <20150221112607.GA5321@pek-khao-d1.corp.ad.wrs.com>
 <1424557431.4980.4.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
In-Reply-To: <1424557431.4980.4.camel@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@au1.ibm.com>, Brian J King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 22, 2015 at 09:23:51AM +1100, Benjamin Herrenschmidt wrote:
> No it won't, or am I missing something ? Ie, limit_zone_pfn() will only
> reduce the size of the window, never increase it.

Yes, you are right. Just overlook this. Sorry for the noise.

Thanks,
Kevin

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU6RIUAAoJEJNY7TDerrFx3sEIAMI0WxmCnQ0tF3pbG+JVQpwF
0AfjQmOa0zzn5UmUWp2oNJ5tXnSMLWTAxQfZpn5KasQZYfEuN73w8JvjsfgJX7QC
1z19GYXdhVlwpOpYOAsXb1wPhUymVwyP5FRpgLOHy9KFi+yd0CT17gi8lsu3gV8+
fjIqrAg39pErNjDZDoDUihz207GN6mWEMaAUkmrQ+vCm5WuQbwcCJ9COwIeAGbRA
HPfW7qQk+Qaxr18wY6eFjEmInw++vUy4gaH+I9ZcIJA4JtEL9gJoU9HexNqly5BU
JXJ6TtYHCM48S84bLtdoI9DSlYIG+I6rEL6hVU20+U0XvrblTAYzS4e+o/6Qd8Q=
=rfzY
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
