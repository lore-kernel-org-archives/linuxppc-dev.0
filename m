Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75659DE1A7
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 03:02:52 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m7SH1LE9000833
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 10:02:44 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m7SGdBFe026707
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 11:39:11 -0500 (CDT)
Date: Thu, 28 Aug 2008 11:39:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH] usb: add Freescale QE/CPM USB peripheral controller driver
Message-ID: <20080828163910.GA1185@ld0162-tx32.am.freescale.net>
References: <1219916613-28827-1-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1219916613-28827-1-git-send-email-leoli@freescale.com>
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	dbrownell@users.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 28, 2008 at 05:43:33PM +0800, Li Yang wrote:
> +config USB_GADGET_FSL_QE
> +	boolean "Freescale QE/CPM USB Device Controller"
> +	depends on FSL_SOC && (QUICC_ENGINE || CPM)
> +	help
> +	   Some of Freescale PowerPC processors have a Full Speed
> +	   QE/CPM2 USB controller, which support device mode with 4
> +	   programmable endpoints. This driver supports the
> +	   controller in the MPC8360 and MPC8272, and should work with
> +	   controllers having QE or CPM2, given minor tweaks.
> +
> +	   Say "y" to link the driver statically, or "m" to build a
> +	   dynamically linked module called "fsl_qe_udc" and force all
> +	   gadget drivers to also be dynamically linked.

How can you say "m" to something that is not a tristate?

-Scott
