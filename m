Return-Path: <madalin.bucur@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0110.outbound.protection.outlook.com [207.46.100.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CB181A039F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 21:00:49 +1000 (AEST)
From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
To: David Miller <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott Wood
 <scottwood@freescale.com>, Liberman Igal <Igal.Liberman@freescale.com>,
 "ppc@mindchasers.com" <ppc@mindchasers.com>, "joe@perches.com"
 <joe@perches.com>, "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
 "joakim.tjernlund@transmode.se" <joakim.tjernlund@transmode.se>
Subject: RE: [v2 8/9] dpaa_eth: add debugfs entries
Date: Tue, 11 Aug 2015 11:00:39 +0000
Message-ID: <BL2PR03MB545A863C210E5BFC9DFC128E67F0@BL2PR03MB545.namprd03.prod.outlook.com>
References: <1438789289-16304-1-git-send-email-madalin.bucur@freescale.com>
 <1438789289-16304-9-git-send-email-madalin.bucur@freescale.com>
 <20150807.153716.1393797980617992919.davem@davemloft.net>
In-Reply-To: <20150807.153716.1393797980617992919.davem@davemloft.net>
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
>=20
> From: Madalin Bucur <madalin.bucur@freescale.com>
> Date: Wed, 5 Aug 2015 18:41:28 +0300
>=20
> > Export per CPU counters through debugfs.
> >
> > Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
>=20
> This is absolutely inappropriate.
>=20
> You can export these just fine via ethtool statistics.  There is zero rea=
son
> to add ugly debugfs crap for something like this.

If you have such a strong adversity about the debugfs, then I'll export the=
se
debug counters through ethtool statistics in the next version.

Madalin
