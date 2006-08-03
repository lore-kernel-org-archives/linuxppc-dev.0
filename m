Return-Path: <trini@kernel.crashing.org>
Date: Wed, 2 Aug 2006 17:30:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage
Message-ID: <20060803003015.GX3075@smtp.west.cox.net>
References: <1154552346.5550.51.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1154552346.5550.51.camel@localhost>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 02, 2006 at 03:59:06PM -0500, Matthew McClintock wrote:

[snip]
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 01667d1..eefbe16 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -141,12 +141,13 @@ # Default to zImage, override when neede
>  defaultimage-y			:= zImage
>  defaultimage-$(CONFIG_PPC_ISERIES) := vmlinux
>  defaultimage-$(CONFIG_DEFAULT_UIMAGE) := uImage
> +defaultimage-$(CONFIG_DEFAULT_UIMAGE) := cuImage

This means we never default to a regular 'uImage', and should either
modify the existing line, or a DEFAULT_CUIMAGE.  No preference/etc, just
noting.

-- 
Tom Rini
