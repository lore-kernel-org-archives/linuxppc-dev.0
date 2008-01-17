Return-Path: <greg@kroah.com>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7411DDE9C
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 08:56:23 +1100 (EST)
Date: Thu, 17 Jan 2008 14:00:07 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-rc8-mm1 powerpc build errors
Message-ID: <20080117220007.GB12952@kroah.com>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<20080117190639.GA9499@lixom.net>
	<20080117113523.d802f991.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080117113523.d802f991.akpm@linux-foundation.org>
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com,
	Olof Johansson <olof@lixom.net>, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 17, 2008 at 11:35:23AM -0800, Andrew Morton wrote:
> On Thu, 17 Jan 2008 13:06:39 -0600 Olof Johansson <olof@lixom.net> wrote:
> > powerpc_allyesconfig:
> > 
> > drivers/net/ehea/ehea_main.c: In function 'ehea_driver_sysfs_add':
> > drivers/net/ehea/ehea_main.c:2812: error: 'struct device_driver' has no member named 'kobj'
> > drivers/net/ehea/ehea_main.c:2815: error: 'struct device_driver' has no member named 'kobj'
> > drivers/net/ehea/ehea_main.c:2818: error: 'struct device_driver' has no member named 'kobj'
> > drivers/net/ehea/ehea_main.c: In function 'ehea_driver_sysfs_remove':
> > drivers/net/ehea/ehea_main.c:2830: error: 'struct device_driver' has no member named 'kobj'
> 
> Looks like the driver tree wrecking ball failed to visit that driver.

Crap, I thought I fixed that one, but the patch never made it out...
I'll fix that tomorrow, sorry about that.

greg k-h
