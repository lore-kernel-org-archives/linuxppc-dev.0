Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C1EEDDECA
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 04:05:43 +1100 (EST)
Date: Wed, 20 Feb 2008 09:03:00 -0800
From: Greg KH <greg@kroah.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch v7 3/4] USB: add Cypress c67x00 OTG controller HCD driver
Message-ID: <20080220170300.GB3453@kroah.com>
References: <20080219150916.263032000@sunsite.dk>
	<20080219151149.684610000@sunsite.dk>
	<20080219235554.GA13304@kroah.com>
	<87bq6cf1cb.fsf@macbook.be.48ers.dk>
	<20080220161608.GE2658@kroah.com>
	<874pc3efbx.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <874pc3efbx.fsf@macbook.be.48ers.dk>
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

On Wed, Feb 20, 2008 at 05:57:06PM +0100, Peter Korsgaard wrote:
> >>>>> "Greg" == Greg KH <greg@kroah.com> writes:
> 
> Hi,
>  Greg> I don't know, I selected the config option, and yet, it built
>  Greg> as if it wasn't set.
> 
> Sorry, I cannot reproduce that here. Could you try again?

I will on the next round :)

>  Greg> Can you move the files under the hcd/ subdir

Oops, I ment "host/" not, "hcd/".

> Sorry, I don't think that's a good idea as the hardware can do
> peripheral as well, and as you can see in patch 4, a gadget driver is
> on it's way.

Ok, that's fine, why can't the gadget stuff go into the gadget/
directory then also?  As this device is a host controller, it makes
sense to me to keep it in the host-controller subdirectory.

>  Greg> run it through checkpatch.pl and fix up the __FUNCTION__
>  Greg> warnings, and then I'll be willing to test it again :)
> 
> Ahh, that seems to be a pretty new warning in checkpatch - I atleast
> haven't seen it before. The other things it complains about seems to
> be rubbish though (except for the single indented label).

What other things do you think are rubbish?

And yes, it's a new warning with the advent of 2.6.25-rc1, but that's no
reason to ignore it :)

thanks,

greg k-h
