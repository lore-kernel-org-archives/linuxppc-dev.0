Return-Path: <madalin.bucur@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0085.outbound.protection.outlook.com [104.47.2.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSqZX4xxDzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:01:39 +1100 (AEDT)
From: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
To: David Miller <davem@davemloft.net>, Or Gerlitz <gerlitz.or@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Camelia
 Alexandra Groza" <camelia.groza@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 0/9] QorIQ DPAA 1 updates 
Date: Wed, 22 Feb 2017 08:01:32 +0000
Message-ID: <HE1PR04MB112941EA2DFEA9EE4FE50772EC500@HE1PR04MB1129.eurprd04.prod.outlook.com>
References: <1487677974-13678-1-git-send-email-madalin.bucur@nxp.com>
 <20170221.131933.400031791242843075.davem@davemloft.net>
In-Reply-To: <20170221.131933.400031791242843075.davem@davemloft.net>
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
> Sent: Tuesday, February 21, 2017 8:20 PM
>=20
> From: Madalin Bucur <madalin.bucur@nxp.com>
> Date: Tue, 21 Feb 2017 13:52:45 +0200
>=20
> > This patch set introduces a series of fixes and features to the DPAA 1
> > drivers. Besides activating hardware Rx checksum offloading, four
> traffic
> > classes are added for Tx traffic prioritisation.
>=20
> The net-next tree is closed, please resubmit this after the merge window
> when
> the net-next tree opens back up.
>=20
> Thanks.

Sorry, I'll resend.

Meanwhile I should start baking some cakes...
