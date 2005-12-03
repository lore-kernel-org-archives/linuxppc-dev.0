Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1FE3368802
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Dec 2005 08:24:05 +1100 (EST)
Date: Sat, 3 Dec 2005 13:24:02 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Otavio Salvador <otavio@debian.org>
Message-ID: <20051203212402.GA2821@gate.ebshome.net>
References: <11336368261610-git-send-email-otavio@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11336368261610-git-send-email-otavio@debian.org>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] include/asm-ppc/btext.h: add prototype of btext_init
	function.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 03, 2005 at 05:07:06PM -0200, Otavio Salvador wrote:
> The prototype of btext_init function was missing and then caused a compile
> warning.
> 
> ---
> 
>  include/asm-ppc/btext.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> applies-to: 60e8ae37378de2772b6b0768b12a49f923710152
> 786b869f9cfd4c1f82fbc8b20fa8cafb9188e12f
> diff --git a/include/asm-ppc/btext.h b/include/asm-ppc/btext.h
> index ccaefab..2329331 100644
> --- a/include/asm-ppc/btext.h
> +++ b/include/asm-ppc/btext.h
> @@ -18,6 +18,7 @@ extern boot_infos_t disp_bi;
>  extern int boot_text_mapped;
>  
>  extern void init_boot_display(void);
> +extern void __init btext_init(boot_infos_t *bi);
>  extern void btext_welcome(void);
>  extern void btext_prepare_BAT(void);
>  extern void btext_setup_display(int width, int height, int depth, int pitch,

"__init" should be placed between closing brace and semicolon. For 
more info, see include/linux/init.h

-- 
Eugene
