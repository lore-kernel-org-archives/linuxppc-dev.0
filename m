Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D44BB6F8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 04:16:25 +1000 (EST)
Date: Wed, 1 Jun 2011 20:16:03 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wanlong Gao <wanlong.gao@gmail.com>
Subject: Re: [PATCH] Fix build warning of the defconfigs
Message-ID: <20110601181603.GA454@pengutronix.de>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
Cc: linux-mips@linux-mips.org, david.woodhouse@intel.com,
	linux-sh@vger.kernel.org, paulus@samba.org, gxt@mprc.pku.edu.cn,
	sam@ravnborg.org, linux@arm.linux.org.uk,
	manuel.lauss@googlemail.com, rientjes@google.com, mingo@elte.hu,
	vapier@gentoo.org, arnd@arndb.de, u.kleine-koenig@pengutronix.de,
	anton@samba.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	lethal@linux-sh.org, uclinux-dist-devel@blackfin.uclinux.org,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	hans-christian.egtvedt@atmel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 02, 2011 at 12:29:23AM +0800, Wanlong Gao wrote:
> RTC_CLASS is changed to bool.
> So value 'm' is invalid.
>=20
> Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
> ---
>  arch/arm/configs/davinci_all_defconfig     |    2 +-
>  arch/arm/configs/mxs_defconfig             |    2 +-
>  arch/arm/configs/netx_defconfig            |    2 +-
>  arch/arm/configs/viper_defconfig           |    2 +-
>  arch/arm/configs/xcep_defconfig            |    2 +-
>  arch/arm/configs/zeus_defconfig            |    2 +-
>  arch/avr32/configs/atngw100_mrmt_defconfig |    2 +-
>  arch/blackfin/configs/CM-BF548_defconfig   |    2 +-
>  arch/mips/configs/mtx1_defconfig           |    2 +-
>  arch/powerpc/configs/52xx/pcm030_defconfig |    2 +-
>  arch/powerpc/configs/ps3_defconfig         |    2 +-
>  arch/sh/configs/titan_defconfig            |    2 +-
>  arch/unicore32/configs/debug_defconfig     |    2 +-
>  13 files changed, 13 insertions(+), 13 deletions(-)

The mxs-part has already been sent by Shawn Guo (shouldn't harm).

Thanks for doing tree-wide:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3mgeMACgkQD27XaX1/VRtALACgwWNkKN3MYtyEJ3UIFNG7P/jx
oygAoJkolxXXrviVsTRfROYzf65y/N+3
=5o5C
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
