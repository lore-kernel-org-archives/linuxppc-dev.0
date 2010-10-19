Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 63C4FB7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Oct 2010 03:20:17 +1100 (EST)
Date: Tue, 19 Oct 2010 09:10:52 -0700
From: Greg KH <greg@kroah.com>
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH] mxc_udc: add workaround for ENGcm09152 for i.MX35
Message-ID: <20101019161052.GD20964@kroah.com>
References: <1287145858-10239-1-git-send-email-eric@eukrea.com>
	<20101015191005.GB8098@kroah.com> <4CB8AA76.2020309@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4CB8AA76.2020309@eukrea.com>
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

On Fri, Oct 15, 2010 at 09:24:38PM +0200, Eric Bénard wrote:
> Hi Greg,
> 
> Le 15/10/2010 21:10, Greg KH a écrit :
> >On Fri, Oct 15, 2010 at 02:30:58PM +0200, Eric Bénard wrote:
> >>this patch gives the possibility to workaround bug ENGcm09152
> >>on i.MX35 when the hardware workaround is also implemented on
> >>the board.
> >>It covers the workaround described on page 25 of the following Errata :
> >>http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf
> >>
> >>Signed-off-by: Eric Bénard<eric@eukrea.com>
> >>---
> >>  arch/arm/mach-mx3/mach-cpuimx35.c |    1 +
> >>  drivers/usb/gadget/fsl_mxc_udc.c  |   15 +++++++++++++++
> >>  include/linux/fsl_devices.h       |    3 +++
> >>  3 files changed, 19 insertions(+), 0 deletions(-)
> >
> >Do you want me to take this through my usb tree, or will it go through
> >some other developer's tree?
> >
> as most of the changes are in drivers/usb that would be great if you can take it.

No problem, now queued up.

greg k-h
