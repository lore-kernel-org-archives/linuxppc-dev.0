Return-Path: <haokexin@gmail.com>
Received: from mail-qg0-x22c.google.com (mail-qg0-x22c.google.com
 [IPv6:2607:f8b0:400d:c04::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3CEAF1A0C32
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 13:43:07 +1100 (AEDT)
Received: by mail-qg0-f44.google.com with SMTP id l89so45760603qgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Feb 2015 18:43:04 -0800 (PST)
Date: Mon, 2 Feb 2015 10:42:58 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 00/15] powerpc: kill PPC_OF
Message-ID: <20150202024258.GB10730@pek-khao-d1.corp.ad.wrs.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422843937.11325.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
In-Reply-To: <1422843937.11325.3.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 01:25:37PM +1100, Michael Ellerman wrote:
> On Sat, 2015-01-31 at 21:47 +0800, Kevin Hao wrote:
> > Hi,
> >=20
> > This patch series tries to kill the PPC_OF.
>=20
> So on the whole this series looks good.
>=20
> Getting it merged is going to be a bit of a pain though. I assume most of=
 them
> depend on patch 1, in which case they really need to go in as one series.

Agreed.

>=20
> So you'll just have to collect acks from all the driver/subsystem maintai=
ners,

Will do.

> and then we can take it all through the powerpc tree.

Thanks Michael.

Kevin

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUzuQyAAoJEJNY7TDerrFx4l8IAJpAKPZIeuBwLdNCsSNo3MgL
i1BNExrmEuwZLr0b1ukl0r0DawXN6T4yZpn8/OhGvlXiasmphtF4QoRESjEpY8kP
QjvTQxjFIN7zJp/ba2cluOENGoz6HQAJrxn5Z8S2Zy0JlKGWGBQZaGRhDwkrYgLx
ManS5nGra0sQcNmCU3WDoZIRXN7881CQ9oXLPyV0DVUpv9um8QxvnpPG/AGZNPSx
1AmlJan1qKd5MduEQG2eI5QmULgePjsdF5PUk4IdgpqgMsetZ8DLIXOVC6PJ3z/i
hHLQERxOj8SjVmpYDvTK7/UHHpIwVh8oO9Rbsx3b2AGSB9KCtlryUGUb3QYIWqY=
=8b/H
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
