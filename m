Return-Path: <greg@kroah.com>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF131DDF2A
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Aug 2008 09:34:15 +1000 (EST)
Date: Fri, 8 Aug 2008 16:26:35 -0700
From: Greg KH <greg@kroah.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 0/3] Patches to support QE USB Host Controller
Message-ID: <20080808232635.GB5352@kroah.com>
References: <20080808161717.GA19095@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080808161717.GA19095@polina.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 08, 2008 at 08:17:17PM +0400, Anton Vorontsov wrote:
> Hi all,
> 
> Most patches that were needed to support QE USB Host were merged during
> 2.6.27 merge window, and only three more patches left over. Here they
> are.
> 
> David, could you bear with gpio_to_chip() exported function, just as
> a stopgap for a proper api?

I'll hold off on the 3rd patch until david takes the first two.

thanks,

greg k-h
