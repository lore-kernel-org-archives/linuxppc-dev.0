Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by ozlabs.org (Postfix) with ESMTP id 659232C0091
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 12:00:49 +1100 (EST)
Date: Thu, 17 Jan 2013 09:31:50 +0900
From: Simon Horman <horms@verge.net.au>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 3/6] usb: otg: utils: change the phy lib to support
 multiple PHYs of same type
Message-ID: <20130117003150.GF19552@verge.net.au>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <1358348462-27693-4-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358348462-27693-4-git-send-email-kishon@ti.com>
Cc: linux-doc@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk,
 linux-sh@vger.kernel.org, alexander.shishkin@linux.intel.com,
 stern@rowland.harvard.edu, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, rob.herring@calxeda.com,
 haojian.zhuang@gmail.com, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, eric.y.miao@gmail.com, b-cousson@ti.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, balbi@ti.com, cbou@mail.ru, rob@landley.net,
 dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 16, 2013 at 08:30:59PM +0530, Kishon Vijay Abraham I wrote:
> In order to add support for multipe PHY's of the same type, the API's
> for adding PHY and getting PHY has been changed. Now the binding
> information of the PHY and controller should be done in platform file
> using usb_bind_phy API. And for getting a PHY, the device pointer of the
> USB controller and an index should be passed. Based on the binding
> information that is added in the platform file, get_phy will return the
> approappropriate PHY.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/mach-shmobile/board-marzen.c |    2 +-

Modification to the above file:

Acked-by: Simon Horman <horms+renesas@verge.net.au>
