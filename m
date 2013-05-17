Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-da0-x22e.google.com (mail-da0-x22e.google.com
 [IPv6:2607:f8b0:400e:c00::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D9E302C0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 13:55:34 +1000 (EST)
Received: by mail-da0-f46.google.com with SMTP id e20so2081209dak.33
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 20:55:31 -0700 (PDT)
Date: Thu, 16 May 2013 18:15:23 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/512x: DMA via LocalPlus Bus testing driver
Message-ID: <20130517011523.GA9555@kroah.com>
References: <1367508195-2420-1-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367508195-2420-1-git-send-email-a13xp0p0v88@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, devicetree-discuss@lists.ozlabs.org,
 Timur Tabi <timur@tabi.org>, Rob Herring <rob.herring@calxeda.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Grant Likely <grant.likely@linaro.org>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 02, 2013 at 07:23:15PM +0400, Alexander Popov wrote:
> This module tests Direct Memory Access to some device on LocalPlus Bus
> for Freescale MPC512x. In other words it tests the bundle
> of mpc512x_lpbfifo and mpc512x_dma drivers.
> 
> This testing driver was multiply used with static RAM (CY62167EV30LL-45ZXI)
> which lives on LocalPlus Bus on our board. This testing driver was used
> instead of the original static RAM driver and it is an abnormal hack.
> That is why I just provide the driver code and don't modify any environment.
> 
> Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
> ---
>  drivers/misc/mpc512x_lpbdma_test.c | 310 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 310 insertions(+)
>  create mode 100644 drivers/misc/mpc512x_lpbdma_test.c

You obviously didn't test your testing driver to see if it would build
in the kernel source tree :(

Care to try again?
