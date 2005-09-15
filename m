Return-Path: <linville@tuxdriver.com>
Date: Thu, 15 Sep 2005 10:07:01 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20050915140659.GA17670@tuxdriver.com>
References: <20050915160430.550d02ed.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050915160430.550d02ed.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: don't execute a temporary comment
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 15, 2005 at 04:04:30PM +1000, Stephen Rothwell wrote:

> --- a/arch/ppc/Makefile
> +++ b/arch/ppc/Makefile
> @@ -102,9 +102,9 @@ define archhelp
>    @echo '  *_defconfig     - Select default config from arch/$(ARCH)/ppc/configs'
>  endef
>  
> +# arch/$(ARCH)/include is a temporary hack until we have migrated to asm-powerpc
>  archclean:
>  	$(Q)$(MAKE) $(clean)=arch/ppc/boot
> -	# Temporary hack until we have migrated to asm-powerpc
>  	$(Q)rm -rf arch/$(ARCH)/include
>  
>  archprepare: checkbin

Why is this helpful?  Better in general to keep the commment near the code, no?

John
-- 
John W. Linville
linville@tuxdriver.com
