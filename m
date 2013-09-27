Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 882EF2C019C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 01:28:08 +1000 (EST)
Subject: Re: [PATCH v3] powerpc/83xx: gianfar_ptp: select 1588 clock source
 through dts file
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1380289227-12029-1-git-send-email-aida.mynzhasova@skitlab.ru>
Date: Fri, 27 Sep 2013 10:28:01 -0500
Message-Id: <21CA07A6-8B3D-49E9-8D9A-F63607FAC8EF@kernel.crashing.org>
References: <1380289227-12029-1-git-send-email-aida.mynzhasova@skitlab.ru>
To: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
Cc: devicetree@vger.kernel.org, richardcochran@gmail.com,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 27, 2013, at 8:40 AM, Aida Mynzhasova wrote:

> Currently IEEE 1588 timer reference clock source is determined through
> hard-coded value in gianfar_ptp driver. This patch allows to select =
ptp
> clock source by means of device tree file node.
>=20
> For instance:
>=20
> 	fsl,cksel =3D <0>;
>=20
> for using external (TSEC_TMR_CLK input) high precision timer
> reference clock.
>=20
> Other acceptable values:
>=20
> 	<1> : eTSEC system clock
> 	<2> : eTSEC1 transmit clock
> 	<3> : RTC clock input
>=20
> When this attribute isn't used, eTSEC system clock will serve as
> IEEE 1588 timer reference clock.
>=20
> Signed-off-by: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
> ---
> Documentation/devicetree/bindings/net/fsl-tsec-phy.txt | 18 =
+++++++++++++++++-
> drivers/net/ethernet/freescale/gianfar_ptp.c           |  4 +++-
> 2 files changed, 20 insertions(+), 2 deletions(-)

Acked-by: Kumar Gala <galak@codeaurora.org>

- k=
