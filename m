Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4073A1A0094
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 08:46:48 +1000 (AEST)
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3E6941402EB
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2015 08:46:46 +1000 (AEST)
Received: by pacyx8 with SMTP id yx8so27602426pac.1
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2015 15:46:44 -0700 (PDT)
Message-ID: <1429051591.13579.1.camel@axtens.net>
Subject: Re: [PATCH 2/2] powerpc/cell: Fix iommu breakage caused by
 controller_ops change
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 15 Apr 2015 08:46:31 +1000
In-Reply-To: <1428994146-23180-2-git-send-email-mpe@ellerman.id.au>
References: <1428994146-23180-1-git-send-email-mpe@ellerman.id.au>
 <1428994146-23180-2-git-send-email-mpe@ellerman.id.au>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-EMYDPa28+yHeCLh5npFm"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-EMYDPa28+yHeCLh5npFm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2015-04-14 at 16:49 +1000, Michael Ellerman wrote:
> The recent patch to convert cell to use pci_controller_ops had a small
> bug which broke machines using an iommu.
>=20
Oops.

> The set of phb->controller_ops was added after the check for name !=3D
> "pci", meaning pcix/pcie PHBs weren't getting their ops set correctly.
>=20
> Fixes: 9c1368fc50e7 ("powerpc/cell: Move controller ops from ppc_md to co=
ntroller_ops")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>


Thanks for that.

Acked-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

--=-EMYDPa28+yHeCLh5npFm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVLZjRAAoJEPC3R3P2I92FyCQP/AqEoEwVLCsc99hVc0TWu+0j
Ty9+FztvI02H1RPia4fU3HfqPhSVD67tIRQ1T9irwgSiNF2Ox8hFQu0O3CEPccy+
zvK8sh2ff6rCqN7Zxd6aaa4ExPqE4sPjVb6QNi/Q8JDwOf1Uq8GnwRWGtYQFngfT
XIyGhoFB8vHK2EEZRb0TBQyIkIAHLNlJcNUqq0l7mIIn44QCOoH4p/P7tK+Dk3Ou
0umHH7q7hH3X3KZTZ2dqmYahUQ9sIVTpEgBrBZAYX9h2j1xL0brtLS5AJy5pvnaI
hNkLoi7l/ftMxCAyxTAWkev7VLCPWsnfZw6SXwsa6FkNVXYJZibcjvOSx17BWfKU
7FWxoADtqgi2OVlic2m5vv5ir5kK7QeUK2jH6R04PaXC41oB+tg66E2WshXRWHTl
NrTxlYTtLsFJZUb0LtaZm0g9U7ud6rjZHfT2Ek/jogERoTXF5/itIXYPa4f9DhQ+
AJ7M6JmYIY8YVwv4mTJMBd8SWPYwFtyMKdUEIpb0pNlIT3Tu1H9N+wqvXxBOZInN
vwTwsA6rR+3cjMjuYxnTa/BgF4Zmy5pzT2a6cXTwIZErXnqXEIn/k2WICOn5g275
KSYFsUPh3KDSP/EV8bndLBzyk/a98d2go1x7zTd1ke0ctOqohFJebu4lpxQI9FMP
zjA3aqsPygHWiiq8Fx4w
=Fze6
-----END PGP SIGNATURE-----

--=-EMYDPa28+yHeCLh5npFm--
