Return-Path: <balbi@ti.com>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D3CEB6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jun 2011 19:32:49 +1000 (EST)
Received: by mail-bw0-f54.google.com with SMTP id 12so5144805bwz.41
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jun 2011 02:32:45 -0700 (PDT)
Date: Mon, 13 Jun 2011 12:24:39 +0300
From: Felipe Balbi <balbi@ti.com>
To: Tatyana Brokhman <tlinder@codeaurora.org>
Subject: Re: [PATCH] usb:gadget: use min_t() macro instead of min()
Message-ID: <20110613092438.GK3633@legolas.emea.dhcp.ti.com>
References: <1307877290-26672-1-git-send-email-tlinder@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2feizKym29CxAecD"
In-Reply-To: <1307877290-26672-1-git-send-email-tlinder@codeaurora.org>
Cc: "open list:FREESCALE USB PER..." <linuxppc-dev@lists.ozlabs.org>,
	greg@kroah.com, linux-usb@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>, balbi@ti.com,
	linux-arm-msm@vger.kernel.org,
	"open list:OMAP USB SUPPORT" <linux-omap@vger.kernel.org>,
	ablay@codeaurora.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--2feizKym29CxAecD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,


On Sun, Jun 12, 2011 at 02:14:46PM +0300, Tatyana Brokhman wrote:
> Signed-off-by: Tatyana Brokhman <tlinder@codeaurora.org>

I need a sensible commit log for this. Why do we need to change all
min() to min_t() ?

--=20
balbi

--2feizKym29CxAecD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN9ddWAAoJEAv8Txj19kN1oP4IAIpN/ZiTxdotBDFX1Q7Kx//H
q8ddGHEf9Gp4aYVY18OT25W1aRtQVVfMzbHxwssSN5ZRq7GRktnY/c3yV9ar1vB1
99Ao41XkWUCLhQKM0L+vQifG8Ufutom3VlYxl6GkmgNgj5cSsNzspNkQnGl5M6sO
hD7tNiwOznuwX4ygZ+vC4EhCq0vjnh5IY8PuJjmIr+t7V8qCJA/OOifit0/e6sdz
8VMiuNJQehqk8EYo2TcbVR9gnoID1mzbWeh5/LzlRz60uZSgDJdERidYcq/kcndO
K0jUCJvMKfySXoP9bhlPGxR8WUflFZqSjvIrB94VyWn5MWzXKOyVX5OciyQbLpA=
=awIV
-----END PGP SIGNATURE-----

--2feizKym29CxAecD--
