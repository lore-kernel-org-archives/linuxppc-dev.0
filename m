Return-Path: <rjw@sisk.pl>
Received: from hydra.sisk.pl (hydra.sisk.pl [212.160.235.94])
 by ozlabs.org (Postfix) with ESMTP id CD91A2C00E8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 05:56:51 +1000 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/3] include: Convert ethernet mac address declarations to
 use ETH_ALEN
Date: Mon, 29 Jul 2013 22:06:58 +0200
Message-ID: <4497056.HfyZknBA2p@vostro.rjw.lan>
In-Reply-To: <1375126464.2075.46.camel@joe-AO722>
References: <cover.1375075325.git.joe@perches.com>
 <2929374.frUlkyTFNL@vostro.rjw.lan> <1375126464.2075.46.camel@joe-AO722>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Steve Glendinning <steve.glendinning@shawell.net>,
 Samuel Ortiz <samuel@sortiz.org>, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 Vitaly Bordug <vbordug@ru.mvista.com>, Len Brown <lenb@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, July 29, 2013 12:34:24 PM Joe Perches wrote:
> On Mon, 2013-07-29 at 13:59 +0200, Rafael J. Wysocki wrote:
> > On Sunday, July 28, 2013 10:29:04 PM Joe Perches wrote:
> > > It's convenient to have ethernet mac addresses use
> > > ETH_ALEN to be able to grep for them a bit easier and
> > > also to ensure that the addresses are __aligned(2).
> []
> > > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> []
> > > @@ -44,6 +44,8 @@
> []
> > > +#include <linux/if_ether.h>
> > > +
> []
> > > @@ -605,7 +607,7 @@ struct acpi_ibft_nic {
> []
> > > -	u8 mac_address[6];
> > > +	u8 mac_address[ETH_ALEN];
> 
> > Please don't touch this file.
> > 
> > It comes from a code base outside of the kernel and should be kept in sync with
> > the upstream.
> 
> Which files in include/acpi have this characteristic?

Generally, all whose names start with "ac" except for acpi_bus.h,
acpi_drivers.h and acpi_numa.h.

> Perhaps an include/acpi/README is appropriate.

Yes, we can add one.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
