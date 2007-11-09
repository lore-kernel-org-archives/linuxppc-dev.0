Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E2EECDDE34
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 04:19:11 +1100 (EST)
Date: Fri, 9 Nov 2007 11:15:03 -0600
From: Scott Wood <scottwood@freescale.com>
To: "vincent.liu" <vincent.liu@bmrtech.com>
Subject: Re: help  linux for linux2.6
Message-ID: <20071109171503.GA4479@loki.buserror.net>
References: <200711091434079212507@bmrtech.com>
	<200711091439036094772@bmrtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200711091439036094772@bmrtech.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 09, 2007 at 02:39:04PM +0800, vincent.liu wrote:
> These days I am working on a MPC8270 based board with linux 2.6.10 kernel.
> When I use the default kernel and load the uImage to the target board.
> The kernel hangs after uncompressing kernel image ... ok .

The "default kernel" for what board?

> I am freshman in the embedded linux area,So I do not know how to go on this project.
> From internet , I searched many articles,and no gain.

I suggest trying head-of-tree (with arch/powerpc, not arch/ppc) rather than
very old kernels, and making sure that the kernel you're building actually
supports your hardware.

-Scott
