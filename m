Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8172FDDEC0
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Apr 2007 04:08:21 +1000 (EST)
Date: Fri, 20 Apr 2007 20:08:18 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [patch] ipmi: check, if default ports are accessible on PPC
Message-ID: <20070420180818.GA4568@aepfle.de>
References: <1172223703.4695.59.camel@concordia.ozlabs.ibm.com>
	<20070223135859.62e19ca8@localhost>
	<1172295412.16060.8.camel@concordia.ozlabs.ibm.com>
	<20070226160917.2c801ec7@localhost>
	<20070420174821.GA4176@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070420174821.GA4176@aepfle.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 20, Olaf Hering wrote:

> On Mon, Feb 26, Christian Krafft wrote:
> 
> > ipmi_si_intf tries to access default ports, if no device could
> > be found elsewhere. On PPC we have a function to check,
> > if these legacy IO ports are accessible. This patch adds
> > a check for these ports on PPC.
> > This patch fixes a breakage of IPMI module
> > on PPC machines without a BMC.
> 
> This patch is a no-op even for IPMI capable systems.

I missed the 'return 0;' in pSeries_check_legacy_ioport().
