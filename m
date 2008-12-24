Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 390F0DDE31
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Dec 2008 07:01:37 +1100 (EST)
Date: Wed, 24 Dec 2008 11:59:36 -0800
From: Greg KH <greg@kroah.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH -mm 1/3] USB: FHCI: Driver should be responsible for
	managing endpoint queues
Message-ID: <20081224195935.GA11531@kroah.com>
References: <20081223210322.GA2802@oksana.dev.rtsoft.ru>
	<20081224191303.GA21815@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081224191303.GA21815@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 24, 2008 at 10:13:03PM +0300, Anton Vorontsov wrote:
> Follow these changes for the FHCI driver:

Hm, would it just make more sense to respin the whole driver?  That way
it's never in the tree in a "broken" state?

thanks,

greg k-h
