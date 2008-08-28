Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8D576DE3E2
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 08:43:46 +1000 (EST)
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <Pine.LNX.4.44L0.0808281727090.4308-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0808281727090.4308-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Fri, 29 Aug 2008 08:43:26 +1000
Message-Id: <1219963406.13162.368.camel@pasglop>
Mime-Version: 1.0
Cc: linux-usb@vger.kernel.org,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Mark Miesfeld <mmiesfeld@amcc.com>, Stefan Roese <sr@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-08-28 at 17:33 -0400, Alan Stern wrote:
> Is there some reason why it doesn't work already?  All the patch does
> is suspend the OHCI root hub when you plug in the memory stick -- but
> the root hub should already be suspended.
> 
> Unless the memory stick is already plugged in when the kernel boots.  
> In which case the root hub won't be suspended -- it won't suspend
> until 
> 1 second after ohci-hcd initializes the controller.  Is that the 
> scenario you're worried about?

I suppose some embedded platforms don't use CONFIG_PM, is this still a
requirement for autosuspend ? Or do that happen always on an empty port
nowadays ?

Cheers,
Ben.
