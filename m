Return-Path: <stern+49051fc8@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id B3A03DDE17
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 01:51:59 +1100 (EST)
Date: Mon, 3 Nov 2008 09:51:55 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [USB] powerpc: Workaround for the PPC440EPX USBH_23 errata [take
	3]
In-Reply-To: <20081103010620.46454456@vitb-lp>
Message-ID: <Pine.LNX.4.44L0.0811030951001.2454-100000@iolanthe.rowland.org>
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

On Mon, 3 Nov 2008, Vitaly Bordug wrote:

> A published errata for ppc440epx states, that when running Linux with both
> EHCI and OHCI modules loaded, the EHCI module experiences a fatal error
> when a high-speed device is connected to the USB2.0, and functions normally
> if OHCI module is not loaded.
> 
> There used to be recommendation to use only hi-speed or full-speed
> devices with specific conditions, when respective module was unloaded.
> Later, it was observed that ohci suspend is enough to keep things
> going, and it was turned into workaround, as explained below.

Please fix this patch so that it does not cause a build error on
non-PowerPC architectures.

Alan Stern
