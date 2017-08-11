Return-Path: <madalin.bucur@nxp.com>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10058.outbound.protection.outlook.com [40.107.1.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTJQF0VNNzDr2n
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 18:41:40 +1000 (AEST)
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: Florinel Iordache <florinel.iordache@nxp.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH net-next] fsl/fman: implement several errata workarounds
Date: Fri, 11 Aug 2017 08:41:33 +0000
Message-ID: <AM5PR0402MB269188FDE87431467E6C4076EC890@AM5PR0402MB2691.eurprd04.prod.outlook.com>
References: <1502372824-30180-1-git-send-email-florinel.iordache@nxp.com>
In-Reply-To: <1502372824-30180-1-git-send-email-florinel.iordache@nxp.com>
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
> From: Florinel Iordache [mailto:florinel.iordache@nxp.com]
> Subject: [PATCH net-next] fsl/fman: implement several errata workarounds
>=20
> Implemented workarounds for the following dTSEC Erratum:
> A002, A004, A0012, A0014, A004839 on several operations
> that involve MAC CFG register changes: adjust link,
> rx pause frames, modify MAC address.
>=20
> Signed-off-by: Florinel Iordache <florinel.iordache@nxp.com>

Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
