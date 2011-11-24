Return-Path: <balbi@ti.com>
Received: from na3sys009aog118.obsmtp.com (na3sys009aog118.obsmtp.com
 [74.125.149.244])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 530CC1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 20:49:04 +1100 (EST)
Received: by mail-gy0-f174.google.com with SMTP id r1so3207140ghr.33
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 01:49:01 -0800 (PST)
Date: Thu, 24 Nov 2011 11:48:59 +0200
From: Felipe Balbi <balbi@ti.com>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v2] usb/fsl_udc: fix dequeuing a request in progress
Message-ID: <20111124094858.GV3352@legolas.emea.dhcp.ti.com>
References: <1322050376-13553-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Q/AGl/UrDvkbRExF"
In-Reply-To: <1322050376-13553-1-git-send-email-leoli@freescale.com>
Cc: gregkh@suse.de, linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 balbi@ti.com, Peter Chen <peter.chen@freescale.com>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Q/AGl/UrDvkbRExF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2011 at 08:12:56PM +0800, Li Yang wrote:
> The original implementation of dequeuing a request in progress
> is not correct.  Change to use a correct process and also clean
> up the related functions a little bit.
>=20
> Signed-off-by: Li Yang <leoli@freescale.com>
> Cc: Peter Chen <peter.chen@freescale.com>

applied, thanks

--=20
balbi

--Q/AGl/UrDvkbRExF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOzhMKAAoJEIaOsuA1yqREISAP/3BYVdT5fyMAI3rD7h+WOLif
FF37XioK74mF1KX8axrymqwDQB+HzJBov09jKYws1HMiwQcsg88DQyRghcEHZWnu
l8apd5o4rWAoNz3UahG0xSOmkKwXrYfbuM6rtAkW2FRgY97NstjkIIOmqGK0xIY8
whXgA2QetfWhHF2dlpS9YZlzSrRIiAKekJ3BsIebGQEYrqlvRh2nFkcxEdcB8+Xi
IlsYUZuZJ7WQwfskXRwmCwWRO22LyjWqc1OfEP+1McSfd8F8kw2bMJNGVxr/O9hK
08u2GxPsC+ccBafRFo0Glt6AOJ43+F2XV8/8ynsF8df5QYzrF0zs+jyF7r8YvAkM
shlFcOBsGNFy2mNkh2R8vyWaFQx8mytzPe75jcn0/sPgS3LbNYHXXHEpcscTGLnL
WcjRjv4fya3ZHtwceP/nsksPuis58cyXjBbGf+IQdoNoTVtp75KZqiIMDOldP6w9
5on2femOy58Sp4JzdaHfx+ZsySo8QT9uIi9vCSp+VOBY1H8I4O3d9yIW76Ickdb0
1QfdA5W6cWBKBKoNUdszYlpWzcC9s+L9a2b3OoIJvhAWFdko+evCCQn651dhhyl1
Mv6LkYHx+lY3XugkKUACYit5jPjYFXIlSLgnLS75XtxIsijktTgcpNayxqSKrpXG
BtJtVzPKWNCbrM7NjNuw
=H1tm
-----END PGP SIGNATURE-----

--Q/AGl/UrDvkbRExF--
