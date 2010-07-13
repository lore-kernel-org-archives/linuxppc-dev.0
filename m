Return-Path: <david-b@pacbell.net>
Received: from n57b.bullet.mail.sp1.yahoo.com (n57b.bullet.mail.sp1.yahoo.com
	[98.136.45.30]) by ozlabs.org (Postfix) with SMTP id 721FAB6F11
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 08:50:28 +1000 (EST)
Message-ID: <60127.22840.qm@web180316.mail.gq1.yahoo.com>
Date: Tue, 13 Jul 2010 15:50:26 -0700 (PDT)
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/9 v1.01] Add Synopsys DesignWare HS USB OTG Controller
	driver.
To: fushen chen <fchen@apm.com>
In-Reply-To: <1279059214.29212.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, chuck@theptrgroup.com, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, gregkh@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > and make the OTG functionality
> > key on the generic OTG symbol, not a DW-specific one.
> > 
> > 
> Use "drivers/usb/otg/otg.c and include/linux/usb/otg.h"?

Maybe; CONFIG_USB_OTG specifically, though
(or whatever that generic symbol is) ...
