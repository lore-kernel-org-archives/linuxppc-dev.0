Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CDBDA1A0025
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 12:35:47 +1000 (AEST)
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 457F5140077
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 12:35:47 +1000 (AEST)
Received: by pabsx10 with SMTP id sx10so113524515pab.3
 for <linuxppc-dev@ozlabs.org>; Sun, 26 Apr 2015 19:35:45 -0700 (PDT)
Message-ID: <1430102130.6073.1.camel@axtens.net>
Subject: Re: [PATCH] powerpc/powernv: Fix early pci_controller_ops loading.
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Mon, 27 Apr 2015 12:35:30 +1000
In-Reply-To: <20150427020213.GA9830@gwshan>
References: <1430099666-9159-1-git-send-email-dja@axtens.net>
 <20150427020213.GA9830@gwshan>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-bYWdHg2utDpBpguVIhRH"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-bYWdHg2utDpBpguVIhRH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >Fixes: c88c2a188905cb3077c3c38dc498e7e9f8eebeee
>=20
> I think it would fix commit 65ebf4b63 ("powerpc/powernv: Move controller =
ops from ppc_md to controller_ops")
> If that's the case, the above line could be replaced with:
>=20
> Fixes: 65ebf4b63 ("powerpc/powernv: Move controller ops from ppc_md to co=
ntroller_ops")
>=20
> >Reported-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> >Signed-off-by: Daniel Axtens <dja@axtens.net>
>=20
> The changes look good to me.
>=20
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>=20
You are right again! I have sent v2 with the correct Fixes: line.

Thanks for the review.

Daniel



--=-bYWdHg2utDpBpguVIhRH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVPaCBAAoJEPC3R3P2I92FpfEQAMw4mOwrX8ZycMd+K9yGpI/H
BuusFstJ92ZwWzdW2piU6HE+jmLImp9n8qRTXGP7iEEvuV936YUV/xCD6Dvua0vm
qBHDkKfIN4C+uQG9lgg8sXHqXdXC/7e5cP+hKTNzie0VT/qR/Dg0JhvGuhHYgtD+
X9zQHlodxOsZylysLh1DB6qeRK4cIb1nSbfYLdU0iH93LyR+OQTopKInKHZAFngB
ZyqVu+lkrQeZqcFt3hEdk5Q6S0AK9O+B34EtGDUy9wCKqC+L/hGwuI8hrmCOBfIS
TSTfUzLrr/nAW3yhGCi0c8vZDjomKWmf7+OHD527/Ru9dMDi3N6Dz3aQ9gDnaXBf
q2rJKTLRz+ZBnwTWMTKSaVwc7G/gQ+1XAFnK9g2HgoSYcuUMXM3rUuIGmErJMuQV
3svO3/Wv4U5WO9/GRTVreGabBeTA87+sI+cTBz3ATN89CH/QOAMNkNvj5SKihrO6
1EvHnXIro2xcosRhMICfcKtl6jjnoRsRYDryMWkeHhlx/x9DV0vuFs9Dm2SWCzag
hcQiW6t6xox7CNmK1sh0QmDEwQ9tgOqZ5dIVtro7PNYid/FeYZlgrBx9kVTUb+W0
y67o7YINs83pp4WIbO9e6F9ZQL2zveYQxcua7VLs41a8rBbv0qKkaBt3zhZkAIDu
KGsydZzB38J5yUZCzjHh
=WJtb
-----END PGP SIGNATURE-----

--=-bYWdHg2utDpBpguVIhRH--
