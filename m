Date: Tue, 25 May 2004 11:13:32 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH 2/7] clean up apus support
In-Reply-To: <Pine.LNX.4.58.0405250227510.19017@scrub.local>
Message-ID: <Pine.GSO.4.58.0405251112110.5948@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0405250227510.19017@scrub.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 25 May 2004, Roman Zippel wrote:
> diff -u 2.6/arch/ppc/amiga/config.c:1.1.1.1 2.6/arch/ppc/amiga/config.c:1.2
> --- 2.6/arch/ppc/amiga/config.c:1.1.1.1	Sat Jan 31 15:23:58 2004
> +++ 2.6/arch/ppc/amiga/config.c	Wed Feb  4 13:21:34 2004

> @@ -946,19 +782,14 @@
>  	u_long mem;
>  	int i;
>
> -	if (mach_get_model)
> -		mach_get_model(model);
> -	else
> -		strcpy(model, "Unknown PowerPC");
> +	amiga_get_model(model);
>
>  	len += sprintf(buffer+len, "Model:\t\t%s\n", model);
> -	len += get_cpuinfo(buffer+len);
> +	//len += get_cpuinfo(buffer+len);

Now it just prints `Model:' and nothing more?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
