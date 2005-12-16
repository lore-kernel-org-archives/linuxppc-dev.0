Return-Path: <vonbrand@laptop11.inf.utfsm.cl>
Received: from inti.inf.utfsm.cl (inti.inf.utfsm.cl [200.1.21.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 90A03688BC
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Dec 2005 04:59:02 +1100 (EST)
Message-Id: <200512161729.jBGHTlGR017130@laptop11.inf.utfsm.cl>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: Message from Olof Johansson <olof@lixom.net> of "Thu,
	15 Dec 2005 11:50:17 -0800." <20051215195017.GA7195@pb15.lixom.net>
Date: Fri, 16 Dec 2005 14:29:47 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: dtor_core@ameritech.net, kernel-stuff@comcast.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6 1/2] usb/input: Add relayfs support to appletouch
	driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson <olof@lixom.net> wrote:

Just saw this.

> On Thu, Dec 15, 2005 at 12:31:08AM +0100, Michael Hanselmann wrote:

> > diff -rup linux-2.6.15-rc5.orig/drivers/usb/input/appletouch.c b/drivers/usb/input/appletouch.c
> > --- linux-2.6.15-rc5.orig/drivers/usb/input/appletouch.c	2005-12-13 22:44:24.000000000 +0100
> > +++ b/drivers/usb/input/appletouch.c	2005-12-15 00:25:09.000000000 +0100

[...]

> > +#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
> > +#include <linux/relayfs_fs.h>
> > +#endif

Why can't this be included regardless? If it does something that only makes
sense if relayfs is in use, better have that decision inside the header
file (least somebody just includes it and...).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
