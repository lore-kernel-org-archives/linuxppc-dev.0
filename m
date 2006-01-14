Return-Path: <greg@kroah.org>
Received: from aria.kroah.org (c-24-22-115-24.hsd1.or.comcast.net
	[24.22.115.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6C00689E8
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 15:19:13 +1100 (EST)
Date: Fri, 13 Jan 2006 19:49:03 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] remove unused tmp_buf_sem's
Message-ID: <20060114034903.GA23074@suse.de>
References: <17348.61824.49889.569928@jaguar.mkp.net>
	<20060114020816.GW29663@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060114020816.GW29663@stusta.de>
Cc: akpm@osdl.org, Jes Sorensen <jes@trained-monkey.org>, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	torvalds@osdl.org, R.E.Wolff@BitWizard.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 14, 2006 at 03:08:16AM +0100, Adrian Bunk wrote:
> <--  snip  -->
> 
> 
> tmp_buf_sem sems to be a common name for something completely unused...
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  arch/ia64/hp/sim/simserial.c  |    1 -
>  arch/ppc/4xx_io/serial_sicc.c |    1 -
>  drivers/char/amiserial.c      |    1 -
>  drivers/char/esp.c            |    1 -
>  drivers/char/generic_serial.c |    1 -
>  drivers/char/riscom8.c        |    1 -
>  drivers/char/serial167.c      |    1 -
>  drivers/char/specialix.c      |    3 ---
>  drivers/char/synclink.c       |    1 -
>  drivers/sbus/char/aurora.c    |    1 -
>  drivers/serial/68328serial.c  |    1 -
>  drivers/usb/serial/pl2303.c   |    2 --
>  12 files changed, 15 deletions(-)

usb portion is:
  Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
