Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1E258DDF39
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 11:52:00 +1000 (EST)
Date: Thu, 9 Apr 2009 11:51:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: John Linn <john.linn@xilinx.com>
Subject: Re: [PATCH] Xilinx : Framebuffer Driver: Add PLB support (non-DCR)
Message-Id: <20090409115147.5059493f.sfr@canb.auug.org.au>
In-Reply-To: <20090408211521.D0EF411B8054@mail214-sin.bigfish.com>
References: <20090408211521.D0EF411B8054@mail214-sin.bigfish.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__9_Apr_2009_11_51_47_+1000_Ava8=csgefhKmact"
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Suneel <suneelg@xilinx.com>, linuxppc-dev@ozlabs.org,
	Suneel <"[mailto:suneel.garapati@xilinx.com]"@xilinx.com>,
	akonovalov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__9_Apr_2009_11_51_47_+1000_Ava8=csgefhKmact
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John,

On Wed, 8 Apr 2009 15:11:25 -0600 John Linn <john.linn@xilinx.com> wrote:
>
>   * 2002-2007 (c) MontaVista Software, Inc.
>   * 2007 (c) Secret Lab Technologies, Ltd.
> + * 2009 (c) Xilinx Inc.
>   *
> - * This file is licensed under the terms of the GNU General Public Licen=
se
> - * version 2.  This program is licensed "as is" without any warranty of =
any
> - * kind, whether express or implied.
> + * This program is free software; you can redistribute it
> + * and/or modify it under the terms of the GNU General Public
> + * License as published by the Free Software Foundation;
> + * either version 2 of the License, or (at your option) any
> + * later version.
> + *
> + * You should have received a copy of the GNU General Public
> + * License along with this program; if not, write to the Free
> + * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
> + * 02139, USA.

This changes the license for this file (from "GPLv2" to "GPLv2 or
later").  Have you asked the other copyright owners about that?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__9_Apr_2009_11_51_47_+1000_Ava8=csgefhKmact
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkndVLMACgkQjjKRsyhoI8xUJQCgriUo58In7VKOiLweWatZr6HD
CqgAniUR7qh6EcKQp+4kR57V6vVMFOgK
=mB6A
-----END PGP SIGNATURE-----

--Signature=_Thu__9_Apr_2009_11_51_47_+1000_Ava8=csgefhKmact--
