Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5B1BDDF67
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 05:09:14 +1100 (EST)
Date: Wed, 20 Feb 2008 09:40:32 -0800
From: Greg KH <greg@kroah.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch v8 1/4] USB: add Cypress c67x00 low level interface code
Message-ID: <20080220174032.GA12489@kroah.com>
References: <20080220090727.904160000@sunsite.dk>
	<20080220091400.882581000@sunsite.dk>
	<20080220161343.GC2658@kroah.com>
	<87r6f7d0nb.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r6f7d0nb.fsf@macbook.be.48ers.dk>
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

On Wed, Feb 20, 2008 at 05:59:36PM +0100, Peter Korsgaard wrote:
> >>>>> "Greg" == Greg KH <greg@kroah.com> writes:
> 
> Hi,
> 
>  >> drivers/usb/c67x00/c67x00.h        |  285 ++++++++++++++++++++++++++
> 
>  Greg> Why not drivers/usb/hcd/c67x00/ instead?
> 
> Because the device can do both host and peripheral (E.G. see patch 4
> in the series).
> 
> We could put it under hcd for now and then move it once the gadget
> driver gets finished/merged, but that seems silly to me..

Moving files is trivial to do, if we need to do it in the future, we
can.

thanks,

greg k-h
