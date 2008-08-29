Return-Path: <stern+48acf28e@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by ozlabs.org (Postfix) with SMTP id 23FF0DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 01:26:18 +1000 (EST)
Date: Fri, 29 Aug 2008 11:26:07 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
In-Reply-To: <1219963406.13162.368.camel@pasglop>
Message-ID: <Pine.LNX.4.44L0.0808291121180.4447-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-usb@vger.kernel.org,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Mark Miesfeld <mmiesfeld@amcc.com>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 29 Aug 2008, Benjamin Herrenschmidt wrote:

> I suppose some embedded platforms don't use CONFIG_PM, is this still a
> requirement for autosuspend ? Or do that happen always on an empty port
> nowadays ?

ohci-hcd doesn't automatically suspend the root hub if CONFIG_PM isn't
set.  However it isn't necessary to set CONFIG_SLEEP,
CONFIG_HIBERNATION, or CONFIG_USB_SUSPEND.

Alan Stern
