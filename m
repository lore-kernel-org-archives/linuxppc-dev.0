Subject: Re: xgamma
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3C306F44.19B82F80@denise.shiny.it>
References: <3C2DC85D.145B4873@denise.shiny.it>
	<1009634451.2103.4.camel@pismo>  <3C2DD464.423D350C@denise.shiny.it>
	<1009653390.993.6.camel@pismo>  <3C306F44.19B82F80@denise.shiny.it>
Content-Type: text/plain; charset=ISO-8859-1
Date: 31 Dec 2001 16:26:11 +0100
Message-Id: <1009812371.2389.26.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2001-12-31 at 14:59, Giuliano Pochini wrote:
>
> > > > > xgamma has no effect with 2.4.17.
> > > >
> > > > I assume you're talking about aty128fb and running X with Option
> > > > "UseFBDev". Ben seems to have decided not to support this unfortunately.
> > >
> > > Yep.  Workarounds ?
> >
> > Use an older aty128fb where it at least kinda works
>
> Ok, I'll look for an older one.  btw, why gamma support has been removed ?
>
> > or don't use Option "UseFBDev" (broken with 4.1).
>
> I have 4.1.99.1. Without that opion X segfaults immediately.

With current CVS, adding a vgaHWGetIOBase() call like in the radeon
driver might suffice.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
