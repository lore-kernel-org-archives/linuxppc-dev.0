Date: Wed, 10 Dec 2003 08:31:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] boot/ld.script dependency missing
Message-ID: <20031210153155.GB23731@stop.crashing.org>
References: <20031201212931.GA10959@suse.de> <20031203160958.GF912@stop.crashing.org> <20031210122840.GA11183@suse.de> <20031210151548.GA23731@stop.crashing.org> <20031210151656.GA24156@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031210151656.GA24156@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Dec 10, 2003 at 04:16:56PM +0100, Olaf Hering wrote:
>  On Wed, Dec 10, Tom Rini wrote:
>
> > On Wed, Dec 10, 2003 at 01:28:40PM +0100, Olaf Hering wrote:
> >
> > >  On Wed, Dec 03, Tom Rini wrote:
> > >
> > > > On Mon, Dec 01, 2003 at 10:29:31PM +0100, Olaf Hering wrote:
> > > >
> > > > > fiddling with ld.script doesnt trigger a rebuild of the boot files.
> > >
> > > This one is for 2.4.23.
> >
> > This too is incomplete, as prep/ and simple/ also need the change.
> > Please update this, thanks.
>
> you mean this line in prep/Makefile?
>
> zImage: $(obj-y) $(LIBS) ../ld.script ../images/vmlinux.gz ../common/dummy.o \

And simple/ ?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
