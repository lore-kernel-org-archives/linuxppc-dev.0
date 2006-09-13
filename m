Return-Path: <roubert@df.lth.se>
Received: from df.lth.se (mail.df.lth.se [194.47.250.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64BA667B72
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 23:28:23 +1000 (EST)
Received: from igloo.df.lth.se (localhost [127.0.0.1])
	by df.lth.se (8.13.1/8.13.1) with ESMTP id k8DDSHDI024948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 15:28:17 +0200 (CEST)
Received: (from roubert@localhost)
	by igloo.df.lth.se (8.13.1/8.13.1/Submit) id k8DDSH4H024947
	for linuxppc-embedded@ozlabs.org; Wed, 13 Sep 2006 15:28:17 +0200 (CEST)
Date: Wed, 13 Sep 2006 15:28:17 +0200
From: Fredrik Roubert <roubert@df.lth.se>
To: linuxppc-embedded@ozlabs.org
Subject: Re: How to move from /ppc/ to /powerpc/
Message-ID: <20060913132817.GD18263@igloo.df.lth.se>
References: <20060912153316.GC16340@igloo.df.lth.se>
	<20060912105830.3923d537.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
In-Reply-To: <20060912105830.3923d537.kim.phillips@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 12 Sep 17:58 CEST 2006, Kim Phillips wrote:

> The 8349EMDS device tree source is now in linux/arch/powerpc/boot/dts.

Is that the right dts to use for a MPC8349SYS board?

I tried compiling it like this:

$ dtc -f -I dts -O dtb mpc8349emds.dts > devices.dtb
DTC: dts->dtb  on file "mpc8349emds.dts"
Warning: No cpu has "linux,boot-cpu" property
ERROR: Missing /chosen node
Input tree has errors

Is that really correct? Should I invoke dtc in some other way or modify
the dts or use some other dts file?

> Matt's u-boot patches address the issue well for 85xx, they are
> straightforward to adapt to 83xx:
>
> http://sourceforge.net/mailarchive/forum.php?thread_id=3D15518792&forum_i=
d=3D12898
>
> they allow you to tftp the dtb into mem, and "bootm ${loadaddr} -
> ${oftaddr}" to start an ARCH=3Dpowerpc kernel.

OK, I've adapted and applied those patches now. However, when I try to
boot with the dtd I generated above, then the kernel just hangs. For
now, I assume that is because of errors in the dtd and not in u-boot ...

Cheers // Fredrik Roubert

--=20
Visserij 192  |  +32 473 344527 / +46 708 776974
BE-9000 Gent  |  http://www.df.lth.se/~roubert/

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (SunOS)

iQCVAwUBRQgHccRKuLhQMn35AQLFRQP+O0o1lO+bwlijL4rKOWC+PJNnqvf/ef6A
cwpHATujKTdY2pPU2vBfUbDb8NX6xqv2wzD5fRujHzlUsnoH8eUGH0bcfnpsPwOF
rEFdevXW04sWEknUR3qLvCuwZgmykZexvf970ZDBpHXTXMYsQKxAfOr6qb+ZYIHn
sw4wUcEHF5I=
=nx6p
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
