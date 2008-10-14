Return-Path: <stern+48fbdcb8@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 10D11DE15D
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 02:07:07 +1100 (EST)
Date: Tue, 14 Oct 2008 11:00:25 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
	[take 2]
In-Reply-To: <20081014142512.2ebdde4c@vitb-lp>
Message-ID: <Pine.LNX.4.44L0.0810141059300.2546-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stefan Roese <sr@denx.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linux-usb@vger.kernel.org, Mark Miesfeld <mmiesfeld@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 14 Oct 2008, Vitaly Bordug wrote:

> A published errata for ppc440epx states, that when running Linux with both
> EHCI and OHCI modules loaded, the EHCI module experiences a fatal error
> when a high-speed device is connected to the USB2.0, and functions normally
> if OHCI module is not loaded.
> 
> There used to be recommendation to use only hi-speed or full-speed
> devices with specific conditions, when respective module was unloaded.
> Later, it was observed that ohci suspend is enough to keep things
> going, and it was turned into workaround, as explained below.

Have you tried building this on a non-PPC440EPx system?  It looks like 
this patch would cause a compile error.

Alan Stern
