Return-Path: <thierry.reding@gmail.com>
Received: from mail-ee0-f46.google.com (mail-ee0-f46.google.com [74.125.83.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AEB1E140077
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 20:54:16 +1000 (EST)
Received: by mail-ee0-f46.google.com with SMTP id t10so511944eei.19
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 03:54:11 -0700 (PDT)
Date: Thu, 17 Apr 2014 12:53:03 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 0/5] defconfigs: add MTD_SPI_NOR (dependency for M25P80)
Message-ID: <20140417105302.GA32603@ulmo>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
In-Reply-To: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
Cc: Marek Vasut <marex@denx.de>, linux-mips@linux-mips.org,
 Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>,
 linux-sh@vger.kernel.org, Steven Miao <realmz6@gmail.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, adi-buildroot-devel@lists.sourceforge.net,
 linux-tegra@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>,
 Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Shawn Guo <shawn.guo@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2014 at 12:21:44AM -0700, Brian Norris wrote:
> Hi all,
>=20
> We are introducing a new SPI-NOR library/framework for MTD, to support va=
rious
> types of SPI-NOR flash controllers which require (or benefit from) intima=
te
> knowledge of the flash interface, rather than just the relatively dumb SPI
> interface. This library borrows much of the m25p80 driver for its abstrac=
tion
> and moves this code into a spi-nor module.

If this is a common library, then the more common approach to solve this
would be to have each driver that uses it to select MTD_SPI_NOR rather
than depend on it. That way you can drop this whole series to update the
default configurations.

Thierry

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTT7KNAAoJEN0jrNd/PrOhzhQP/3ocjlUpPSUcBT7myTaYn8dC
zbZ0Zp5MO34d42OXHqfYC0q6LiCYp4I6xQDn8usqKBxpHd1dBAirD0z7Ofp3nAo5
JwH+vr8zDZNTZcQd5W/LRI90fa/9qVNytVFNSEbmeNUop74+yhnQb//rq3YCskEZ
v8rHJpH7uaJUPeVTsvrbmtW/9ZW5+ofFWj2JffogOyC4NY/oOldXl4gsOcP+PuF7
gFdIn+D+hyEa2ZLjdeYD9lIvmLHczXhda0KPDZO31gDQyHvgMt+goUUgtWlqfHv+
8cuKJjhHeMhMYtdZByrYRRVuhlafZlLJ2PqmunFCgsd/1P9Ww+k+nZJASw8jFqbd
nGxDcgXG/4vfiFj0HMZoR/cWh845wYrWXdzaZdmY0bjiHEsz1ip+OVNq5ACq+d+L
9posY8HH1btDrrcJEsce4DTHTJsAYdeX0oik8DK+gHi5no7sd8Twd2ZjJaZxtwXk
pH+RZqVa3Wrj68vCXuyTZSFZb/QC/ZttUgW5YhfVcQJcsOC02+LRKOIbu0Em8hMq
3sdsgTImKHFAEdWm4oNOHlOPN4nk/tMRo3nrCUV4Pb+yaCelIBlKo/9JLK0JfDQJ
/qPtjG0OAPJYmHmwPcSB57kA/MZlF6RnNI1V8CHWOCQm94NwGirKBropQ/9yLxs7
lrnTat974tXvX/gLJ7Do
=Xz6I
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
