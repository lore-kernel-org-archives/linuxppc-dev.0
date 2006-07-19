Return-Path: <mgreer@mvista.com>
Date: Wed, 19 Jul 2006 16:33:43 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 5/6] bootwrapper: Add support for the DINK firmware
Message-ID: <20060719233343.GH3887@mag.az.mvista.com>
References: <20060719231421.GF3887@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060719231421.GF3887@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 19, 2006 at 04:14:21PM -0700, Mark A. Greer wrote:
> This patch adds the firmware operations that support the DINK firmware
> from Freescale.
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> --
> 
>  dink.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 56 insertions(+)
> --
> 
> diff --git a/arch/powerpc/boot/dink.c b/arch/powerpc/boot/dink.c
> new file mode 100644
> index 0000000..aa446e2
> --- /dev/null
> +++ b/arch/powerpc/boot/dink.c
> @@ -0,0 +1,56 @@
> +/*
> + * Sandpoint specific fixups.

Obviously an incorrect comment.  Will fix.

Mark
--
