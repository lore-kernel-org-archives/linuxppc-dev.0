Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qMqT03qC8zDq6V
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Mar 2016 03:38:28 +1100 (AEDT)
Date: Sat, 12 Mar 2016 16:52:54 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 scott.wood@nxp.com, Russell King <linux@arm.linux.org.uk>,
 Jochen Friedrich <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>, ulf.hansson@linaro.org,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Zhao Qiang <qiang.zhao@freescale.com>, Kumar Gala <galak@codeaurora.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, leoyang.li@nxp.com,
 xiaobo.xie@nxp.com
Subject: Re: [v6, 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
Message-ID: <20160312155254.GJ1661@katana>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-5-git-send-email-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="AXxEqdD4tcVTjWte"
In-Reply-To: <1457518131-11339-5-git-send-email-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--AXxEqdD4tcVTjWte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 06:08:50PM +0800, Yangbo Lu wrote:
> Move mpc85xx.h to include/linux/fsl and rename it to svr.h as
> a common header file. It has been used for mpc85xx and it will
> be used for ARM-based SoC as well.
>=20
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

=46rom a glimpse, looks like proper refactoring. Thanks!

For the I2C part:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--AXxEqdD4tcVTjWte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW5DtWAAoJEBQN5MwUoCm2N8wP/A+9PzzjAh69NdEWEYwAmYNQ
O+VKHOPKJS8+cx+LgBtRcfEPQFa1Yjhbc67iLD3iCZmflpMTPkTxJaCXtCpX7spT
czvjtG2dnaW57mkuuu1M1n6g2Pk8AqFScH7fgJ8/T0PsLo9n/+uZQOqsahYLYBA6
eHz4NL7vhXW0X8K1v2VnPI8PzEc3jxz72ZsGo4JdKrrSNjs20rHpjXm4/c6L/IxY
ww6eMTeOY+aXfNEHyWX67bwVX0j+9puiQ0RWdnQEo/3n9XMdketiEwpClO/fzAmb
YGg7ChK0pVFqt54gk5Kj6eA9hCDiNsOK9LSeVNX5qsqmIcr1enxD9WNOV0zjPTfP
pF1mR52ygaACR5KU8LQSZVyZBjar9lMq60Fw6KCRunwCMjpnkUxLWHFH8TrH5NAG
bcVaO158C7FW7Ixk+d0uaZpqIMg2co62nUXXLxUvMSVbDNxuzvo6gCosZt5z3oKr
9oEVkaqTk7QhX8szHB+BYKjoBVK+oi4UsgvQ3LnTCCt5r9vGGwGGnNEluOKHzB5o
hEdKZ7/Ubd8yuCAkVzZHW4s0i248RxUY+a45u2adw6Zp5L7Dvw4JWPo0YD6qT4UN
AMUJnu+dAf/WgL1wn1Nb1AKsbnN3dz8paP0kdGXTtfO51B1FeFrs7x9io1wvUFyn
4zIuW6V0i4oZlV+/XynJ
=VEQJ
-----END PGP SIGNATURE-----

--AXxEqdD4tcVTjWte--
