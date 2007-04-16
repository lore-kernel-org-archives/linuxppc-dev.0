Return-Path: <glikely@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.179])
	by ozlabs.org (Postfix) with ESMTP id B38E5DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 23:54:00 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id c29so1554713ika
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 06:53:58 -0700 (PDT)
Message-ID: <528646bc0704160653o315dd2fdq6f2c61ff752d3fa0@mail.gmail.com>
Date: Mon, 16 Apr 2007 07:53:58 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH] mpc5200: set efika's device_type to "soc"
In-Reply-To: <20070416071203.GJ18236@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070416071203.GJ18236@moe.telargo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/16/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> Device type should be "soc" (as in lite5200.dts), compatible is
> already set to "mpc5200".
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  arch/powerpc/kernel/prom_init.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: grant.git/arch/powerpc/kernel/prom_init.c
> ===================================================================
> --- grant.git.orig/arch/powerpc/kernel/prom_init.c
> +++ grant.git/arch/powerpc/kernel/prom_init.c
> @@ -2142,7 +2142,7 @@ static void __init fixup_device_tree_efi
>                                      3,12,0, 3,13,0, 3,14,0, 3,15,0 };
>         struct subst_entry efika_subst_table[] = {
>                 { "/",                  "device_type",  prop_cstr("efika") },
> -               { "/builtin",           "compatible",   prop_cstr("soc") },
> +               { "/builtin",           "device_type",  prop_cstr("soc") },
>                 { "/builtin/ata",       "compatible",   prop_cstr("mpc5200b-ata\0mpc5200-ata"), },
>                 { "/builtin/bestcomm",  "compatible",   prop_cstr("mpc5200b-bestcomm\0mpc5200-bestcomm") },
>                 { "/builtin/bestcomm",  "interrupts",   prop_bcomm_irq, sizeof(prop_bcomm_irq) },
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
