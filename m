Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6A8272C008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 23:51:32 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc/usb: fix bug of CPU hang when missing USB PHY
 clock
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1344595712-12804-2-git-send-email-Shengzhou.Liu@freescale.com>
Date: Fri, 10 Aug 2012 08:50:02 -0500
Message-Id: <366E392A-9EAE-43C9-8666-808EA19C03EA@kernel.crashing.org>
References: <1344595712-12804-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1344595712-12804-2-git-send-email-Shengzhou.Liu@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 10, 2012, at 5:48 AM, Shengzhou Liu wrote:

> when missing USB PHY clock, kernel booting up will hang during USB
> initialization. We should check USBGP[PHY_CLK_VALID] bit to avoid
> CPU hanging in this case.
>=20
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> drivers/usb/host/ehci-fsl.c |   63 =
++++++++++++++++++++++++++++++------------
> drivers/usb/host/ehci-fsl.h |    1 +
> 2 files changed, 46 insertions(+), 18 deletions(-)

I assume this should be considered a bug fix and be looked at for =
inclusion in v3.6?

- k=
