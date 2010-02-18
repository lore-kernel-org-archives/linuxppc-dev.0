Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E29EB7CE7
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 14:19:58 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add NOR,
	LEDs and PIB support for MPC8568E-MDS boards
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100205210626.GA9882@oksana.dev.rtsoft.ru>
Date: Wed, 17 Feb 2010 21:19:51 -0600
Message-Id: <8F9F0D78-FF66-4F98-B5FC-E7667612ECB7@kernel.crashing.org>
References: <20100205210626.GA9882@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 5, 2010, at 3:06 PM, Anton Vorontsov wrote:

> This patch adds NOR Flash, LEDs and PIB support for MPC8568E-MDS
> boards. Plus, move bcsr node into localbus node, and add bcsr5
> gpio-controller node.
>=20
> Some platform code modifications were also needed.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8568mds.dts      |   65 =
+++++++++++++++++++++++++++-
> arch/powerpc/platforms/85xx/mpc85xx_mds.c |    3 +
> 2 files changed, 65 insertions(+), 3 deletions(-)

applied to next

- k=
