Date: Wed, 15 Oct 2003 21:22:49 +0200
From: Olaf Hering <olh@suse.de>
To: Greg KH <greg@kroah.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: drivers/usb/serial/whiteheat.c:1209: `CMSPAR' undeclared
Message-ID: <20031015192249.GB32543@suse.de>
References: <20031014165543.GA8051@suse.de> <20031014183142.GC16605@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20031014183142.GC16605@kroah.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Tue, Oct 14, Greg KH wrote:

> On Tue, Oct 14, 2003 at 06:55:43PM +0200, Olaf Hering wrote:
> > Greg,
> >
> > maybe I asked that once, but:
> > is there a fix?
> >
> >
> >   CC [M]  drivers/usb/serial/whiteheat.o
> > drivers/usb/serial/whiteheat.c: In function `firm_setup_port':
> > drivers/usb/serial/whiteheat.c:1209: `CMSPAR' undeclared (first use in this function)
>
> That's defined in <asm/termbits.h>
>
> What platform are you building this on?

I'm building on ppc32. A grep showed that alpha, ppc, and ppc64 do not
have this define. google wasnt very helpful, 'CMSPAR ppc' shows one
patch to add it and acm.c which just defines it to 0.

So the question is, what should be changed?

whitehead.c to use something else?
whitehead.c to add arch specific defines?
asm/termbits.h to add some dummy defines?
disable whitehead.o for alpha, ppc, ppc64 in Kconfig?


--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
