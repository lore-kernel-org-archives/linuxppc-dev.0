Date: Thu, 6 Nov 2003 23:31:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] incorrect function declaration for claim()
Message-ID: <20031106223116.GA1790@mars.ravnborg.org>
References: <20031106202445.GA6293@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031106202445.GA6293@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 06, 2003 at 09:24:45PM +0100, Olaf Hering wrote:
> +++ linux-2.4/arch/ppc/boot/chrp/main.c	2003-11-06 21:21:26.000000000 +0100
> @@ -17,7 +17,7 @@ extern char _start, _end;
>
>  extern int getprop(void *, const char *, void *, int);
>  extern unsigned int heap_max;
> -extern void claim(unsigned int virt, unsigned int size, unsigned int align);
> +extern void *claim(unsigned int virt, unsigned int size, unsigned int align);
>  extern void *finddevice(const char *);
>  extern void flush_cache(void *, unsigned long);
>  extern void gunzip(void *, int, unsigned char *, int *);

In general I consider it a bug to have prototypes in a .c file....

	Sam

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
