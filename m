Date: Thu, 13 Nov 2003 17:40:29 -0800
From: Greg KH <greg@kroah.com>
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: drivers/usb/serial/whiteheat.c:1209: `CMSPAR' undeclared
Message-ID: <20031114014029.GU16352@kroah.com>
References: <20031014165543.GA8051@suse.de> <20031014183142.GC16605@kroah.com> <20031015192249.GB32543@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031015192249.GB32543@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 15, 2003 at 09:22:49PM +0200, Olaf Hering wrote:
>  On Tue, Oct 14, Greg KH wrote:
>
> > On Tue, Oct 14, 2003 at 06:55:43PM +0200, Olaf Hering wrote:
> > > Greg,
> > >
> > > maybe I asked that once, but:
> > > is there a fix?
> > >
> > >
> > >   CC [M]  drivers/usb/serial/whiteheat.o
> > > drivers/usb/serial/whiteheat.c: In function `firm_setup_port':
> > > drivers/usb/serial/whiteheat.c:1209: `CMSPAR' undeclared (first use in this function)
> >
> > That's defined in <asm/termbits.h>
> >
> > What platform are you building this on?
>
> I'm building on ppc32. A grep showed that alpha, ppc, and ppc64 do not
> have this define. google wasnt very helpful, 'CMSPAR ppc' shows one
> patch to add it and acm.c which just defines it to 0.
>
> So the question is, what should be changed?

Fix up the archs that do not define this?  That would probably be the
best thing to do.

thanks,

greg k-h

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
