Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A977ADDF40
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 19:18:41 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m7T9IZPL024701
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 02:18:35 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m7T9IXrY002045
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 04:18:34 -0500 (CDT)
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
From: Li Yang <leoli@freescale.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080828163910.GA1185@ld0162-tx32.am.freescale.net>
References: <1219916613-28827-1-git-send-email-leoli@freescale.com>
	<20080828163910.GA1185@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Fri, 29 Aug 2008 17:35:24 +0800
Message-Id: <1220002524.30607.18.camel@Gundam>
Mime-Version: 1.0
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	dbrownell@users.sourceforge.net, linuxppc-dev@ozlabs.org
Reply-To: leoli@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-08-28 at 11:39 -0500, Scott Wood wrote:
> On Thu, Aug 28, 2008 at 05:43:33PM +0800, Li Yang wrote:
> > +config USB_GADGET_FSL_QE
> > +	boolean "Freescale QE/CPM USB Device Controller"
> > +	depends on FSL_SOC && (QUICC_ENGINE || CPM)
> > +	help
> > +	   Some of Freescale PowerPC processors have a Full Speed
> > +	   QE/CPM2 USB controller, which support device mode with 4
> > +	   programmable endpoints. This driver supports the
> > +	   controller in the MPC8360 and MPC8272, and should work with
> > +	   controllers having QE or CPM2, given minor tweaks.
> > +
> > +	   Say "y" to link the driver statically, or "m" to build a
> > +	   dynamically linked module called "fsl_qe_udc" and force all
> > +	   gadget drivers to also be dynamically linked.
> 
> How can you say "m" to something that is not a tristate?

Well, I copied these from other udc drivers.  Udc drivers can be
compiled as module, through the CONFIG_USB_GADGET option.  Though, the
description here is not accurate.

- Leo
