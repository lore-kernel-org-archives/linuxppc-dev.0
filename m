Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id D8CB8DDDFC
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 18:53:40 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so1046576uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 23:53:38 -0800 (PST)
To: David Brownell <david-b@pacbell.net>
Subject: Re: [patch v8 3/4] USB: add Cypress c67x00 OTG controller HCD driver
References: <20080220090727.904160000@sunsite.dk>
	<20080220091401.612406000@sunsite.dk>
	<200802201906.35830.david-b@pacbell.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Thu, 21 Feb 2008 08:53:34 +0100
In-Reply-To: <200802201906.35830.david-b@pacbell.net> (David Brownell's
	message of "Wed\, 20 Feb 2008 19\:06\:35 -0800")
Message-ID: <87mypuagox.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: dbrownell@users.sourceforge.net, greg@kroah.com, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, stern@rowland.harvard.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "David" == David Brownell <david-b@pacbell.net> writes:

Hi,

 David>   +ccflags-$(CONFIG_USB_DEBUG)    += -DDEBUG

 David> It's a newish idiom, most easily applied to new code before
 David> it merges ...  :)

Ok. I'll fix that.

 David> And I realize that some of the drivers there have violated the
 David> normal "alphabetical order" convention, so maybe one big
 David> cleanup patch would be in order ... but still, I'd rather see
 David> such new options added in the right place, rather than need
 David> to see them fixed up later.

And this as well.

-- 
Bye, Peter Korsgaard
