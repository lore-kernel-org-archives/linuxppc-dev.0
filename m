Return-Path: <greg@kroah.com>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CF09B2C0088
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2012 05:47:07 +1000 (EST)
Date: Fri, 21 Sep 2012 09:43:42 -0700
From: Greg KH <greg@kroah.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [PATCH v3] powerpc/usb: fix bug of CPU hang when missing USB PHY
 clock
Message-ID: <20120921164342.GA31272@kroah.com>
References: <1347958359-20153-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347958359-20153-1-git-send-email-Shengzhou.Liu@freescale.com>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 18, 2012 at 04:52:39PM +0800, Shengzhou Liu wrote:
> when missing USB PHY clock, kernel booting up will hang during USB
> initialization. We should check USBGP[PHY_CLK_VALID] bit to avoid
> CPU hanging in this case.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> v3 change: no check for UTMI PHY.
> v2 change: use spin_event_timeout() instead.
> 
>  drivers/usb/host/ehci-fsl.c |   57 +++++++++++++++++++++++++++++-------------
>  drivers/usb/host/ehci-fsl.h |    1 +
>  include/linux/fsl_devices.h |    1 +
>  3 files changed, 41 insertions(+), 18 deletions(-)

This is already applied, right?

greg k-h
