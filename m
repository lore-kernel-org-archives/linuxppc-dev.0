Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4E112B70E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Oct 2010 06:18:10 +1100 (EST)
Date: Fri, 15 Oct 2010 12:10:05 -0700
From: Greg KH <greg@kroah.com>
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH] mxc_udc: add workaround for ENGcm09152 for i.MX35
Message-ID: <20101015191005.GB8098@kroah.com>
References: <1287145858-10239-1-git-send-email-eric@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1287145858-10239-1-git-send-email-eric@eukrea.com>
Cc: dbrownell@users.sourceforge.net, Dinh.Nguyen@freescale.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, gregkh@suse.de,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 15, 2010 at 02:30:58PM +0200, Eric Bénard wrote:
> this patch gives the possibility to workaround bug ENGcm09152
> on i.MX35 when the hardware workaround is also implemented on
> the board.
> It covers the workaround described on page 25 of the following Errata :
> http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf 
> 
> Signed-off-by: Eric Bénard <eric@eukrea.com>
> ---
>  arch/arm/mach-mx3/mach-cpuimx35.c |    1 +
>  drivers/usb/gadget/fsl_mxc_udc.c  |   15 +++++++++++++++
>  include/linux/fsl_devices.h       |    3 +++
>  3 files changed, 19 insertions(+), 0 deletions(-)

Do you want me to take this through my usb tree, or will it go through
some other developer's tree?

Either is fine with me.

thanks,

greg k-h
