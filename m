Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7AB2ADDEE3
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 03:21:41 +1100 (EST)
Date: Wed, 20 Feb 2008 08:13:43 -0800
From: Greg KH <greg@kroah.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch v8 1/4] USB: add Cypress c67x00 low level interface code
Message-ID: <20080220161343.GC2658@kroah.com>
References: <20080220090727.904160000@sunsite.dk>
	<20080220091400.882581000@sunsite.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080220091400.882581000@sunsite.dk>
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

On Wed, Feb 20, 2008 at 10:07:28AM +0100, Peter Korsgaard wrote:
> This patch adds the low level support code for the Cypress c67x00 family of
> OTG controllers.  The low level code is responsible for register access and
> implements the software protocol for communicating with the 16bit
> microcontroller inside the c67x00 device.
> 
> Communication is done over the HPI interface (16bit SRAM-like parallel bus).
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> Acked-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/usb/c67x00/c67x00-ll-hpi.c |  405 +++++++++++++++++++++++++++++++++++++
>  drivers/usb/c67x00/c67x00.h        |  285 ++++++++++++++++++++++++++

Why not drivers/usb/hcd/c67x00/ instead?

thanks,

greg k-h
