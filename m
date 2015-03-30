Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-16.arcor-online.net (mail-in-16.arcor-online.net
 [151.189.21.56])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 230731A060B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 04:44:55 +1100 (AEDT)
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net
 [151.189.8.34]) by mx.arcor.de (Postfix) with ESMTP id 3lG1QB0c3gzFNg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:44:50 +0200 (CEST)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net
 [151.189.21.55])
 by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id 100691106E3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:44:50 +0200 (CEST)
Received: from antares.localdomain (xdsl-89-0-166-33.netcologne.de
 [89.0.166.33]) (Authenticated sender: dralbrecht.dress@arcor.de)
 by mail-in-15.arcor-online.net (Postfix) with ESMTPSA id 3lG1Q974CQzF9wN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 19:44:49 +0200 (CEST)
Date: Mon, 30 Mar 2015 19:44:49 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Kernel hangs after "Loading Device Tree" after update
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <f5eGCMEZMWj8sdIdapjeSK@0rm3q3OQFzZ+uXZxcP8BI>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 protocol="application/pgp-signature"; boundary="=-PV2EhynHt2JpAagdgYLb"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-PV2EhynHt2JpAagdgYLb
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I have a strange problem on a self-developed MPC5200B system (more or less =
like the Freescale "Lite" board).  On that board, I use kernel 3.2.68 with =
my own machine init file, which is almost the same as for Lite (arch/powerp=
c/platforms/52xx/lite5200.c).  Everything works just fine.

When I use 3.18.9 with the same init file modifications and compiled with m=
ore or less the same .config, plus an adjusted DTB (e.g. rename the "fsl,mp=
c5200b-psc-uart" entries to "fsl,mpc5200b-psc"), the boot process from u-bo=
ot simply hangs after:

<snip>
## Booting kernel from Legacy Image at 01000000 ...
    Image Name:   Linux-3.18.9
    Created:      2015-03-30   7:23:52 UTC
    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
    Data Size:    1972101 Bytes =3D  1.9 MB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
## Flattened Device Tree blob at 01200000
    Booting using the fdt blob at 0x1200000
    Uncompressing Kernel Image ... OK
    Loading Device Tree to 007fa000, end 007ff2d9 ... OK
</snip>

Any idea what goes wrong here?  I recall that I used the same approach outl=
ined above to move from 2.6.32 to 3.2, which worked immediately.  Might my =
U-Boot be too old (I use 2009.03)?

Thanks in advance,
Albrecht.=

--=-PV2EhynHt2JpAagdgYLb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iD8DBQBVGYuRn/9unNAn/9ERAjs6AKC8bxRlpIicIWWfSiAb39vYKZst1wCfRBJY
sBVr8D0OcbdHnGQzIMtXDdk=
=IwUb
-----END PGP SIGNATURE-----

--=-PV2EhynHt2JpAagdgYLb--
