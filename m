Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 22C682C0088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 06:20:11 +1000 (EST)
Subject: Re: [PATCH] powerpc/p5040: fix dtb build warning of p5040ds.dtb
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1347446163-15470-1-git-send-email-Shaohui.Xie@freescale.com>
Date: Wed, 12 Sep 2012 15:20:05 -0500
Message-Id: <8A7EAC17-D715-47A0-9DE7-AA5E8D27C125@kernel.crashing.org>
References: <1347446163-15470-1-git-send-email-Shaohui.Xie@freescale.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 12, 2012, at 5:36 AM, Shaohui Xie wrote:

> Device node adt7461 was wrongly added in p5040ds.dts, it should be =
added
> into i2c instead of localbus, when build p5040ds.dtb, a warning will =
dump:
>=20
> Warning (reg_format): "reg" property in
> /localbus@ffe124000/nand@2,0/adt7461@4c has invalid length (4 bytes)
> (#address-cells =3D=3D 1, #size-cells =3D=3D 1)
>=20
> This was introduced by:
>=20
> commit ea6b1ba692bcb5f6e39f409a78cf8b04fdf23baa
> Author: Jia Hongtao <B38951@freescale.com>
> Date:   Tue Aug 28 10:00:55 2012 +0800
>=20
>    powerpc: add adt7461 thermal monitor support to applicable boards
>=20
>    Add thermal monitor support to following boards:
>    P1022DS, MPC8536DS, P2041RDB, P3041DS, P4080DS, P5020DS, P5040DS
>=20
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> based on next branch of =
http://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
>=20
> arch/powerpc/boot/dts/p5040ds.dts |    8 ++++----
> 1 files changed, 4 insertions(+), 4 deletions(-)

applied to next

- k=
