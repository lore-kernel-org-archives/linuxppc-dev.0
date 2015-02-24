Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34DC01A0A03
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 03:04:56 +1100 (AEDT)
Date: Tue, 24 Feb 2015 17:04:46 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Eddie Huang <eddie.huang@mediatek.com>
Subject: Re: [RFC 01/11] i2c: add quirk structure to describe adapter flaws
Message-ID: <20150224160446.GB19444@katana>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-2-git-send-email-wsa@the-dreams.de>
 <1421387408.9323.10.camel@mtksdaap41>
 <20150119150514.GB3820@katana>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
In-Reply-To: <20150119150514.GB3820@katana>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@atmel.com>, linux-i2c@vger.kernel.org,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 04:05:15PM +0100, Wolfram Sang wrote:
>=20
> > > +	struct i2c_adapter_quirks *quirks;
> > >  };
> > >  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
> > > =20
> >=20
> > I suggest to add const.
> > 	const struct i2c_adapter_quirks *quirks;
> >=20
> > also, in i2c-core.c, should modify:
> > 	const struct i2c_adapter_quirks *q =3D adap->quirks;
>=20
> Thanks, I'll think about it.

And added it...


--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7KEeAAoJEBQN5MwUoCm2jRYQAITq2tQyrAoIW8anKxRI8hOl
dpQG58/aM6kUwQVPbU3OJVTN+///VI2KPqKDg6rbTVDCePMKgyCr/kYCCfOxJbkr
xSUR9csPjPmsJn2ZeQW2VE1OoOBQeC27rOj4qpZ3qJu9Fc9vNi+8Ze64OStsLEw4
P+ZEAunCNvAhU777LBsU/MuAeKZTNvV6bKwOMR3nxfedMQt9zBMFPGYi2C78N5T/
gb/j4W+QVnoDQrvebUeWlbZeKIDgQgP/ychMHFAQ2QKLlRIuCIFFjg2jWYkRUK1I
qm4zuCji8pKs0StD3xrZpOb5MndO6EEjm8xyTbgtCmMwE81FdUwORmuauyeULjzH
ArNxETpZI2YYhtmtkiynfWPXMv/s62gAP+wLt28o7f1IIpJPMryQedYmIxHmIskq
CeBsqwlYUSIyiFoGVkWsC7AkcEoRcpDkSVdHtkVN+o2LjDxwGengcb7MdXNgt/xJ
j1eqZ7d1XQ3DzHMNvYfEwDE8gZPnzx3cIo/7aqfXSl8gx1hT+FvjSSHpZcvf1zqb
OihC3ZEQdsgreaP1qhSJriv3EAdZvhTlY2YOsKxjPONtDYpObSgoBpM1gXZCLfuf
ysRev2E8GhzoB5QFIAmJYbhRE5lJ9IXRKovz8wg+lO55tP0lJCYJPXtUIFhjgH21
nxtKytmO2wMfl25NQ2KZ
=dDPf
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
