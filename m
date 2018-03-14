Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401Krm2M4DzDqw5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 16:23:52 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 401Krm00hhz9sTx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 16:23:51 +1100 (AEDT)
Date: Wed, 14 Mar 2018 16:23:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: more warnings
Message-ID: <20180314162325.1b2dea8d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WvX7v4PiwRbxYuLWsLw=RxK"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/WvX7v4PiwRbxYuLWsLw=RxK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

I also get these from a powerpc allyesconfig build of linux-next:

WARNING: vmlinux.o(.text+0x7c81c): Section mismatch in reference from the f=
unction .stop_machine_change_mapping() to the function .meminit.text:.creat=
e_physical_mapping()
The function .stop_machine_change_mapping() references
the function __meminit .create_physical_mapping().
This is often because .stop_machine_change_mapping lacks a __meminit=20
annotation or the annotation of .create_physical_mapping is wrong.

WARNING: vmlinux.o(.text+0x7c828): Section mismatch in reference from the f=
unction .stop_machine_change_mapping() to the function .meminit.text:.creat=
e_physical_mapping()
The function .stop_machine_change_mapping() references
the function __meminit .create_physical_mapping().
This is often because .stop_machine_change_mapping lacks a __meminit=20
annotation or the annotation of .create_physical_mapping is wrong.

--=20
Cheers,
Stephen Rothwell

--Sig_/WvX7v4PiwRbxYuLWsLw=RxK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqosc0ACgkQAVBC80lX
0GxY1wf+IhTBtrawlqyLExWD55WL005yjCJ1UVBIOWtGLZtsrjMWxglaJbb4IgKK
giHXyVmXduhEXiQ7CyQVZ+t/urV7OsnJG3QF+pJqTdFgYY8N0d3ZfgTagdwe/mmB
CLHdyAnFDLgNZDx6qyJOd876yAGFAMfDAokHpqox5CZh9oS2m1OAYZ/+lv/aMwgH
XgEryvz8eDge8VceGYLhlSeHMCb3HbVEyuYsjIfrDYj9taJ5lfSwKD5JU/y3BhR5
TcyymMpzq8arf9dZmcWGNMsEWIelI9Z6FsZ5zr5K4ODySpyDbTcVDR4ojfSuAYcb
+zchlS5hwTHsL0SJIMOisEas952q6Q==
=51DT
-----END PGP SIGNATURE-----

--Sig_/WvX7v4PiwRbxYuLWsLw=RxK--
