Date: Tue, 25 May 2004 11:53:11 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH 2/7] clean up apus support
In-Reply-To: <Pine.GSO.4.58.0405251112110.5948@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.58.0405251150440.13079@scrub.local>
References: <Pine.LNX.4.58.0405250227510.19017@scrub.local>
 <Pine.GSO.4.58.0405251112110.5948@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Tue, 25 May 2004, Geert Uytterhoeven wrote:

> On Tue, 25 May 2004, Roman Zippel wrote:
> > diff -u 2.6/arch/ppc/amiga/config.c:1.1.1.1 2.6/arch/ppc/amiga/config.c:1.2
> > --- 2.6/arch/ppc/amiga/config.c:1.1.1.1	Sat Jan 31 15:23:58 2004
> > +++ 2.6/arch/ppc/amiga/config.c	Wed Feb  4 13:21:34 2004
>
> > @@ -946,19 +782,14 @@
> >  	u_long mem;
> >  	int i;
> >
> > -	if (mach_get_model)
> > -		mach_get_model(model);
> > -	else
> > -		strcpy(model, "Unknown PowerPC");
> > +	amiga_get_model(model);
> >
> >  	len += sprintf(buffer+len, "Model:\t\t%s\n", model);
> > -	len += get_cpuinfo(buffer+len);
> > +	//len += get_cpuinfo(buffer+len);
>
> Now it just prints `Model:' and nothing more?

No, it's still followed by memory size and hw info.

bye, Roman

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
