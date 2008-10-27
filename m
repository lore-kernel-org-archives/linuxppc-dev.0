Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.229])
	by ozlabs.org (Postfix) with ESMTP id 38BE5DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 03:53:06 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2048841rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 09:53:04 -0700 (PDT)
Message-ID: <fa686aa40810270953j38be56dbq22ccc3a10752a74f@mail.gmail.com>
Date: Mon, 27 Oct 2008 10:53:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "John Linn" <john.linn@xilinx.com>
Subject: Re: [PATCH][V2] [powerpc] GPIO: Adding new Xilinx driver
In-Reply-To: <20081027163908.0E79F5C8057@mail75-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081027163908.0E79F5C8057@mail75-dub.bigfish.com>
Cc: Kiran Sutariya <kirans@xilinx.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 27, 2008 at 10:39 AM, John Linn <john.linn@xilinx.com> wrote:
> This driver supports the Xilinx XPS GPIO IP core which has the typical
> GPIO features.
>
> Signed-off-by: Kiran Sutariya <kirans@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>
> ---
> V2 - Updated based on Anton's comments
>
>  drivers/gpio/Kconfig       |   15 ++--
>  drivers/gpio/Makefile      |    1 +
>  drivers/gpio/xilinx_gpio.c |  235 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 244 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/gpio/xilinx_gpio.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 7f2ee27..12a8006 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -127,13 +135,6 @@ config GPIO_PCF857X
>          This driver provides an in-kernel interface to those GPIOs using
>          platform-neutral GPIO calls.
>
> -config GPIO_TWL4030
> -       tristate "TWL4030, TWL5030, and TPS659x0 GPIOs"
> -       depends on TWL4030_CORE
> -       help
> -         Say yes here to access the GPIO signals of various multi-function
> -         power management chips from Texas Instruments.
> -

Looks like you've got some colateral damage in here.  Otherwise looks
right to me.

When you repost, please add my Signed-off-by line between yours and
Kiran's since I did a bunch of hacking on this driver too.  Also, make
use you post it to the LKML.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
