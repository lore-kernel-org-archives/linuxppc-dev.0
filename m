Return-Path: <geoff@infradead.org>
Message-ID: <1382561354.5204.51.camel@smoke>
Subject: Re: [Cbe-oss-dev] [PATCH 2/8] cell: Remove OOM message after
 input_allocate_device
From: Geoff Levand <geoff@infradead.org>
To: Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>
Date: Wed, 23 Oct 2013 13:49:14 -0700
In-Reply-To: <d4dc0be1a19693fca1d8d6bbd3a7ee75163cc269.1382555436.git.joe@perches.com>
References: <cover.1382555436.git.joe@perches.com>
 <d4dc0be1a19693fca1d8d6bbd3a7ee75163cc269.1382555436.git.joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joe,

On Wed, 2013-10-23 at 12:14 -0700, Joe Perches wrote:
> Emitting an OOM message isn't necessary after input_allocate_device
> as there's a generic OOM and a dump_stack already done.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/powerpc/platforms/cell/cbe_powerbutton.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/cell/cbe_powerbutton.c b/arch/powerpc/platforms/cell/cbe_powerbutton.c
> index 2bb8031..8804dbd 100644
> --- a/arch/powerpc/platforms/cell/cbe_powerbutton.c
> +++ b/arch/powerpc/platforms/cell/cbe_powerbutton.c
> @@ -58,7 +58,6 @@ static int __init cbe_powerbutton_init(void)
>  	dev = input_allocate_device();
>  	if (!dev) {
>  		ret = -ENOMEM;
> -		printk(KERN_ERR "%s: Not enough memory.\n", __func__);
>  		goto out;
>  	}

Arnd is out on leave, so I'll say that this looks OK.

Acked-by: Geoff Levand <geoff@infradead.org>
