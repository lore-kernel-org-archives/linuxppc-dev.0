Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 11 Dec 2007 09:42:24 +1100
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Addition to the i2c series,
	copy the ppc mpc-i2c driver before changing it on powerpc
Message-ID: <20071210224224.GF24243@bakeyournoodle.com>
References: <9e4733910712101420o15b5e908jc7291a0086832467@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <9e4733910712101420o15b5e908jc7291a0086832467@mail.gmail.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2007 at 05:20:08PM -0500, Jon Smirl wrote:
> Copy mpc-i2c to preserve support for ARCH=ppc and allow changes on ARCH=powerpc
> 
> Temporarily copy the mpc-i2c driver to continue support for the ppc
> architecture until it is removed in mid-2008. This file should be
> deleted as part of ppc's final removal.

<snip?
> 
> diff --git a/Makefile b/Makefile
> index 013b43a..3e714e2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -35,7 +35,7 @@ MAKEFLAGS += -rR --no-print-directory
>  # To put more focus on warnings, be less verbose as default
>  # Use 'make V=1' to see the full commands
> 
> -ARCH=powerpc
> +ARCH=ppc
>  CROSS_COMPILE=powerpc-603e-linux-gnu-

Umm should this hunk be here?  My Makefile doen't have these 3 line at
all?

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
