Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0FFDF2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 16:56:34 +1000 (EST)
Date: Tue, 11 Sep 2012 08:56:04 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 13/25] macintosh/mediabay: add a const qualifier
Message-ID: <20120911065604.GE28643@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-14-git-send-email-u.kleine-koenig@pengutronix.de>
 <1346812817.2257.23.camel@pasglop>
 <20120905080249.GI28643@pengutronix.de>
 <1346837023.2257.57.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1346837023.2257.57.camel@pasglop>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>,
 kernel@pengutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2012 at 07:23:43PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2012-09-05 at 10:02 +0200, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Wed, Sep 05, 2012 at 12:40:17PM +1000, Benjamin Herrenschmidt wrote:
> > > On Mon, 2012-07-23 at 11:13 +0200, Uwe Kleine-König wrote:
> > > > This prepares *of_device_id.data becoming const. Without this change
> > > > the following warning would occur:
> > > > 
> > > > 	drivers/macintosh/mediabay.c: In function 'media_bay_attach':
> > > > 	drivers/macintosh/mediabay.c:589:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]
> > > > 
> > > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > 
> > > Ack all of these assuming you test built (I didn't).
> > "all" means the two mediabay patches? And yes, they are all built
> > tested.
> 
> Yeah, anything powerpc you had in your series, but the two mediabay ones
> are what I spotted when digging through stuff today :-)
I added that to

 serial/mpc52xx_uart: add a const qualifier
 gpio/mpc8xxx: add a const qualifier
 i2c/mpc: add a const qualifier
 macintosh/mediabay: add a const qualifier
 powerpc/83xx: add a const qualifier
 powerpc/fsl_msi: add a const qualifier
 powerpc/celleb_pci: add a const qualifier
 watchdog/mpc8xxx: add a const qualifier
 powerpc/fsl_msi: drop unneeded cast to non-const pointer
 i2c/mpc: make data used as *of_device_id.data const
 macintosh/mediabay: make data used as *of_device_id.data const
 can: mpc5xxx_can: make data used as *of_device_id.data const

in the hope I didn't interpret "anything powerpc" too wide. Please tell
me if I did.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
