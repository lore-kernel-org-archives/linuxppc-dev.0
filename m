Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 63B38DDE3F
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 03:21:43 +1100 (EST)
Date: Wed, 20 Feb 2008 08:14:35 -0800
From: Greg KH <greg@kroah.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch v8 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
Message-ID: <20080220161435.GD2658@kroah.com>
References: <20080220090727.904160000@sunsite.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080220090727.904160000@sunsite.dk>
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	stern@rowland.harvard.edu, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 20, 2008 at 10:07:27AM +0100, Peter Korsgaard wrote:
> The Cypress c67x00 (EZ-Host/EZ-OTG) controllers are multi-role low/fullspeed
> USB controllers. This patch series implements a HCD driver and shows the
> work-in-progress status of a gadget driver.
> 
> I believe patch 1..3 are ready, and I would like to see them queued up for
> mainline.
> 
> Changes since v7:
>  - Moved dummy hcd probe/remove functions for conditional hcd support into
>    udc patch.
>  - Moved usb_disabled() check into c67x00_hcd_probe().
>  - Moved c67x00_get_comm_reg() to udc patch as it is only needed for gadget
>    support.

So this fixes the build errors/warnings I sent you?

Can you run them through scripts/checkpatch.pl to ensure that those
warnings are also fixed?

thanks,

greg k-h
