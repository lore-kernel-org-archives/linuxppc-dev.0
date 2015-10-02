Return-Path: <madalin.bucur@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0144.outbound.protection.outlook.com [207.46.100.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5CF201A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 19:16:48 +1000 (AEST)
From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, Liberman Igal
 <Igal.Liberman@freescale.com>, Roy Pledge <roy.pledge@freescale.com>,
 "ppc@mindchasers.com" <ppc@mindchasers.com>, "joe@perches.com"
 <joe@perches.com>, "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
 "joakim.tjernlund@transmode.se" <joakim.tjernlund@transmode.se>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "stsp@list.ru" <stsp@list.ru>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [v3 1/8] devres: add devm_alloc_percpu()
Date: Fri, 2 Oct 2015 09:16:42 +0000
Message-ID: <BL2PR03MB54503928C025D7EAF9F8814E64B0@BL2PR03MB545.namprd03.prod.outlook.com>
References: <1443106819-5549-1-git-send-email-madalin.bucur@freescale.com>
 <1443106819-5549-2-git-send-email-madalin.bucur@freescale.com>
 <20151002010041.GA4245@home.buserror.net>
In-Reply-To: <20151002010041.GA4245@home.buserror.net>
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
> From: Wood Scott-B07421
> Sent: Friday, October 02, 2015 4:01 AM
>=20
> On Thu, Sep 24, 2015 at 06:00:12PM +0300, Madalin Bucur wrote:
> > Introduce managed counterparts for alloc_percpu() and free_percpu().
> > Add devm_alloc_percpu() and devm_free_percpu() into the managed
> > interfaces list.
> >
> > Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
> > Tested-by: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
> > ---
> >  Documentation/driver-model/devres.txt |  4 +++
> >  drivers/base/devres.c                 | 64
> +++++++++++++++++++++++++++++++++++
> >  include/linux/device.h                | 19 +++++++++++
> >  3 files changed, 87 insertions(+)
>=20
> Greg KH needs to be CCed on any drivers/base changes.
>=20
> -Scott

Thank you, I will add him.

Madalin
