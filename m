Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (lxorguk.ukuu.org.uk [81.2.110.251])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 492152C03BF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jul 2012 00:05:27 +1000 (EST)
Date: Fri, 20 Jul 2012 15:09:00 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH] mpc85xx_defconfig: add IDE support for MPC85xxCDS
Message-ID: <20120720150900.082afc7c@pyramind.ukuu.org.uk>
In-Reply-To: <1342788325-27609-1-git-send-email-chenhui.zhao@freescale.com>
References: <1342788325-27609-1-git-send-email-chenhui.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 20 Jul 2012 20:45:25 +0800
Zhao Chenhui <chenhui.zhao@freescale.com> wrote:

> Add IDE support for MPC85xxCDS.
> 
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> ---
>  arch/powerpc/configs/mpc85xx_defconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
> index 03ee911..45eda33 100644
> --- a/arch/powerpc/configs/mpc85xx_defconfig
> +++ b/arch/powerpc/configs/mpc85xx_defconfig
> @@ -105,6 +105,8 @@ CONFIG_BLK_DEV_RAM=y
>  CONFIG_BLK_DEV_RAM_SIZE=131072
>  CONFIG_MISC_DEVICES=y
>  CONFIG_EEPROM_LEGACY=y
> +CONFIG_IDE=y
> +CONFIG_BLK_DEV_VIA82CXXX=y

CONFIG_IDE is obsolete we shouldn't be adding it to anything as it will
eventually go away. Please use the ATA drivers.
