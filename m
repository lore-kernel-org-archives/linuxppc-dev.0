Return-Path: <stern+5039bcd2@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by ozlabs.org (Postfix) with SMTP id CE7172C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2012 00:40:38 +1000 (EST)
Date: Tue, 21 Aug 2012 10:33:55 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/usb: fix bug of CPU hang when missing USB
 PHY clock
In-Reply-To: <9F42EE26-7362-4B6E-8BD6-92EE02A07A1D@kernel.crashing.org>
Message-ID: <Pine.LNX.4.44L0.1208211033280.1462-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Liu Shengzhou-B36685 <B36685@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 20 Aug 2012, Kumar Gala wrote:

> >> Subject: Re: [PATCH 2/2] powerpc/usb: fix bug of CPU hang when missing USB PHY
> >> clock
> >> 
> >> 
> >> On Aug 10, 2012, at 5:48 AM, Shengzhou Liu wrote:
> >> 
> >>> when missing USB PHY clock, kernel booting up will hang during USB
> >>> initialization. We should check USBGP[PHY_CLK_VALID] bit to avoid CPU
> >>> hanging in this case.
> >>> 
> >>> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> >>> ---
> >>> drivers/usb/host/ehci-fsl.c |   63 ++++++++++++++++++++++++++++++-----------
> >> -
> >>> drivers/usb/host/ehci-fsl.h |    1 +
> >>> 2 files changed, 46 insertions(+), 18 deletions(-)
> >> 
> >> I assume this should be considered a bug fix and be looked at for inclusion in
> >> v3.6?
> >> 
> >> - k
> > [Shengzhou] Yes. 
> 
> Greg,
> 
> ping?

Greg is away on vacation for the rest of this week.

Alan Stern
