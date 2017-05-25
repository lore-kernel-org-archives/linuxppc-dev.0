Return-Path: <madalin.bucur@nxp.com>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10051.outbound.protection.outlook.com [40.107.1.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYTnV0Fm9zDqjr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 22:57:32 +1000 (AEST)
From: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
To: David Miller <davem@davemloft.net>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>, "oss@buserror.net"
 <oss@buserror.net>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus@samba.org" <paulus@samba.org>, "mpe@ellerman.id.au"
 <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: net: move FMan binding
Date: Thu, 25 May 2017 12:57:26 +0000
Message-ID: <AM5PR0402MB2691006D3DD1CEB8744EF8F4ECFF0@AM5PR0402MB2691.eurprd04.prod.outlook.com>
References: <1494855398-26215-1-git-send-email-madalin.bucur@nxp.com>
 <20170515.103048.248884533404807350.davem@davemloft.net>
In-Reply-To: <20170515.103048.248884533404807350.davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Monday, May 15, 2017 5:31 PM
> Subject: Re: [PATCH] dt-bindings: net: move FMan binding
>=20
> From: Madalin Bucur <madalin.bucur@nxp.com>
> Date: Mon, 15 May 2017 16:36:38 +0300
>=20
> > Besides the PPC SoCs, the QorIQ DPAA FMan is also present on ARM SoCs,
> > moving the device tree binding document into the bindings/net folder.
> >
> > Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
>=20
> What tree is this targetted at for merging?

I hope Rob Herring will take this into his tree, it's a device tree binding
change.=20

Thanks,
Madalin
