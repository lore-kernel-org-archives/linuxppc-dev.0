Return-Path: <balbi@ti.com>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CBDC1A0748
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 04:34:13 +1000 (AEST)
Date: Tue, 4 Aug 2015 13:30:59 -0500
From: Felipe Balbi <balbi@ti.com>
To: Robert Baldyga <r.baldyga@samsung.com>
CC: <balbi@ti.com>, <gregkh@linuxfoundation.org>, <Peter.Chen@freescale.com>,
 <johnyoun@synopsys.com>, <dahlmann.thomas@arcor.de>,
 <nicolas.ferre@atmel.com>, <cernekee@gmail.com>, <leoli@freescale.com>,
 <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
 <robert.jarzmik@free.fr>, <michal.simek@xilinx.com>,
 <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
 <linux-usb@vger.kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-geode@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, <andrzej.p@samsung.com>,
 <m.szyprowski@samsung.com>, <stern@rowland.harvard.edu>, <petr.cvek@tul.cz>
Subject: Re: [PATCH v5 40/46] usb: gadget: epautoconf: rework ep_matches()
 function
Message-ID: <20150804183059.GC9623@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-41-git-send-email-r.baldyga@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
In-Reply-To: <1438351258-31578-41-git-send-email-r.baldyga@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2015 at 04:00:52PM +0200, Robert Baldyga wrote:
> Rework ep_matches() function to make it shorter and more readable.
>=20
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>

this regresses at least mass storage. How did you test it ? I'll keep
all patches up to this one, please fix the problem, rebase on
testing/next and resend the remaining patches.

cheers

--=20
balbi

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwQTiAAoJEIaOsuA1yqREn9QP/0X2aNlkKVBwLNCCW3TvSshr
7CcCEFbtFfBMwSHAowzm5A/XxS3LVYc8oIDc6O1ZaUP3RqB3WTXuPC4bZ/B7Xtgl
bP+Us6DqMcxCUm4w512IfW2hhHzfFL2ZcgjLxyuRM1xJBGzfLYEp4iP8NPYbO9S+
BRZ7h0w5ob10FrS3uwh0rswBv1jnrs5GEVfOMu/r9e81IPmijbi1B1qSs56tanXW
Rq4yVUTa9YoRX1BAwynKwNPfGl4cZdPCLSxwFR9R3xA5J58nSzcRLJOE5z3PwswB
mm2KEGJA9kwiteasTDX6pYYgj38tCUlZL4odBN7n0Wyjo3R5lDO/fGgQGrkM4M3i
mVTF2KW82+u6wkmfbYZD/tjQ0aNXFIK9mnujI7vajF+4H/FfHQrTan1/9CybnOCu
Fzx4lR4ch4lOZEc1vzy9oo6RxmGMrt1KDIVnRJbBV6thhRsu3TWIy4/IlUvWvv0S
zD7AzLcCPMwvT7UrcLzsWQiJyphyQGBQkvvWcfc7pKclENWE3EB3lAKnA0qoE+7l
Xs/2SMuPuNd9Bsp797F8XideVU1aYeXDsbfBdeG5vXZKHKqaHCIVeUApxNiuGqT8
Rv7e0VRNLpgswc5hfVIjeQSKZuNPSaGHO81AH8tP4Q60naoBZ6TvEPzHIqCtehF3
xn56Ib1RMFe3n2POJcHf
=yCEP
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
