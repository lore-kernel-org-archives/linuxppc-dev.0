Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 827D7B7F49
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 01:24:03 +1100 (EST)
Date: Wed, 27 Jan 2010 15:23:49 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 0/8] Update support for MPC512x
Message-ID: <20100127152349.77fbb6de@wker>
In-Reply-To: <1264594052-20317-1-git-send-email-agust@denx.de>
References: <1264594052-20317-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: wd@denx.de, dzu@denx.de, linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, rtc-linux@googlegroups.com,
	Dan Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 27 Jan 2010 13:07:24 +0100
Anatolij Gustschin <agust@denx.de> wrote:

> This patch series brings support for the Freescale MPC512x
> processsors up to date:
> 
> powerpc/mpc5121: Add machine restart support
> rtc: Add MPC5121 Real time clock driver
> mtd: Add NAND Flash Controller driver
> dma: Add MPC512x DMA driver
> powerpc/mpc5121: add USB host support
> powerpc/mpc5121: shared DIU framebuffer support
> powerpc/mpc5121: update mpc5121ads DTS
> powerpc/mpc5121: Add default config for MPC5121ADS

Now your can also pull these patches from 
    git://git.denx.de/linux-2.6-denx.git mpc512x-v2.6.33-devel
Branch. FEC Patches for interested people are also provided
in this Branch.

Best regards,

Anatolij

--
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
